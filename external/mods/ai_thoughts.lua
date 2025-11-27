--[[
 ###########################################################################
 #  AI Thoughts Module – Phase 3 (Intelligence System)                     #
 ###########################################################################
 #  What this file does now:                                              #
 #    * Reads the shared AI vars (thought ID 51 / category 52).           #
 #    * Provides 30+ labelled, colour-coded thought strings.               #
 #    * Handles independent text slots per player with hold timers.       #
 #                                                                        #
 #  How to customise (no Lua knowledge needed):                            #
 #    1. Update SETTINGS for fonts / colours / timer duration / positions.#
 #    2. Extend THOUGHTS (mapping numbers to text) or CATEGORY_STYLES.    #
 #    3. Restart Ikemen GO after editing so the module reloads.           #
 ###########################################################################
]]

local moduleName = 'ai_thoughts'
local aiThoughts = {}

config = config or {}
if config.ShowAIThoughts == nil then
	config.ShowAIThoughts = true
end
if config.AIThoughtSlots == nil then
	config.AIThoughtSlots = 2
end

local function getLocalCoord()
	if motif and motif.info and motif.info.localcoord then
		return motif.info.localcoord[1], motif.info.localcoord[2]
	end
	return 320, 240
end

local function buildDefaultSlots()
	local width = select(1, getLocalCoord())
	local portraitWidth = 48
	local hudGap = 12
	local slotWidth = 180
	local leftOffset = portraitWidth + hudGap
	local top = 30
	return {
		[1] = {left = leftOffset, y = top, width = slotWidth},
		[2] = {left = width - leftOffset - slotWidth, y = top, width = slotWidth},
		[3] = {left = leftOffset, y = top + 18, width = slotWidth},
		[4] = {left = width - leftOffset - slotWidth, y = top + 18, width = slotWidth},
	}
end

if options then
	options.t_itemname = options.t_itemname or {}
	options.t_vardisplay = options.t_vardisplay or {}
	options.t_vardisplay.aithoughts = function()
		return options.f_boolDisplay(config.ShowAIThoughts)
	end
	options.t_itemname.aithoughts = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_done_snd[1], motif.option_info.cursor_done_snd[2])
			config.ShowAIThoughts = not config.ShowAIThoughts
			if t and t.items and t.items[item] then
				t.items[item].vardisplay = options.t_vardisplay.aithoughts()
			end
			options.modified = true
		end
		return true
	end
	local function slotDisplay()
		if config.AIThoughtSlots == 1 then
			return 'Right Only'
		end
		return 'Both'
	end
	options.t_vardisplay.aithoughtslots = slotDisplay
	options.t_itemname.aithoughtslots = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'pal', 's'}) or main.f_input(main.t_players, {'$F'}) or main.f_input(main.t_players, {'$B'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.AIThoughtSlots == 1 then
				config.AIThoughtSlots = 2
			else
				config.AIThoughtSlots = 1
			end
			if t and t.items and t.items[item] then
				t.items[item].vardisplay = options.t_vardisplay.aithoughtslots()
			end
			options.modified = true
		end
		return true
	end
end

local function injectOptionItems()
	if aiThoughts.optionsInjected then
		return
	end
	if not options or not options.menu or not options.menu.submenu or not options.menu.submenu.menuengine then
		return
	end
	local submenu = options.menu.submenu.menuengine
	local t_menuWindow = main.f_menuWindow(motif.option_info)
	local function makeEntry(id, label, displayFn)
		return {
			data = text:create({window = t_menuWindow}),
			itemname = id,
			displayname = label,
			vardata = text:create({window = t_menuWindow}),
			vardisplay = displayFn(),
			selected = false,
		}
	end
	local insertIndex = #submenu.items + 1
	for i, entry in ipairs(submenu.items) do
		if entry.itemname == 'back' then
			insertIndex = i
			break
		end
	end
	table.insert(submenu.items, insertIndex, makeEntry('aithoughts', 'AI Thoughts', options.t_vardisplay.aithoughts))
	table.insert(submenu.items, insertIndex + 1, makeEntry('aithoughtslots', 'Thought Slots', options.t_vardisplay.aithoughtslots))
	aiThoughts.optionsInjected = true
end

hook.add('options.menu.loop', moduleName .. '.optionsInject', injectOptionItems)

-----------------------------------------------------------------------------
-- SETTINGS (safe to edit)
-----------------------------------------------------------------------------
local settings = {
	enabled = true,
	thoughtVar = 51,
	categoryVar = 52,
	maxTrackedPlayers = 4,
	font = 'jg.fnt',
	fontHeight = -1,
	fontBank = 0,
	scale = {x = 1, y = 1},
	playerSlots = buildDefaultSlots(),
	defaultColor = {r = 255, g = 255, b = 255},
	categoryStyles = {
		neutral = {r = 255, g = 255, b = 255},
		offense = {r = 255, g = 140, b = 140},
		defense = {r = 140, g = 180, b = 255},
		trick = {r = 255, g = 220, b = 140},
		recover = {r = 160, g = 255, b = 160},
		pressure = {r = 255, g = 200, b = 80},
		strategy = {r = 200, g = 255, b = 200},
		emotion = {r = 255, g = 180, b = 255},
	},
	display = {
		minHoldFrames = 90,
		commitFrames = 10,
		minGapFrames = 18,
		fadeStep = 0.08,
	},
	bubble = {
		width = 180,
		padding = {x = 12, y = 4},
		maxCharsPerLine = 22,
		maxLines = 2,
		lineHeight = 15,
		shadowOffset = {x = 1, y = 1},
		bgColor = {r = 12, g = 12, b = 18, src = 200, dst = 60},
		borderColor = {r = 255, g = 255, b = 255, src = 60, dst = 0},
		shadowColor = {r = 15, g = 15, b = 15},
		textScale = 0.78,
		baseline = 6,
	},
}

-----------------------------------------------------------------------------
-- THOUGHT DICTIONARY (edit/add entries here)
-----------------------------------------------------------------------------
local categoryLookup = {
	[0] = 'neutral',
	[1] = 'offense',
	[2] = 'defense',
	[3] = 'trick',
	[4] = 'recover',
	[5] = 'pressure',
	[6] = 'strategy',
	[7] = 'emotion',
}

local thoughts = {
	[0] = {text = '', category = 'neutral'},
	[1] = {text = {'Assessing...', 'Reading the room', 'Thinking it through'}, category = 'neutral'},
	[10] = {text = {'Opening read', 'Feeling them out', 'First download'}, category = 'neutral'},
	[11] = {text = {'Footsies range', 'Mid screen check', 'Spacing battle'}, category = 'neutral'},
	[12] = {text = {'Close-quarters scramble', 'In the blender', 'Tight scramble'}, category = 'neutral'},
	[13] = {text = {'Anti-air ready', "Don't jump", 'Watch the skies'}, category = 'defense'},
	[14] = {text = {'Guarding up', 'Turtle up', 'High guard'}, category = 'defense'},
	[15] = {text = {'Setting a bait...', 'Lure them out', 'Feint and punish'}, category = 'trick'},
	[16] = {text = {'Exploit their recovery', 'Punish the whiff', 'Catch the landing'}, category = 'offense'},
	[17] = {text = {'Extend the combo', 'Keep it going', 'Route continues'}, category = 'offense'},
	[18] = {text = {'Finish it!', 'Cash out now', 'End the round'}, category = 'offense'},
	[19] = {text = {'Corner squeeze', 'Pin them in', 'No escape corner'}, category = 'pressure'},
	[20] = {text = {'Need to escape corner', 'Cornered, find exit', 'Back to mid-screen'}, category = 'defense'},
	[21] = {text = {'Keepaway lead', 'Play lame, stay safe', 'Stay out, chip clock'}, category = 'strategy'},
	[22] = {text = {'Regroup and breathe', 'Slow it down', 'Reset pace'}, category = 'recover'},
	[23] = {text = {'Need more meter', 'Build bar first', 'Charge up'}, category = 'strategy'},
	[24] = {text = {'Pattern spotted', 'Habits found', 'Read locked in'}, category = 'trick'},
	[25] = {text = {'Switching plans...', 'Change approach', 'Swap strategy'}, category = 'trick'},
	[26] = {text = {'Frustrated...', 'Getting annoyed', 'Need to reset mind'}, category = 'emotion'},
	[27] = {text = {'Confidence rising', 'Feeling momentum', 'Got the read'}, category = 'emotion'},
	[28] = {text = {'Time is on my side', 'Clock is my ally', 'Win by time'}, category = 'strategy'},
	[29] = {text = {'Clock pressure!', 'Time is burning!', 'Hurry before zero'}, category = 'emotion'},
	[30] = {text = {'Chasing that jump', 'Hunt the air', 'Track their leap'}, category = 'offense'},
	[31] = {text = {'Air assault!', 'Aerial rush', 'Jump offense'}, category = 'offense'},
	[32] = {text = {'Punish the whiff', 'Catch recovery', 'Tag their miss'}, category = 'offense'},
	[33] = {text = {'That hurt!', 'Big damage taken', 'Ouch, watch life'}, category = 'emotion'},
	[34] = {text = {'Under fire!', 'Getting mauled', 'Pinned down'}, category = 'defense'},
	[35] = {text = {'Critical health!', 'Danger, one more', 'Low life alarm'}, category = 'recover'},
	[36] = {text = {'Set up oki', 'Oki time', 'Prepare wakeup'}, category = 'pressure'},
	[37] = {text = {'Wake up carefully', 'Meaty incoming', 'Mind the wake'}, category = 'defense'},
}

-----------------------------------------------------------------------------
-- INTERNAL STATE (nothing to edit below unless extending the system)
-----------------------------------------------------------------------------
local playerSlots = {}
local playerStates = {}
local function slotEnabled(pn)
	if config.AIThoughtSlots == 1 then
		return pn % 2 == 0
	end
	return true
end

local function wrapText(source)
	local maxChars = settings.bubble.maxCharsPerLine
	local maxLines = settings.bubble.maxLines
	local lines, current = {}, ''
	for word in source:gmatch('%S+') do
		local candidate = current == '' and word or (current .. ' ' .. word)
		if #candidate > maxChars then
			if current ~= '' then
				table.insert(lines, current)
				current = word
			else
				table.insert(lines, candidate)
				current = ''
			end
		else
			current = candidate
		end
		if #lines >= maxLines then
			current = ''
			break
		end
	end
	if current ~= '' and #lines < maxLines then
		table.insert(lines, current)
	end
	if #lines == 0 then
		lines[1] = source
	end
	return table.concat(lines, '\n'), #lines
end

local function selectText(thought)
	if thought == nil then
		return ''
	end
	local t = thought.text
	if type(t) == 'table' then
		if #t == 0 then
			return ''
		end
		return t[math.random(#t)] or ''
	end
	return t or ''
end

local function pickSlotConfig(pn)
	if playerSlots[pn] then
		return playerSlots[pn]
	end
	local fallback = settings.playerSlots[pn]
	if fallback == nil then
		local keys = {}
		for key in pairs(settings.playerSlots) do
			table.insert(keys, key)
		end
		table.sort(keys)
		if #keys > 0 then
			local recycledKey = keys[((pn - 1) % #keys) + 1]
			fallback = settings.playerSlots[recycledKey]
		end
	end
	playerSlots[pn] = fallback or {left = 40, y = 40, width = settings.bubble.width}
	return playerSlots[pn]
end

local function createLabel()
	return text:create({
		font = settings.font,
		height = settings.fontHeight,
		bank = settings.fontBank,
		text = '',
		align = -1,
		x = 0,
		y = 0,
		scaleX = settings.scale.x,
		scaleY = settings.scale.y,
		r = settings.defaultColor.r,
		g = settings.defaultColor.g,
		b = settings.defaultColor.b,
	})
end

local function ensurePlayerState(pn)
	if playerStates[pn] == nil then
		local slotCfg = pickSlotConfig(pn)
		playerStates[pn] = {
			cfg = slotCfg,
			label = createLabel(),
			shadow = createLabel(),
			bg = rect:create({
				x1 = 0,
				y1 = 0,
				x2 = settings.bubble.width,
				y2 = settings.bubble.lineHeight + settings.bubble.padding.y * 2,
				r = settings.bubble.bgColor.r,
				g = settings.bubble.bgColor.g,
				b = settings.bubble.bgColor.b,
				src = settings.bubble.bgColor.src,
				dst = settings.bubble.bgColor.dst,
			}),
			border = rect:create({
				x1 = 0,
				y1 = 0,
				x2 = settings.bubble.width,
				y2 = settings.bubble.lineHeight + settings.bubble.padding.y * 2,
				r = settings.bubble.borderColor.r,
				g = settings.bubble.borderColor.g,
				b = settings.bubble.borderColor.b,
				src = settings.bubble.borderColor.src,
				dst = settings.bubble.borderColor.dst,
			}),
			id = 0,
			category = 'neutral',
			timer = 0,
			fade = 0,
			cooldown = 0,
			pendingId = 0,
			pendingCategory = 'neutral',
			pendingFrames = 0,
			bubbleLeft = slotCfg.x,
			bubbleHeight = settings.bubble.lineHeight + settings.bubble.padding.y * 2,
		}
		playerStates[pn].shadow:update({
			r = settings.bubble.shadowColor.r,
			g = settings.bubble.shadowColor.g,
			b = settings.bubble.shadowColor.b,
		})
	end
	return playerStates[pn]
end

local function positionBubble(state, text, colour)
	local slot = state.cfg or {}
	local bubbleWidth = slot.width or settings.bubble.width
	local anchorY = slot.y or 0
	local formatted, lineCount = wrapText(text or '')
	lineCount = math.max(1, math.min(settings.bubble.maxLines, lineCount))
	local bubbleHeight = (lineCount * settings.bubble.lineHeight) + settings.bubble.padding.y * 2
	local width, _ = getLocalCoord()
	local left = slot.left or 0
	left = math.max(4, math.min(left, width - bubbleWidth - 4))
	local textX = left + bubbleWidth * 0.5
	local textY = anchorY + settings.bubble.padding.y + (settings.bubble.baseline or 0)
	local scaleMul = settings.bubble.textScale or 1

	state.label:update({
		align = 0,
		x = textX,
		y = textY,
		text = formatted,
		scaleX = settings.scale.x * scaleMul,
		scaleY = settings.scale.y * scaleMul,
		r = colour.r or settings.defaultColor.r,
		g = colour.g or settings.defaultColor.g,
		b = colour.b or settings.defaultColor.b,
	})
	state.shadow:update({
		align = 0,
		x = textX + settings.bubble.shadowOffset.x,
		y = textY + settings.bubble.shadowOffset.y,
		text = formatted,
		scaleX = settings.scale.x * scaleMul,
		scaleY = settings.scale.y * scaleMul,
	})
	state.bg:update({
		x1 = left,
		y1 = anchorY,
		x2 = bubbleWidth,
		y2 = bubbleHeight,
	})
	state.border:update({
		x1 = left - 2,
		y1 = anchorY - 2,
		x2 = bubbleWidth + 4,
		y2 = bubbleHeight + 4,
		r = colour.r or settings.bubble.borderColor.r,
		g = colour.g or settings.bubble.borderColor.g,
		b = colour.b or settings.bubble.borderColor.b,
	})
	state.bubbleLeft = left
	state.bubbleHeight = bubbleHeight
end

local function applyThought(state, id, categoryKey)
	local thought = thoughts[id] or thoughts[0]
	local key = categoryKey or thought.category or 'neutral'
	local colour = settings.categoryStyles[key] or settings.defaultColor
	positionBubble(state, selectText(thought), colour)
	state.id = id
	state.category = key
	state.timer = settings.display.minHoldFrames
	state.fade = 1
	state.cooldown = settings.display.minGapFrames
	state.pendingId = 0
	state.pendingCategory = 'neutral'
	state.pendingFrames = 0
end

local function decayThought(state)
	if state.timer > 0 then
		state.timer = state.timer - 1
	else
		state.fade = math.max(0, state.fade - settings.display.fadeStep)
	end
end

local function resetThought(state)
	state.timer = 0
	state.id = 0
	state.category = 'neutral'
	state.fade = 0
	state.pendingId = 0
	state.pendingFrames = 0
	state.label:update({text = ''})
	state.shadow:update({text = ''})
end

local function fetchThoughtVars()
	return {
		id = math.floor(var(settings.thoughtVar) or 0),
		categoryIndex = math.floor(var(settings.categoryVar) or 0),
	}
end

local function processThoughtState(state, vars)
	if vars.id > 0 then
		local categoryKey = categoryLookup[vars.categoryIndex] or (thoughts[vars.id] and thoughts[vars.id].category) or 'neutral'
		if state.id == vars.id then
			state.timer = settings.display.minHoldFrames
			state.pendingId = 0
		else
			if state.pendingId ~= vars.id or state.pendingCategory ~= categoryKey then
				state.pendingId = vars.id
				state.pendingCategory = categoryKey
				state.pendingFrames = 1
			else
				state.pendingFrames = state.pendingFrames + 1
				if state.pendingFrames >= settings.display.commitFrames and state.cooldown <= 0 then
					applyThought(state, vars.id, categoryKey)
				end
			end
		end
	else
		state.pendingId = 0
		state.pendingCategory = 'neutral'
		state.pendingFrames = 0
	end
	if state.cooldown > 0 then
		state.cooldown = state.cooldown - 1
	end
	decayThought(state)
	if state.fade <= 0 and state.id ~= 0 then
		resetThought(state)
	end
end

local function updatePlayerSlot(pn, isAI)
	local previousId = id()
	if player(pn) then
		local state = ensurePlayerState(pn)
		if isAI then
			local vars = fetchThoughtVars()
			processThoughtState(state, vars)
		else
			resetThought(state)
		end
	else
		local existing = playerStates[pn]
		if existing then
			resetThought(existing)
		end
	end
	playerid(previousId)
end

local function drawActiveThoughts()
	for _, state in pairs(playerStates) do
		if state.fade and state.fade > 0 then
			local bgSrc = math.floor(settings.bubble.bgColor.src * state.fade)
			local borderSrc = math.floor(settings.bubble.borderColor.src * state.fade)
			state.border:update({src = borderSrc})
			state.bg:update({src = bgSrc})
			state.border:draw()
			state.bg:draw()
			if state.fade > 0.05 then
				state.shadow:draw()
				state.label:draw()
			end
		end
	end
end

local function shouldProcess()
	if not settings.enabled then
		return false
	end
	if config.ShowAIThoughts == false then
		return false
	end
	if roundstate == nil then
		return false
	end
	return roundstate() >= 0
end

local function loopHook()
	if not shouldProcess() then
		return
	end
	local originalId = id()
	for pn = 1, settings.maxTrackedPlayers do
		local isAI = false
		if player(pn) then
			isAI = (ailevel() or 0) > 0
		end
		playerid(originalId)
		if slotEnabled(pn) then
			updatePlayerSlot(pn, isAI)
		else
			updatePlayerSlot(pn, false)
		end
	end
	drawActiveThoughts()
end

hook.add('loop', moduleName .. '.loop', loopHook)

return aiThoughts
