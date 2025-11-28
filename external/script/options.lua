local options = {}
--;===========================================================
--; COMMON
--;===========================================================
options.modified = false
options.needReload = false
if config.CustomAIDifficulty == nil then
	config.CustomAIDifficulty = math.min(8, math.max(1, config.Difficulty or 5))
end

--return string depending on bool
function options.f_boolDisplay(bool, t, f)
	if bool == true then
		return t or motif.option_info.menu_valuename_yes
	end
	return f or motif.option_info.menu_valuename_no
end

--return table entry (or ret if specified) if provided key exists in the table, otherwise return default argument
function options.f_definedDisplay(key, t, default, ret)
	if key ~= nil and t[key] ~= nil then
		return ret or t[key]
	end
	return default
end

--return correct precision
function options.f_precision(v, decimal)
	return tonumber(string.format(decimal, v))
end

--save configuration
function options.f_saveCfg(reload)
	--Data saving to config.json
	main.f_fileWrite(main.flags['-config'], json.encode(config, {indent = 2}))
	--Reload game if needed
	if reload then
		main.f_warning(main.f_extractText(motif.warning_info.text_reload_text), motif.optionbgdef)
		os.exit()
	end
end

options.txt_title = main.f_createTextImg(motif.option_info, 'title', {defsc = motif.defaultOptionsTitle})

--;===========================================================
--; LOOPS
--;===========================================================
local txt_textinput = main.f_createTextImg(motif.option_info, 'textinput', {defsc = motif.defaultOptions})
local overlay_textinput = main.f_createOverlay(motif.option_info, 'textinput_overlay')

function options.f_displayRatio(value)
	local ret = options.f_precision((value - 1) * 100, '%.01f')
	if ret >= 0 then
		return '+' .. ret .. '%'
	end
	return ret .. '%'
end

local function f_externalShaderName()
	if #config.ExternalShaders > 0 and config.PostProcessingShader ~= 0 then
		return config.ExternalShaders[1]:gsub('^.+/', '')
	end
	return motif.option_info.menu_valuename_disabled
end

-- Associative elements table storing functions controlling behaviour of each
-- option screen item. Can be appended via external module.
options.t_itemname = {
	--Back
	['back'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cancel_snd[1], motif.option_info.cancel_snd[2])
			return false
		end
		return true
	end,
	--Port Change
	['portchange'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			local port = main.f_drawInput(
				main.f_extractText(motif.option_info.textinput_port_text),
				txt_textinput,
				overlay_textinput,
				motif.option_info.textinput_offset[2],
				main.f_ySpacing(motif.option_info, 'textinput'),
				motif.optionbgdef
			)
			if tonumber(port) ~= nil then
				sndPlay(motif.files.snd_data, motif.option_info.cursor_done_snd[1], motif.option_info.cursor_done_snd[2])
				config.ListenPort = tostring(port)
				setListenPort(port)
				t.items[item].vardisplay = getListenPort()
				options.modified = true
			else
				sndPlay(motif.files.snd_data, motif.option_info.cancel_snd[1], motif.option_info.cancel_snd[2])
			end
		end
		return true
	end,
	--Default Values
	['default'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_done_snd[1], motif.option_info.cursor_done_snd[2])
			config.AIRamping = true
			config.AIRandomColor = false
			config.AISurvivalColor = true
			config.AudioDucking = false
			--config.AudioSampleRate = 44100
			config.AutoGuard = false
			--config.BackgroundLoading = false
			config.BarGuard = false
			config.BarRedLife = true
			config.BarStun = false
			--config.Borderless = false
			--config.ComboExtraFrameWindow = 0
			--config.CommonAir = "data/common.air"
			--config.CommonCmd = "data/common.cmd"
			--config.CommonConst = "data/common.const"
			--config.CommonLua = {
			--	"loop()"
			--}
			--config.CommonStates = {
			--	"data/action.zss",
			--	"data/dizzy.zss",
			--	"data/guardbreak.zss",
			--	"data/score.zss",
			--	"data/tag.zss",
			--	"data/training.zss"
			--}
			--config.ControllerStickSensitivity = 0.4
			config.Credits = 10
			--config.DebugClipboardRows = 2
			--config.DebugClsnDarken = true
			--config.DebugConsoleRows = 15
			--config.DebugFont = "font/debug.def"
			--config.DebugFontScale = 1
			config.DebugKeys = true
			config.DebugMode = true
			config.Difficulty = 5
			config.CustomAIDifficulty = 5
			--config.EscOpensMenu = true
			config.ExternalShaders = {}
			--config.FirstRun = false
			--config.FontShaderVer = 120
			--config.ForceStageZoomin = 0
			--config.ForceStageZoomout = 0
			--config.Framerate = 60
			config.Fullscreen = false
			--config.FullscreenRefreshRate = 60
			--config.FullscreenWidth = -1
			--config.FullscreenHeight = -1
			config.GameWidth = 640
			config.GameHeight = 480
			config.GameFramerate = 60
			--config.IP = {}
			config.LifeMul = 100
			config.ListenPort = "7500"
			config.LoseSimul = true
			config.LoseTag = false
			config.MaxAfterImage = 128
			--config.MaxBgmVolume = 100
			config.MaxDrawGames = -2 -- -2: match.maxdrawgames; -1: match.wins; >= 0: overriding fight.def parameters
			config.MaxExplod = 512
			config.MaxHelper = 56
			config.MaxPlayerProjectile = 256
			--config.Modules = {}
			--config.Motif = "data/system.def"
			config.MSAA = false
			config.NumSimul = {2, 4}
			config.NumTag = {2, 4}
			config.NumTurns = {2, 4}
			config.PanningRange = 30
			config.Players = 4
			--config.PngSpriteFilter = true
			config.PostProcessingShader = 0
			config.QuickContinue = false
			config.RatioAttack = {0.82, 1.0, 1.17, 1.30}
			config.RatioLife = {0.80, 1.0, 1.17, 1.40}
			config.RatioRecoveryBase = 0
			config.RatioRecoveryBonus = 20
			config.RoundsNumSimul = 2
			config.RoundsNumSingle = 2
			config.RoundsNumTag = 2
			config.RoundTime = 99
			--config.ScreenshotFolder = ""
			--config.StartStage = "stages/stage0-720.def"
			config.StereoEffects = true
			--config.System = "external/script/main.lua"
			config.Team1VS2Life = 100
			config.TeamDuplicates = true
			config.TeamLifeShare = false
			config.TeamPowerShare = true
			--config.TrainingChar = ""
			config.TurnsRecoveryBase = 0
			config.TurnsRecoveryBonus = 20
			config.VolumeBgm = 80
			config.VolumeMaster = 80
			config.VolumeSfx = 80
			config.VRetrace = 1
			--config.WavChannels = 32
			--config.WindowCentered = true
			--config.WindowIcon = {"external/icons/IkemenCylia.png"}
			--config.WindowTitle = "Ikemen GO"
			--config.XinputTriggerSensitivity = 0
			--config.ZoomActive = true
			--config.ZoomDelay = false
			--config.ZoomSpeed = 1
			loadLifebar(motif.files.fight)
			main.timeFramesPerCount = framespercount()
			main.f_updateRoundsNum()
			main.f_setPlayers(config.Players, true)
			for _, v in ipairs(options.t_vardisplayPointers) do
				v.vardisplay = options.f_vardisplay(v.itemname)
			end
			setAllowDebugKeys(config.DebugKeys)
			setAllowDebugMode(config.DebugMode)
			setAudioDucking(config.AudioDucking)
			setGameSpeed(config.GameFramerate)
			setLifeShare(1, config.TeamLifeShare)
			setLifeShare(2, config.TeamLifeShare)
			setLifeMul(config.LifeMul / 100)
			setListenPort(config.ListenPort)
			setLoseSimul(config.LoseSimul)
			setLoseTag(config.LoseTag)
			setMaxAfterImage(config.MaxAfterImage)
			setMaxExplod(config.MaxExplod)
			setMaxHelper(config.MaxHelper)
			setMaxPlayerProjectile(config.MaxPlayerProjectile)
			setPanningRange(config.PanningRange)
			setPowerShare(1, config.TeamPowerShare)
			setPowerShare(2, config.TeamPowerShare)
			setStereoEffects(config.StereoEffects)
			setTeam1VS2Life(config.Team1VS2Life / 100)
			setVolumeBgm(config.VolumeBgm)
			setVolumeMaster(config.VolumeMaster)
			setVolumeSfx(config.VolumeSfx)
			--setZoom(config.ZoomActive)
			--setZoomMax(config.ForceStageZoomin)
			--setZoomMin(config.ForceStageZoomout)
			--setZoomSpeed(config.ZoomSpeed)
			toggleFullscreen(config.Fullscreen)
			toggleVsync(config.VRetrace)
			options.modified = true
			options.needReload = true
		end
		return true
	end,
	--Difficulty Level
	['difficulty'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.Difficulty < 8 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.Difficulty = config.Difficulty + 1
			t.items[item].vardisplay = config.Difficulty
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.Difficulty > 1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.Difficulty = config.Difficulty - 1
			t.items[item].vardisplay = config.Difficulty
			options.modified = true
		end
		return true
	end,
	--Custom AI Difficulty
	['customaidifficulty'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.CustomAIDifficulty < 8 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.CustomAIDifficulty = config.CustomAIDifficulty + 1
			t.items[item].vardisplay = config.CustomAIDifficulty
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.CustomAIDifficulty > 1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.CustomAIDifficulty = config.CustomAIDifficulty - 1
			t.items[item].vardisplay = config.CustomAIDifficulty
			options.modified = true
		end
		return true
	end,
	--Time Limit
	['roundtime'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.RoundTime < 1000 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.RoundTime = config.RoundTime + 1
			t.items[item].vardisplay = config.RoundTime
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.RoundTime > -1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.RoundTime = config.RoundTime - 1
			t.items[item].vardisplay = options.f_definedDisplay(config.RoundTime, {[-1] = motif.option_info.menu_valuename_none}, config.RoundTime)
			options.modified = true
		end
		return true
	end,
	--Life
	['lifemul'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.LifeMul < 300 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.LifeMul = config.LifeMul + 10
			setLifeMul(config.LifeMul / 100)
			t.items[item].vardisplay = config.LifeMul .. '%'
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.LifeMul > 10 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.LifeMul = config.LifeMul - 10
			setLifeMul(config.LifeMul / 100)
			t.items[item].vardisplay = config.LifeMul .. '%'
			options.modified = true
		end
		return true
	end,
	--Single VS Team Life
	['singlevsteamlife'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.Team1VS2Life < 300 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.Team1VS2Life = config.Team1VS2Life + 10
			setTeam1VS2Life(config.Team1VS2Life / 100)
			t.items[item].vardisplay = config.Team1VS2Life .. '%'
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.Team1VS2Life > 10 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.Team1VS2Life = config.Team1VS2Life - 10
			setTeam1VS2Life(config.Team1VS2Life / 100)
			t.items[item].vardisplay = config.Team1VS2Life .. '%'
			options.modified = true
		end
		return true
	end,
	-- Game FPS (Game Speed)
	['gamespeed'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.GameFramerate < 600 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.GameFramerate = config.GameFramerate + 1
			setGameSpeed(config.GameFramerate)
			t.items[item].vardisplay = config.GameFramerate
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.GameFramerate > 1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.GameFramerate = config.GameFramerate - 1
			setGameSpeed(config.GameFramerate)
			t.items[item].vardisplay = config.GameFramerate
			options.modified = true
		end
		return true
	end,
	--Rounds to Win (Single)
	['roundsnumsingle'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and main.roundsNumSingle[1] < 10 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.RoundsNumSingle = main.roundsNumSingle[1] + 1
			main.roundsNumSingle = {config.RoundsNumSingle, config.RoundsNumSingle}
			t.items[item].vardisplay = config.RoundsNumSingle
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and main.roundsNumSingle[1] > 1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.RoundsNumSingle = main.roundsNumSingle[1] - 1
			main.roundsNumSingle = {config.RoundsNumSingle, config.RoundsNumSingle}
			t.items[item].vardisplay = config.RoundsNumSingle
			options.modified = true
		end
		return true
	end,
	--Max Draw Games
	['maxdrawgames'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and main.maxDrawGames[1] < 10 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.MaxDrawGames = main.maxDrawGames[1] + 1
			main.maxDrawGames = {config.MaxDrawGames, config.MaxDrawGames}
			t.items[item].vardisplay = config.MaxDrawGames
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and main.maxDrawGames[1] > 0 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.MaxDrawGames = main.maxDrawGames[1] - 1
			main.maxDrawGames = {config.MaxDrawGames, config.MaxDrawGames}
			t.items[item].vardisplay = config.MaxDrawGames
			options.modified = true
		end
		return true
	end,
	--Credits
	['credits'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.Credits < 99 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.Credits = config.Credits + 1
			t.items[item].vardisplay = config.Credits
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.Credits > 0 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.Credits = config.Credits - 1
			t.items[item].vardisplay = options.f_definedDisplay(config.Credits, {[0] = motif.option_info.menu_valuename_disabled}, config.Credits)
			options.modified = true
		end
		return true
	end,
	--Arcade Palette
	['aipalette'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.AIRandomColor then
				config.AIRandomColor = false
			else
				config.AIRandomColor = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.AIRandomColor, motif.option_info.menu_valuename_random, motif.option_info.menu_valuename_default)
			options.modified = true
		end
		return true
	end,
	--Survival Palette
	['aisurvivalpalette'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.AISurvivalColor then
				config.AISurvivalColor = false
			else
				config.AISurvivalColor = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.AISurvivalColor, motif.option_info.menu_valuename_random, motif.option_info.menu_valuename_default)
			options.modified = true
		end
		return true
	end,
	--AI Ramping
	['airamping'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.AIRamping then
				config.AIRamping = false
			else
				config.AIRamping = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.AIRamping)
			options.modified = true
		end
		return true
	end,
	--Quick Continue
	['quickcontinue'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.QuickContinue then
				config.QuickContinue = false
			else
				config.QuickContinue = true
				end
			t.items[item].vardisplay = options.f_boolDisplay(config.QuickContinue)
			options.modified = true
		end
		return true
	end,
	--Auto-Guard
	['autoguard'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.AutoGuard then
				config.AutoGuard = false
			else
				config.AutoGuard = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.AutoGuard)
			options.modified = true
		end
		return true
	end,
	--Dizzy
	['stunbar'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.BarStun then
				config.BarStun = false
			else
				config.BarStun = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.BarStun)
			options.modified = true
		end
		return true
	end,
	--Guard Break
	['guardbar'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.BarGuard then
				config.BarGuard = false
			else
				config.BarGuard = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.BarGuard)
			options.modified = true
		end
		return true
	end,
	--Red Life
	['redlifebar'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.BarRedLife then
				config.BarRedLife = false
			else
				config.BarRedLife = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.BarRedLife)
			options.modified = true
		end
		return true
	end,
	--Team Duplicates
	['teamduplicates'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.TeamDuplicates then
				config.TeamDuplicates = false
			else
				config.TeamDuplicates = true
				end
			t.items[item].vardisplay = options.f_boolDisplay(config.TeamDuplicates)
			options.modified = true
		end
		return true
	end,
	--Team Life Share
	['teamlifeshare'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.TeamLifeShare then
				config.TeamLifeShare = false
			else
				config.TeamLifeShare = true
			end
			setLifeShare(1, config.TeamLifeShare)
			setLifeShare(2, config.TeamLifeShare)
			t.items[item].vardisplay = options.f_boolDisplay(config.TeamLifeShare)
			options.modified = true
		end
		return true
	end,
	--Team Power Share
	['teampowershare'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.TeamPowerShare then
				config.TeamPowerShare = false
			else
				config.TeamPowerShare = true
			end
			setPowerShare(1, config.TeamPowerShare)
			setPowerShare(2, config.TeamPowerShare)
			t.items[item].vardisplay = options.f_boolDisplay(config.TeamPowerShare)
			options.modified = true
		end
		return true
	end,
	--Rounds to Win (Tag)
	['roundsnumtag'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and main.roundsNumTag[1] < 10 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.RoundsNumTag = main.roundsNumTag[1] + 1
			main.roundsNumTag = {config.RoundsNumTag, config.RoundsNumTag}
			t.items[item].vardisplay = config.RoundsNumTag
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and main.roundsNumTag[1] > 1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.RoundsNumTag = main.roundsNumTag[1] - 1
			main.roundsNumTag = {config.RoundsNumTag, config.RoundsNumTag}
			t.items[item].vardisplay = config.RoundsNumTag
			options.modified = true
		end
		return true
	end,
	--Partner KOed Lose
	['losekotag'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.LoseTag then
				config.LoseTag = false
			else
				config.LoseTag = true
			end
			setLoseTag(config.LoseTag)
			t.items[item].vardisplay = options.f_boolDisplay(config.LoseTag)
			options.modified = true
		end
		return true
	end,
	--Min Tag Chars
	['mintag'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.NumTag[1] < config.NumTag[2] then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.NumTag[1] = config.NumTag[1] + 1
			t.items[item].vardisplay = config.NumTag[1]
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.NumTag[1] > 2 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.NumTag[1] = config.NumTag[1] - 1
			t.items[item].vardisplay = config.NumTag[1]
			options.modified = true
		end
		return true
	end,
	--Max Tag Chars
	['maxtag'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.NumTag[2] < 4 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.NumTag[2] = config.NumTag[2] + 1
			t.items[item].vardisplay = config.NumTag[2]
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.NumTag[2] > config.NumTag[1] then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.NumTag[2] = config.NumTag[2] - 1
			t.items[item].vardisplay = config.NumTag[2]
			options.modified = true
		end
		return true
	end,
	--Rounds to Win (Simul)
	['roundsnumsimul'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and main.roundsNumSimul[1] < 10 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.RoundsNumSimul = main.roundsNumSimul[1] + 1
			main.roundsNumSimul = {config.RoundsNumSimul, config.RoundsNumSimul}
			t.items[item].vardisplay = config.RoundsNumSimul
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and main.roundsNumSimul[1] > 1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.RoundsNumSimul = main.roundsNumSimul[1] - 1
			main.roundsNumSimul = {config.RoundsNumSimul, config.RoundsNumSimul}
			t.items[item].vardisplay = config.RoundsNumSimul
			options.modified = true
		end
		return true
	end,
	--Simul Player KOed Lose
	['losekosimul'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.LoseSimul then
				config.LoseSimul = false
			else
				config.LoseSimul = true
			end
			setLoseSimul(config.LoseSimul)
			t.items[item].vardisplay = options.f_boolDisplay(config.LoseSimul)
			options.modified = true
		end
		return true
	end,
	--Min Simul Chars
	['minsimul'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.NumSimul[1] < config.NumSimul[2] then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.NumSimul[1] = config.NumSimul[1] + 1
			t.items[item].vardisplay = config.NumSimul[1]
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.NumSimul[1] > 2 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.NumSimul[1] = config.NumSimul[1] - 1
			t.items[item].vardisplay = config.NumSimul[1]
			options.modified = true
		end
		return true
	end,
	--Max Simul Chars
	['maxsimul'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.NumSimul[2] < 4 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.NumSimul[2] = config.NumSimul[2] + 1
			t.items[item].vardisplay = config.NumSimul[2]
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.NumSimul[2] > config.NumSimul[1] then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.NumSimul[2] = config.NumSimul[2] - 1
			t.items[item].vardisplay = config.NumSimul[2]
			options.modified = true
		end
		return true
	end,
	--Turns Recovery Base
	['turnsrecoverybase'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.TurnsRecoveryBase < 100 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.TurnsRecoveryBase = config.TurnsRecoveryBase + 0.5
			t.items[item].vardisplay = config.TurnsRecoveryBase .. '%'
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.TurnsRecoveryBase > 0 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.TurnsRecoveryBase = config.TurnsRecoveryBase - 0.5
			t.items[item].vardisplay = config.TurnsRecoveryBase .. '%'
			options.modified = true
		end
		return true
	end,
	--Turns Recovery Bonus
	['turnsrecoverybonus'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.TurnsRecoveryBonus < 100 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.TurnsRecoveryBonus = config.TurnsRecoveryBonus + 0.5
			t.items[item].vardisplay = config.TurnsRecoveryBonus .. '%'
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.TurnsRecoveryBonus > 0 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.TurnsRecoveryBonus = config.TurnsRecoveryBonus - 0.5
			t.items[item].vardisplay = config.TurnsRecoveryBonus .. '%'
			options.modified = true
		end
		return true
	end,
	--Min Turns Chars
	['minturns'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.NumTurns[1] < config.NumTurns[2] then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.NumTurns[1] = config.NumTurns[1] + 1
			t.items[item].vardisplay = config.NumTurns[1]
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.NumTurns[1] > 1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.NumTurns[1] = config.NumTurns[1] - 1
			t.items[item].vardisplay = config.NumTurns[1]
			options.modified = true
		end
		return true
	end,
	--Max Turns Chars
	['maxturns'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.NumTurns[2] < 8 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.NumTurns[2] = config.NumTurns[2] + 1
			t.items[item].vardisplay = config.NumTurns[2]
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.NumTurns[2] > config.NumTurns[1] then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.NumTurns[2] = config.NumTurns[2] - 1
			t.items[item].vardisplay = config.NumTurns[2]
			options.modified = true
		end
		return true
	end,
	--Ratio Recovery Base
	['ratiorecoverybase'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.RatioRecoveryBase < 100 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.RatioRecoveryBase = config.RatioRecoveryBase + 0.5
			t.items[item].vardisplay = config.RatioRecoveryBase .. '%'
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.RatioRecoveryBase > 0 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.RatioRecoveryBase = config.RatioRecoveryBase - 0.5
			t.items[item].vardisplay = config.RatioRecoveryBase .. '%'
			options.modified = true
		end
		return true
	end,
	--Ratio Recovery Bonus
	['ratiorecoverybonus'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.RatioRecoveryBonus < 100 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.RatioRecoveryBonus = config.RatioRecoveryBonus + 0.5
			t.items[item].vardisplay = config.RatioRecoveryBonus .. '%'
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.RatioRecoveryBonus > 0 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.RatioRecoveryBonus = config.RatioRecoveryBonus - 0.5
			t.items[item].vardisplay = config.RatioRecoveryBonus .. '%'
			options.modified = true
		end
		return true
	end,
	--Resolution (submenu)
	['resolution'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			local t_pos = {}
			local ok = false
			for k, v in ipairs(t.submenu[t.items[item].itemname].items) do
				local width, height = v.itemname:match('^([0-9]+)x([0-9]+)$')
				if tonumber(width) == config.GameWidth and tonumber(height) == config.GameHeight then
					v.selected = true
					ok = true
				else
					v.selected = false
				end
				if v.itemname == 'customres' then
					t_pos = v
				end
			end
			if not ok and t_pos.selected ~= nil then
				t_pos.selected = true
			end
			t.submenu[t.items[item].itemname].loop()
			t.items[item].vardisplay = config.GameWidth .. 'x' .. config.GameHeight
		end
		return true
	end,
	--Custom resolution
	['customres'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			local width = tonumber(main.f_drawInput(
				main.f_extractText(motif.option_info.textinput_reswidth_text),
					txt_textinput,
					overlay_textinput,
					motif.option_info.textinput_offset[2],
					main.f_ySpacing(motif.option_info, 'textinput'),
					motif.optionbgdef
				))
			if width ~= nil then
				sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
				local height = tonumber(main.f_drawInput(
					main.f_extractText(motif.option_info.textinput_resheight_text),
					txt_textinput,
					overlay_textinput,
					motif.option_info.textinput_offset[2],
					main.f_ySpacing(motif.option_info, 'textinput'),
					motif.optionbgdef
				))
				if height ~= nil then
					config.GameWidth = width
					config.GameHeight = height
					sndPlay(motif.files.snd_data, motif.option_info.cursor_done_snd[1], motif.option_info.cursor_done_snd[2])
					options.modified = true
					options.needReload = true
				else
					sndPlay(motif.files.snd_data, motif.option_info.cancel_snd[1], motif.option_info.cancel_snd[2])
				end
			else
				sndPlay(motif.files.snd_data, motif.option_info.cancel_snd[1], motif.option_info.cancel_snd[2])
			end
			return false
		end
		return true
	end,
	--Fullscreen
	['fullscreen'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.Fullscreen then
				config.Fullscreen = false
			else
				config.Fullscreen = true
			end
			toggleFullscreen(config.Fullscreen)
			t.items[item].vardisplay = options.f_boolDisplay(config.Fullscreen)
			options.modified = true
		end
		return true
	end,
	--VSync
	['vretrace'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.VRetrace == 1 then
				config.VRetrace = 0
			else
				config.VRetrace = 1
			end
			toggleVsync()
			t.items[item].vardisplay = options.f_definedDisplay(config.VRetrace, {[1] = motif.option_info.menu_valuename_enabled}, motif.option_info.menu_valuename_disabled)
			options.modified = true
		end
		return true
	end,
	--MSAA
	['msaa'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.MSAA then
				config.MSAA = false
			else
				config.MSAA = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.MSAA, motif.option_info.menu_valuename_enabled, motif.option_info.menu_valuename_disabled)
			options.modified = true
			options.needReload = true
		end
		return true
	end,
	--Shaders (submenu)
	['shaders'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if #options.t_shaders == 0 then
				main.f_warning(main.f_extractText(motif.warning_info.text_shaders_text), motif.optionbgdef)
				return true
			end
			for k, v in ipairs(t.submenu[t.items[item].itemname].items) do
				if config.ExternalShaders[1] == v.itemname then
					v.selected = true
				else
					v.selected = false
				end
			end
			t.submenu[t.items[item].itemname].loop()
			t.items[item].vardisplay = f_externalShaderName()
			options.modified = true
			options.needReload = true
		end
		return true
	end,
	--Disable (shader)
	['noshader'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cancel_snd[1], motif.option_info.cancel_snd[2])
			config.ExternalShaders = {}
			config.PostProcessingShader = 0
			options.modified = true
			options.needReload = true
			return false
		end
		return true
	end,
	--Master Volume
	['mastervolume'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.VolumeMaster < 200 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.VolumeMaster = config.VolumeMaster + 1
			t.items[item].vardisplay = config.VolumeMaster .. '%'
			setVolumeMaster(config.VolumeMaster)
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.VolumeMaster > 0 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.VolumeMaster = config.VolumeMaster - 1
			t.items[item].vardisplay = config.VolumeMaster  .. '%'
			setVolumeMaster(config.VolumeMaster)
			options.modified = true
		end
		return true
	end,
	--BGM Volume
	['bgmvolume'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.VolumeBgm < 100 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.VolumeBgm = config.VolumeBgm + 1
			t.items[item].vardisplay = config.VolumeBgm .. '%'
			setVolumeBgm(config.VolumeBgm)
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.VolumeBgm > 0 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.VolumeBgm = config.VolumeBgm - 1
			t.items[item].vardisplay = config.VolumeBgm .. '%'
			setVolumeBgm(config.VolumeBgm)
			options.modified = true
		end
		return true
	end,
	--SFX Volume
	['sfxvolume'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.VolumeSfx < 100 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.VolumeSfx = config.VolumeSfx + 1
			t.items[item].vardisplay = config.VolumeSfx .. '%'
			setVolumeSfx(config.VolumeSfx)
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.VolumeSfx > 0 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.VolumeSfx = config.VolumeSfx - 1
			t.items[item].vardisplay = config.VolumeSfx .. '%'
			setVolumeSfx(config.VolumeSfx)
			options.modified = true
		end
		return true
	end,
	--Audio Ducking
	['audioducking'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.AudioDucking then
				config.AudioDucking = false
			else
				config.AudioDucking = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.AudioDucking, motif.option_info.menu_valuename_enabled, motif.option_info.menu_valuename_disabled)
			setAudioDucking(config.AudioDucking)
			options.modified = true
		end
		return true
	end,
	--Stereo Effects
	['stereoeffects'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.StereoEffects then
				config.StereoEffects = false
			else
				config.StereoEffects = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.StereoEffects, motif.option_info.menu_valuename_enabled, motif.option_info.menu_valuename_disabled)
			setStereoEffects(config.StereoEffects)
			options.modified = true
		end
		return true
	end,
	--Panning Width
	['panningrange'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.PanningRange < 100 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.PanningRange = config.PanningRange + 1
			setPanningRange(config.PanningRange)
			t.items[item].vardisplay = config.PanningRange .. '%'
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.PanningRange > 0 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.PanningRange = config.PanningRange - 1
			setPanningRange(config.PanningRange)
			t.items[item].vardisplay = config.PanningRange .. '%'
			options.modified = true
		end
		return true
	end,
	--Key Config
	['keyboard'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'pal', 's'}) --[[or getKey():match('^F[0-9]+$')]] then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_done_snd[1], motif.option_info.cursor_done_snd[2])
			options.f_keyCfgInit('KeyConfig', t.submenu[t.items[item].itemname].title)
			local keyBg = motif.titlebgdef ~= nil and 'titlebgdef' or 'optionbgdef'
			while true do
				if not options.f_keyCfg('KeyConfig', t.items[item].itemname, keyBg, false) then
					break
				end
			end
		end
		return true
	end,
	--Joystick Config
	['gamepad'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'pal', 's'}) --[[or getKey():match('^F[0-9]+$')]] then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_done_snd[1], motif.option_info.cursor_done_snd[2])
			if main.flags['-nojoy'] == nil then
				options.f_keyCfgInit('JoystickConfig', t.submenu[t.items[item].itemname].title)
				local keyBg = motif.titlebgdef ~= nil and 'titlebgdef' or 'optionbgdef'
				while true do
					if not options.f_keyCfg('JoystickConfig', t.items[item].itemname, keyBg, false) then
						break
					end
				end
			end
		end
		return true
	end,
	--Default
	['inputdefault'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_done_snd[1], motif.option_info.cursor_done_snd[2])
			options.f_keyDefault()
			for pn = 1, #config.KeyConfig do
				setKeyConfig(pn, config.KeyConfig[pn].Joystick, config.KeyConfig[pn].Buttons)
			end
			if main.flags['-nojoy'] == nil then
				for pn = 1, #config.JoystickConfig do
					setKeyConfig(pn, config.JoystickConfig[pn].Joystick, config.JoystickConfig[pn].Buttons)
				end
			end
			options.modified = true
		end
		return true
	end,
	--Players
	['players'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) and config.Players < 8 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.Players = math.min(8, config.Players + 2)
			t.items[item].vardisplay = config.Players
			main.f_setPlayers(config.Players, true)
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.Players > 2 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.Players = math.max(2, config.Players - 2)
			t.items[item].vardisplay = config.Players
			main.f_setPlayers(config.Players, true)
			options.modified = true
		end
		return true
	end,
	--Debug Keys
	['debugkeys'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.DebugKeys then
				config.DebugKeys = false
			else
				config.DebugKeys = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.DebugKeys, motif.option_info.menu_valuename_enabled, motif.option_info.menu_valuename_disabled)
			setAllowDebugKeys(config.DebugKeys)
			options.modified = true
		end
		return true
	end,
	--Debug Mode
	['debugmode'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.DebugMode then
				config.DebugMode = false
			else
				config.DebugMode = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.DebugMode, motif.option_info.menu_valuename_enabled, motif.option_info.menu_valuename_disabled)
			setAllowDebugMode(config.DebugMode)
			options.modified = true
		end
		return true
	end,
	--Background Loading
	--[[['backgroundloading'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			if config.BackgroundLoading then
				config.BackgroundLoading = false
			else
				config.BackgroundLoading = true
			end
			t.items[item].vardisplay = options.f_boolDisplay(config.BackgroundLoading, motif.option_info.menu_valuename_enabled, motif.option_info.menu_valuename_disabled)
			options.modified = true
		end
		return true
	end,]]
	--HelperMax
	['helpermax'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.MaxHelper = config.MaxHelper + 1
			t.items[item].vardisplay = config.MaxHelper
			setMaxHelper(config.MaxHelper)
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.MaxHelper > 1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.MaxHelper = config.MaxHelper - 1
			t.items[item].vardisplay = config.MaxHelper
			setMaxHelper(config.MaxHelper)
			options.modified = true
		end
		return true
	end,
	--PlayerProjectileMax
	['projectilemax'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.MaxPlayerProjectile = config.MaxPlayerProjectile + 1
			t.items[item].vardisplay = config.MaxPlayerProjectile
			setMaxPlayerProjectile(config.MaxPlayerProjectile)
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.MaxPlayerProjectile > 1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.MaxPlayerProjectile = config.MaxPlayerProjectile - 1
			t.items[item].vardisplay = config.MaxPlayerProjectile
			setMaxPlayerProjectile(config.MaxPlayerProjectile)
			options.modified = true
		end
		return true
	end,
	--ExplodMax
	['explodmax'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.MaxExplod = config.MaxExplod + 1
			t.items[item].vardisplay = config.MaxExplod
			setMaxExplod(config.MaxExplod)
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.MaxExplod > 1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.MaxExplod = config.MaxExplod - 1
			t.items[item].vardisplay = config.MaxExplod
			setMaxExplod(config.MaxExplod)
			options.modified = true
		end
		return true
	end,
	--AfterImageMax
	['afterimagemax'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.MaxAfterImage = config.MaxAfterImage + 1
			t.items[item].vardisplay = config.MaxAfterImage
			setMaxAfterImage(config.MaxAfterImage)
			options.modified = true
		elseif main.f_input(main.t_players, {'$B'}) and config.MaxAfterImage > 1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			config.MaxAfterImage = config.MaxAfterImage - 1
			t.items[item].vardisplay = config.MaxAfterImage
			setMaxAfterImage(config.MaxAfterImage)
			options.modified = true
		end
		return true
	end,
	--Save and Return
	['savereturn'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cancel_snd[1], motif.option_info.cancel_snd[2])
			if options.modified then
				options.f_saveCfg(options.needReload)
			end
			main.close = true
			--return false
		end
		return true
	end,
	--Return Without Saving
	['return'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cancel_snd[1], motif.option_info.cancel_snd[2])
			if options.needReload then
				main.f_warning(main.f_extractText(motif.warning_info.text_noreload_text), motif.optionbgdef)
			end
			main.close = true
			--return false
		end
		return true
	end,
	--Save Settings
	['savesettings'] = function(t, item, cursorPosY, moveTxt)
		if main.f_input(main.t_players, {'$F', '$B', 'pal', 's'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_done_snd[1], motif.option_info.cursor_done_snd[2])
			if options.modified then
				options.f_saveCfg(options.needReload)
			end
		end
		return true
	end,
}

-- Shared menu loop logic
function options.f_createMenu(tbl, bool_main)
	return function()
		hook.run("options.menu.loop")
		-- Use the title screen background for options menus to match the rest of the game
		local optionsBg = motif.titlebgdef ~= nil and 'titlebgdef' or 'optionbgdef'
		local cursorPosY = 1
		local moveTxt = 0
		local item = 1
		local t = tbl.items
		if bool_main then
			main.f_bgReset(motif[optionsBg].bg)
			main.f_fadeReset('fadein', motif.option_info)
			if motif.music.option_bgm ~= '' then
				main.f_playBGM(false, motif.music.option_bgm, motif.music.option_bgm_loop, motif.music.option_bgm_volume, motif.music.option_bgm_loopstart, motif.music.option_bgm_loopend)
			end
			main.close = false
		end
		while true do
			if tbl.reset then
				tbl.reset = false
				main.f_cmdInput()
			else
				main.f_menuCommonDraw(t, item, cursorPosY, moveTxt, 'option_info', optionsBg, options.txt_title, motif.defaultOptions, {})
			end
			cursorPosY, moveTxt, item = main.f_menuCommonCalc(t, item, cursorPosY, moveTxt, 'option_info', {'$U'}, {'$D'})
			options.txt_title:update({text = tbl.title})
			if main.close and not main.fadeActive then
				main.f_bgReset(motif[main.background].bg)
				main.f_fadeReset('fadein', motif[main.group])
				main.f_playBGM(false, motif.music.title_bgm, motif.music.title_bgm_loop, motif.music.title_bgm_volume, motif.music.title_bgm_loopstart, motif.music.title_bgm_loopend)
				main.close = false
				break
			elseif esc() or main.f_input(main.t_players, {'m'}) then
				sndPlay(motif.files.snd_data, motif.option_info.cancel_snd[1], motif.option_info.cancel_snd[2])
				if bool_main then
					if options.modified then
						--options.f_saveCfg(options.needReload)
					end
					if options.needReload then
						main.f_warning(main.f_extractText(motif.warning_info.text_noreload_text), motif[optionsBg])
					end
					main.f_fadeReset('fadeout', motif.option_info)
					main.close = true
				else
					break
				end
			elseif options.t_itemname[t[item].itemname] ~= nil then
				if not options.t_itemname[t[item].itemname](tbl, item, cursorPosY, moveTxt) then
					break
				end
			elseif main.f_input(main.t_players, {'pal', 's'}) then
				local f = t[item].itemname
				if tbl.submenu[f].loop ~= nil then
					sndPlay(motif.files.snd_data, motif.option_info.cursor_done_snd[1], motif.option_info.cursor_done_snd[2])
					tbl.submenu[f].loop()
				elseif not options.t_itemname[f](tbl, item, cursorPosY, moveTxt) then
					break
				end
			end
		end
	end
end

options.t_vardisplayPointers = {}

-- Associative elements table storing functions returning current setting values
-- rendered alongside menu item name. Can be appended via external module.
options.t_vardisplay = {
	['afterimagemax'] = function()
		return config.MaxAfterImage
	end,
	['aipalette'] = function()
		return options.f_boolDisplay(config.AIRandomColor, motif.option_info.menu_valuename_random, motif.option_info.menu_valuename_default)
	end,
	['aisurvivalpalette'] = function()
		return options.f_boolDisplay(config.AISurvivalColor, motif.option_info.menu_valuename_random, motif.option_info.menu_valuename_default)
	end,
	['airamping'] = function()
		return options.f_boolDisplay(config.AIRamping)
	end,
	['audioducking'] = function()
		return options.f_boolDisplay(config.AudioDucking, motif.option_info.menu_valuename_enabled, motif.option_info.menu_valuename_disabled)
	end,
	['autoguard'] = function()
		return options.f_boolDisplay(config.AutoGuard)
	end,
	--['backgroundloading'] = function()
	--	return options.f_boolDisplay(config.BackgroundLoading, motif.option_info.menu_valuename_enabled, motif.option_info.menu_valuename_disabled)
	--end,
	['bgmvolume'] = function()
		return config.VolumeBgm .. '%'
	end,
	['credits'] = function()
		return options.f_definedDisplay(config.Credits, {[0] = motif.option_info.menu_valuename_disabled}, config.Credits)
	end,
	['debugkeys'] = function()
		return options.f_boolDisplay(config.DebugKeys, motif.option_info.menu_valuename_enabled, motif.option_info.menu_valuename_disabled)
	end,
	['debugmode'] = function()
		return options.f_boolDisplay(config.DebugMode, motif.option_info.menu_valuename_enabled, motif.option_info.menu_valuename_disabled)
	end,
	['difficulty'] = function()
		return config.Difficulty
	end,
	['customaidifficulty'] = function()
		return config.CustomAIDifficulty
	end,
	['explodmax'] = function()
		return config.MaxExplod
	end,
	['fullscreen'] = function()
		return options.f_boolDisplay(config.Fullscreen)
	end,
	['gamespeed'] = function()
		return config.GameFramerate
	end,
	['guardbar'] = function()
		return options.f_boolDisplay(config.BarGuard)
	end,
	['helpermax'] = function()
		return config.MaxHelper
	end,
	['lifemul'] = function()
		return config.LifeMul .. '%'
	end,
	['losekosimul'] = function()
		return options.f_boolDisplay(config.LoseSimul)
	end,
	['losekotag'] = function()
		return options.f_boolDisplay(config.LoseTag)
	end,
	['mastervolume'] = function()
		return config.VolumeMaster .. '%'
	end,
	['maxdrawgames'] = function()
		return main.maxDrawGames[1]
	end,
	['maxsimul'] = function()
		return config.NumSimul[2]
	end,
	['maxtag'] = function()
		return config.NumTag[2]
	end,
	['maxturns'] = function()
		return config.NumTurns[2]
	end,
	['minsimul'] = function()
		return config.NumSimul[1]
	end,
	['mintag'] = function()
		return config.NumTag[1]
	end,
	['minturns'] = function()
		return config.NumTurns[1]
	end,
	['msaa'] = function()
		return options.f_boolDisplay(config.MSAA, motif.option_info.menu_valuename_enabled, motif.option_info.menu_valuename_disabled)
	end,
	['panningrange'] = function()
		return config.PanningRange .. '%'
	end,
	['players'] = function()
		return config.Players
	end,
	['portchange'] = function()
		return config.ListenPort
	end,
	['projectilemax'] = function()
		return config.MaxPlayerProjectile
	end,
	['quickcontinue'] = function()
		return options.f_boolDisplay(config.QuickContinue)
	end,
	['ratio1attack'] = function()
		return options.f_displayRatio(config.RatioAttack[1])
	end,
	['ratio1life'] = function()
		return options.f_displayRatio(config.RatioLife[1])
	end,
	['ratio2attack'] = function()
		return options.f_displayRatio(config.RatioAttack[2])
	end,
	['ratio2life'] = function()
		return options.f_displayRatio(config.RatioLife[2])
	end,
	['ratio3attack'] = function()
		return options.f_displayRatio(config.RatioAttack[3])
	end,
	['ratio3life'] = function()
		return options.f_displayRatio(config.RatioLife[3])
	end,
	['ratio4attack'] = function()
		return options.f_displayRatio(config.RatioAttack[4])
	end,
	['ratio4life'] = function()
		return options.f_displayRatio(config.RatioLife[4])
	end,
	['ratiorecoverybase'] = function()
		return config.RatioRecoveryBase .. '%'
	end,
	['ratiorecoverybonus'] = function()
		return config.RatioRecoveryBonus .. '%'
	end,
	['redlifebar'] = function()
		return options.f_boolDisplay(config.BarRedLife)
	end,
	['resolution'] = function()
		return config.GameWidth .. 'x' .. config.GameHeight
	end,
	['roundsnumsimul'] = function()
		return main.roundsNumSimul[1]
	end,
	['roundsnumsingle'] = function()
		return main.roundsNumSingle[1]
	end,
	['roundsnumtag'] = function()
		return main.roundsNumTag[1]
	end,
	['roundtime'] = function()
		return options.f_definedDisplay(config.RoundTime, {[-1] = motif.option_info.menu_valuename_none}, config.RoundTime)
	end,
	['sfxvolume'] = function()
		return config.VolumeSfx .. '%'
	end,
	['shaders'] = function()
		return f_externalShaderName()
	end,
	['singlevsteamlife'] = function()
		return config.Team1VS2Life .. '%'
	end,
	['stereoeffects'] = function()
		return options.f_boolDisplay(config.StereoEffects, motif.option_info.menu_valuename_enabled, motif.option_info.menu_valuename_disabled)
	end,
	['stunbar'] = function()
		return options.f_boolDisplay(config.BarStun)
	end,
	['teamduplicates'] = function()
		return options.f_boolDisplay(config.TeamDuplicates)
	end,
	['teamlifeshare'] = function()
		return options.f_boolDisplay(config.TeamLifeShare)
	end,
	['teampowershare'] = function()
		return options.f_boolDisplay(config.TeamPowerShare)
	end,
	['turnsrecoverybase'] = function()
		return config.TurnsRecoveryBase .. '%'
	end,
	['turnsrecoverybonus'] = function()
		return config.TurnsRecoveryBonus .. '%'
	end,
	['vretrace'] = function()
		return options.f_definedDisplay(config.VRetrace, {[1] = motif.option_info.menu_valuename_enabled}, motif.option_info.menu_valuename_disabled)
	end,
}

-- Returns setting value rendered alongside menu item name (calls appropriate
-- function from t_vardisplay table)
function options.f_vardisplay(itemname)
	if options.t_vardisplay[itemname] ~= nil then
		return options.t_vardisplay[itemname]()
	end
	return ''
end

-- Dynamically generates all menus and submenus, iterating over values stored in
-- main.t_sort table (in order that they're present in system.def).
function options.f_start()
	-- default menus
	if main.t_sort.option_info == nil or main.t_sort.option_info.menu == nil or #main.t_sort.option_info.menu == 0 then
		motif.setBaseOptionInfo()
	end
	-- external shaders
	options.t_shaders = {}
	for _, v in ipairs(getDirectoryFiles('external/shaders')) do
		v:gsub('^(.-)([^\\/]+)%.([^%.\\/]-)$', function(path, filename, ext)
			path = path:gsub('\\', '/')
			ext = ext:lower()
			if ext == 'frag' then
				table.insert(options.t_shaders, {path = path, filename = filename})
			end
			if ext:match('vert') or ext:match('frag') --[[or ext:match('shader')]] then
				options.t_itemname[path .. filename] = function(t, item, cursorPosY, moveTxt)
					if main.f_input(main.t_players, {'pal', 's'}) then
						sndPlay(motif.files.snd_data, motif.option_info.cursor_done_snd[1], motif.option_info.cursor_done_snd[2])
						config.ExternalShaders = {path .. filename}
						config.PostProcessingShader = 1
						return false
					end
					return true
				end
			end
		end)
	end
	for _, v in ipairs(main.f_tableExists(main.t_sort.option_info).menu) do
		-- resolution
		if v:match('_[0-9]+x[0-9]+$') then
			local width, height = v:match('_([0-9]+)x([0-9]+)$')
			options.t_itemname[width .. 'x' .. height] = function(t, item, cursorPosY, moveTxt)
				if main.f_input(main.t_players, {'pal', 's'}) then
					sndPlay(motif.files.snd_data, motif.option_info.cursor_done_snd[1], motif.option_info.cursor_done_snd[2])
					config.GameWidth = tonumber(width)
					config.GameHeight = tonumber(height)
					options.modified = true
					options.needReload = true
					return false
				end
				return true
			end
		-- ratio
		elseif v:match('_ratio[1-4]+[al].-$') then
			local ratioLevel, tmp1, tmp2 = v:match('_ratio([1-4])([al])(.-)$')
			options.t_itemname['ratio' .. ratioLevel .. tmp1 .. tmp2] = function(t, item, cursorPosY, moveTxt)
				local ratioType = tmp1:upper() .. tmp2
				ratioLevel = tonumber(ratioLevel)
				if main.f_input(main.t_players, {'$F'}) then
					sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
					config['Ratio' .. ratioType][ratioLevel] = options.f_precision(config['Ratio' .. ratioType][ratioLevel] + 0.01, '%.02f')
					t.items[item].vardisplay = options.f_displayRatio(config['Ratio' .. ratioType][ratioLevel])
					options.modified = true
				elseif main.f_input(main.t_players, {'$B'}) and config['Ratio' .. ratioType][ratioLevel] > 0.01 then
					sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
					config['Ratio' .. ratioType][ratioLevel] = options.f_precision(config['Ratio' .. ratioType][ratioLevel] - 0.01, '%.02f')
					t.items[item].vardisplay = options.f_displayRatio(config['Ratio' .. ratioType][ratioLevel])
					options.modified = true
				end
				return true
			end
		end
	end
	if main.debugLog then main.f_printTable(options.t_itemname, 'debug/t_optionsItemname.txt') end
	-- create menu
	options.menu = {title = main.f_itemnameUpper(motif.option_info.title_text, motif.option_info.menu_title_uppercase == 1), submenu = {}, items = {}}
	options.menu.loop = options.f_createMenu(options.menu, true)
	local t_menuWindow = main.f_menuWindow(motif.option_info)
	local t_pos = {} --for storing current options.menu table position
	local lastNum = 0
	for i, suffix in ipairs(main.f_tableExists(main.t_sort.option_info).menu) do
		for j, c in ipairs(main.f_strsplit('_', suffix)) do --split using "_" delimiter
			--populate shaders submenu
			if suffix:match('_shaders_back$') and c == 'back' then
				for k = #options.t_shaders, 1, -1 do
					local itemname = options.t_shaders[k].path .. options.t_shaders[k].filename
					table.insert(t_pos.items, 1, {
						data = text:create({window = t_menuWindow}),
						itemname = itemname,
						displayname = options.t_shaders[k].filename,
						paramname = 'menu_itemname_' .. suffix:gsub('back$', itemname),
						vardata = text:create({window = t_menuWindow}),
						vardisplay = options.f_vardisplay(c),
						selected = false,
					})
					table.insert(options.t_vardisplayPointers, t_pos.items[#t_pos.items])
					--creating anim data out of appended menu items
					motif.f_loadSprData(motif.option_info, {s = 'menu_bg_' .. suffix:gsub('back$', itemname) .. '_', x = motif.option_info.menu_pos[1], y = motif.option_info.menu_pos[2]})
					motif.f_loadSprData(motif.option_info, {s = 'menu_bg_active_' .. suffix:gsub('back$', itemname) .. '_', x = motif.option_info.menu_pos[1], y = motif.option_info.menu_pos[2]})
				end
			end
			--appending the menu table
			if j == 1 then --first string after menu.itemname (either reserved one or custom submenu assignment)
				if options.menu.submenu[c] == nil or c == 'empty' then
					options.menu.submenu[c] = {title = main.f_itemnameUpper(motif.option_info['menu_itemname_' .. suffix], motif.option_info.menu_title_uppercase == 1), submenu = {}, items = {}}
					options.menu.submenu[c].loop = options.f_createMenu(options.menu.submenu[c], false)
					if not suffix:match(c .. '_') then
						table.insert(options.menu.items, {
							data = text:create({window = t_menuWindow}),
							itemname = c,
							displayname = motif.option_info['menu_itemname_' .. suffix],
							paramname = 'menu_itemname_' .. suffix,
							vardata = text:create({window = t_menuWindow}),
							vardisplay = options.f_vardisplay(c),
							selected = false,
						})
						table.insert(options.t_vardisplayPointers, options.menu.items[#options.menu.items])
					end
				end
				t_pos = options.menu.submenu[c]
				t_pos.name = c
			else --following strings
				if t_pos.submenu[c] == nil or c == 'empty' then
					t_pos.submenu[c] = {title = main.f_itemnameUpper(motif.option_info['menu_itemname_' .. suffix], motif.option_info.menu_title_uppercase == 1), submenu = {}, items = {}}
					t_pos.submenu[c].loop = options.f_createMenu(t_pos.submenu[c], false)
					table.insert(t_pos.items, {
						data = text:create({window = t_menuWindow}),
						itemname = c,
						displayname = motif.option_info['menu_itemname_' .. suffix],
						paramname = 'menu_itemname_' .. suffix,
						vardata = text:create({window = t_menuWindow}),
						vardisplay = options.f_vardisplay(c),
						selected = false,
					})
					table.insert(options.t_vardisplayPointers, t_pos.items[#t_pos.items])
				end
				if j > lastNum then
					t_pos = t_pos.submenu[c]
					t_pos.name = c
				end
			end
			lastNum = j
		end
	end
	-- log
	if main.debugLog then main.f_printTable(options.menu, 'debug/t_optionsMenu.txt') end
end

--;===========================================================
--; KEY SETTINGS
--;===========================================================
local CONTROL_PRESET_FILE = 'data/control_presets.json'
local CONTROL_BINDINGS_FILE = 'save/control_bindings.json'
local controlPresets = {}
local controlActions = {}
local controlState = {currentPreset = '', bindings = {}}
local controlDefaultPresetId = ''
local actionToButton = {}
local buttonLabels = {d = 'Extra 1', w = 'Extra 2', menu = 'Menu'}
local presetCursor = 1
local keyCfgStage = 'preset' --preset list or grid
local editingPresetId = ''
local controlSnapshotConfig = {}
local captureItem = nil
local defaultButtonOrder = {'up', 'down', 'left', 'right', 'a', 'b', 'c', 'x', 'y', 'z', 'start', 'd', 'w', 'menu'}
local t_btnNameNum = {
	up = 1, down = 2, left = 3, right = 4,
	a = 5, b = 6, c = 7, x = 8, y = 9, z = 10,
	start = 11, d = 12, w = 13, menu = 14,
}
local t_btnNumName = defaultButtonOrder

local function readJsonFile(path)
	if not main.f_fileExists(path) then
		return nil
	end
	return json.decode(main.f_fileRead(path))
end

local function writeJsonFile(path, tbl)
	if tbl == nil then
		return
	end
	main.f_fileWrite(path, json.encode(tbl))
end

	local function initControlActions(data)
		-- Map kicks to a/b/c, punches to x/y/z
		actionToButton = {
			up = 'up', down = 'down', left = 'left', right = 'right',
			lp = 'x', mp = 'y', hp = 'z', -- punches
			lk = 'a', mk = 'b', hk = 'c', -- kicks
			start = 'start', menu = 'menu'
		}
	if data ~= nil then
		for k, v in pairs(data) do
			if v.button ~= nil then
				actionToButton[k] = v.button
				if v.label ~= nil then
					buttonLabels[v.button] = v.label
				end
			end
		end
	end
	--fallback labels
	buttonLabels.up = buttonLabels.up or 'Up'
	buttonLabels.down = buttonLabels.down or 'Down'
	buttonLabels.left = buttonLabels.left or 'Left'
	buttonLabels.right = buttonLabels.right or 'Right'
		-- swap labels so kicks map to a/b/c and punches to x/y/z
		buttonLabels.a = buttonLabels.a or 'Light Kick'
		buttonLabels.b = buttonLabels.b or 'Medium Kick'
		buttonLabels.c = buttonLabels.c or 'Heavy Kick'
		buttonLabels.x = buttonLabels.x or 'Light Punch'
		buttonLabels.y = buttonLabels.y or 'Medium Punch'
		buttonLabels.z = buttonLabels.z or 'Heavy Punch'
	buttonLabels.start = buttonLabels.start or 'Start/Pause'
	buttonLabels.menu = buttonLabels.menu or 'Menu'
end

local function loadControlPresets()
	local data = readJsonFile(CONTROL_PRESET_FILE) or {}
	controlPresets = data.presets or {}
	controlActions = data.actions or {}
	controlDefaultPresetId = data.defaultPreset or ''
	initControlActions(controlActions)
	if controlDefaultPresetId == '' and #controlPresets > 0 then
		controlDefaultPresetId = controlPresets[1].id or ''
	end
end

local function blankButtons()
	local btns = {}
	local names = t_btnNumName or defaultButtonOrder
	for i = 1, #names do
		btns[i] = tostring(motif.option_info.menu_valuename_nokey)
	end
	return btns
end

local function actionsToButtons(actionMap)
	local btns = blankButtons()
	if actionMap ~= nil then
		for action, keyName in pairs(actionMap) do
			local btnName = actionToButton[action]
			local idx = t_btnNameNum[btnName]
			if idx ~= nil then
				btns[idx] = tostring(keyName)
			end
		end
	end
	return btns
end

local function buttonsToActions(btns)
	local actions = {}
	for action, btnName in pairs(actionToButton) do
		local idx = t_btnNameNum[btnName]
		if idx ~= nil and btns[idx] ~= nil then
			actions[action] = tostring(btns[idx])
		end
	end
	return actions
end

local function ensureControlState()
	local data = readJsonFile(CONTROL_BINDINGS_FILE) or {currentPreset = controlDefaultPresetId, bindings = {}}
	for _, preset in ipairs(controlPresets) do
		if data.bindings[preset.id] == nil then
			data.bindings[preset.id] = main.f_tableCopy(preset.players or {})
		end
	end
	if data.currentPreset == '' then
		data.currentPreset = controlDefaultPresetId
	end
	controlState = data
	writeJsonFile(CONTROL_BINDINGS_FILE, controlState)
end

local function capturePresetIndex()
	for i, preset in ipairs(controlPresets) do
		if preset.id == controlState.currentPreset then
			return i
		end
	end
	return 1
end

local function snapshotConfigFromPreset(presetId)
	local snapshot = {}
	for i = 1, #config.KeyConfig do
		snapshot[i] = {
			Joystick = config.KeyConfig[i].Joystick,
			Buttons = main.f_tableCopy(config.KeyConfig[i].Buttons)
		}
	end
	controlSnapshotConfig = snapshot
	editingPresetId = presetId
end

local function applyPresetToConfig(presetId)
	local binding = controlState.bindings[presetId] or {}
	for pn = 1, math.max(2, config.Players or 2) do
		local playerKey = pn == 1 and 'p1' or 'p2'
		config.KeyConfig[pn].Buttons = actionsToButtons(binding[playerKey])
		setKeyConfig(pn, config.KeyConfig[pn].Joystick, config.KeyConfig[pn].Buttons)
	end
	controlState.currentPreset = presetId
	writeJsonFile(CONTROL_BINDINGS_FILE, controlState)
end

local function saveConfigToBindings(presetId)
	if presetId == nil or presetId == '' then
		return
	end
	if controlState.bindings[presetId] == nil then
		controlState.bindings[presetId] = {}
	end
	controlState.bindings[presetId].p1 = buttonsToActions(config.KeyConfig[1].Buttons)
	controlState.bindings[presetId].p2 = buttonsToActions(config.KeyConfig[2].Buttons)
	controlState.currentPreset = presetId
	writeJsonFile(CONTROL_BINDINGS_FILE, controlState)
end

local function revertPlayerToDefault(presetId, pn)
	for _, preset in ipairs(controlPresets) do
		if preset.id == presetId then
			local playerKey = pn == 1 and 'p1' or 'p2'
			local defaults = preset.players and preset.players[playerKey] or {}
			config.KeyConfig[pn].Buttons = actionsToButtons(defaults)
			setKeyConfig(pn, config.KeyConfig[pn].Joystick, config.KeyConfig[pn].Buttons)
			return
		end
	end
end

local function buildPresetListText()
	local t = {}
	for _, preset in ipairs(controlPresets) do
		table.insert(t, {
			name = preset.name or preset.id,
			id = preset.id
		})
	end
	return t
end

local function presetNameById(id)
	for _, preset in ipairs(controlPresets) do
		if preset.id == id then
			return preset.name or preset.id
		end
	end
	return id
end

local function updatePresetHeader()
	local activeId = editingPresetId ~= '' and editingPresetId or controlState.currentPreset
	if t_keyCfg ~= nil and t_keyCfg[2] ~= nil and t_keyCfg[2].itemname == 'configall' then
		t_keyCfg[2].displayname = 'Preset: ' .. presetNameById(activeId)
		t_keyCfg[2].infodisplay = ''
	end
end

loadControlPresets()
ensureControlState()
applyPresetToConfig(controlState.currentPreset ~= '' and controlState.currentPreset or controlDefaultPresetId)
local presetTextItems = buildPresetListText()
presetCursor = capturePresetIndex()
updatePresetHeader()

local function f_keyCfgText()
	return {text:create({}), text:create({})}
end
local t_keyCfg = {
	{data = f_keyCfgText(), itemname = 'empty', displayname = ''},
	{data = f_keyCfgText(), itemname = 'up', displayname = buttonLabels.up, vardata = f_keyCfgText()},
	{data = f_keyCfgText(), itemname = 'down', displayname = buttonLabels.down, vardata = f_keyCfgText()},
	{data = f_keyCfgText(), itemname = 'left', displayname = buttonLabels.left, vardata = f_keyCfgText()},
	{data = f_keyCfgText(), itemname = 'right', displayname = buttonLabels.right, vardata = f_keyCfgText()},
	-- kicks on a/b/c, punches on x/y/z
	{data = f_keyCfgText(), itemname = 'a', displayname = 'Light Kick', vardata = f_keyCfgText()},
	{data = f_keyCfgText(), itemname = 'b', displayname = 'Medium Kick', vardata = f_keyCfgText()},
	{data = f_keyCfgText(), itemname = 'c', displayname = 'Heavy Kick', vardata = f_keyCfgText()},
	{data = f_keyCfgText(), itemname = 'x', displayname = 'Light Punch', vardata = f_keyCfgText()},
	{data = f_keyCfgText(), itemname = 'y', displayname = 'Medium Punch', vardata = f_keyCfgText()},
	{data = f_keyCfgText(), itemname = 'z', displayname = 'Heavy Punch', vardata = f_keyCfgText()},
	{data = f_keyCfgText(), itemname = 'start', displayname = buttonLabels.start, vardata = f_keyCfgText()},
	{data = f_keyCfgText(), itemname = 'page', displayname = '', infodata = f_keyCfgText(), infodisplay = ''},
}
t_keyCfg = main.f_tableClean(t_keyCfg, main.f_tableExists(main.t_sort.option_info).keymenu)
-- enforce our label text so motif defaults don't override kick/punch swap
for _, row in ipairs(t_keyCfg) do
	if row.itemname == 'a' then row.displayname = 'Light Kick' end
	if row.itemname == 'b' then row.displayname = 'Medium Kick' end
	if row.itemname == 'c' then row.displayname = 'Heavy Kick' end
	if row.itemname == 'x' then row.displayname = 'Light Punch' end
	if row.itemname == 'y' then row.displayname = 'Medium Punch' end
	if row.itemname == 'z' then row.displayname = 'Heavy Punch' end
end
table.insert(t_keyCfg, #t_keyCfg, {data = f_keyCfgText(), itemname = 'revert', displayname = 'Revert to Default', infodata = f_keyCfgText(), infodisplay = ''})
table.insert(t_keyCfg, #t_keyCfg, {data = f_keyCfgText(), itemname = 'saveexit', displayname = 'Save & Exit', infodata = f_keyCfgText(), infodisplay = ''})
table.insert(t_keyCfg, #t_keyCfg, {data = f_keyCfgText(), itemname = 'exitnosave', displayname = 'Exit Without Saving', infodata = f_keyCfgText(), infodisplay = ''})

local rect_boxbg = rect:create({
	r =     motif.option_info.menu_boxbg_col[1],
	g =     motif.option_info.menu_boxbg_col[2],
	b =     motif.option_info.menu_boxbg_col[3],
	src =   motif.option_info.menu_boxbg_alpha[1],
	dst =   motif.option_info.menu_boxbg_alpha[2],
	defsc = motif.defaultOptions,
})
local rect_boxcursor = rect:create({
	r =     motif.option_info.menu_boxcursor_col[1],
	g =     motif.option_info.menu_boxcursor_col[2],
	b =     motif.option_info.menu_boxcursor_col[3],
	defsc = motif.defaultOptions,
})
local rect_presetCursor = rect:create({
	r =     motif.option_info.menu_boxcursor_col[1],
	g =     motif.option_info.menu_boxcursor_col[2],
	b =     motif.option_info.menu_boxcursor_col[3],
	defsc = motif.defaultOptions,
})

local txt_keyController = f_keyCfgText()
local txt_presetHeader = text:create({})
local txt_presetHint = text:create({})
local txt_presetItems = {}
local txt_gridHint = text:create({})
for i = 1, math.max(1, #presetTextItems) do
	table.insert(txt_presetItems, text:create({}))
end
local cursorPosY = 2
local item = 2
local item_start = 2
local t_pos = {}
local configall = false
local key = ''
local t_keyList = {}
local t_conflict = {}
local t_savedConfig = {}
local btnReleased = false
local player = 1
local side = 1
local btn = ''
local joyNum = 0
t_btnNameNum = {up = 1, down = 2, left = 3, right = 4, a = 5, b = 6, c = 7, x = 8, y = 9, z = 10, start = 11}
t_btnNumName = {'up', 'down', 'left', 'right', 'a', 'b', 'c', 'x', 'y', 'z', 'start'}
local t_btnEnabled = {up = true, down = true, left = true, right = true, a = true, b = true, c = true, x = true, y = true, z = true, start = true}
for k, v in ipairs(t_keyCfg) do
	if t_btnEnabled[v.itemname] ~= nil then
		t_btnEnabled[v.itemname] = true
	end
end

function options.f_keyDefault()
	local presetId = controlState.currentPreset ~= '' and controlState.currentPreset or controlDefaultPresetId
	if presetId ~= '' then
		applyPresetToConfig(presetId)
		resetRemapInput()
		return
	end
	local btns = {}
	for i = 1, #config.KeyConfig do
		if i == 1 then
			btns = {up = 'UP', down = 'DOWN', left = 'LEFT', right = 'RIGHT', a = 'z', b = 'x', c = 'c', x = 'a', y = 's', z = 'd', start = 'RETURN', d = 'q', w = 'w'}
		elseif i == 2 then
			btns = {up = 'i', down = 'k', left = 'j', right = 'l', a = 'f', b = 'g', c = 'h', x = 'r', y = 't', z = 'y', start = 'RSHIFT', d = 'LBRACKET', w = 'RBRACKET'}
		else
			btns = {}
		end
		for j = 1, #config.KeyConfig[i].Buttons do
			if not t_btnEnabled[t_btnNumName[j]] or btns[t_btnNumName[j]] == nil then
				config.KeyConfig[i].Buttons[j] = tostring(motif.option_info.menu_valuename_nokey)
			else
				config.KeyConfig[i].Buttons[j] = btns[t_btnNumName[j]]
			end
		end
	end
	btns = {up = '10', down = '12', left = '13', right = '11', a = '0', b = '1', c = '5', x = '2', y = '3', z = '-12', start = '7', d = '4', w = '-10', menu = '6'}
	for i = 1, #config.JoystickConfig do
		for j = 1, #config.JoystickConfig[i].Buttons do
			if not t_btnEnabled[t_btnNumName[j]] or btns[t_btnNumName[j]] == nil then
				config.JoystickConfig[i].Buttons[j] = tostring(motif.option_info.menu_valuename_nokey)
			else
				config.JoystickConfig[i].Buttons[j] = btns[t_btnNumName[j]]
			end
		end
	end
	resetRemapInput()
end
if config.FirstRun then
	options.f_keyDefault()
end

function options.f_keyCfgReset(cfgType)
	t_keyList = {}
	for i = 1, #config[cfgType] do
		local jn = config[cfgType][i].Joystick
		if t_keyList[jn] == nil then
			t_keyList[jn] = {} --creates subtable for each controller (1 for all keyboard configs, new one for each gamepad)
			t_conflict[jn] = false --set default conflict flag for each controller
		end
		for k, v in ipairs(t_keyCfg) do
			if config[cfgType][i].Buttons[t_btnNameNum[v.itemname]] ~= nil then
				local btn = tostring(config[cfgType][i].Buttons[t_btnNameNum[v.itemname]])
				t_keyCfg[k]['vardisplay' .. i] = btn
				if btn ~= tostring(motif.option_info.menu_valuename_nokey) then --if button is not disabled
					t_keyList[jn][btn] = (t_keyList[jn][btn] or 0) + 1
				end
			end
		end
	end
	updatePresetHeader()
end

function options.f_keyCfgInit(cfgType, title)
	resetKey()
	main.f_cmdInput()
	cursorPosY = 2
	item = 2
	item_start = 2
	t_pos = {motif.option_info.keymenu_p1_pos, motif.option_info.keymenu_p2_pos}
	configall = false
	key = ''
	t_conflict = {}
	t_savedConfig = main.f_tableCopy(config[cfgType])
	btnReleased = false
	player = 1
	side = 1
	btn = ''
	options.txt_title:update({text = title})
	keyCfgStage = 'preset'
	if cfgType ~= 'KeyConfig' then
		keyCfgStage = 'grid'
		controlSnapshotConfig = {}
	end
	editingPresetId = ''
	presetCursor = capturePresetIndex()
	local presetId = controlState.currentPreset ~= '' and controlState.currentPreset or controlDefaultPresetId
	if presetId ~= '' then
		applyPresetToConfig(presetId)
	end
	updatePresetHeader()
	options.f_keyCfgReset(cfgType)
	joyNum = config[cfgType][player].Joystick
end

local function f_keyPreset(cfgType, bgdef, skipClear)
	-- Force the preset picker to render over the title background (fallbacks to provided bg)
	local targetBg = 'titlebgdef'
	if motif[targetBg] == nil then
		if bgdef ~= nil and motif[bgdef] ~= nil then
			targetBg = bgdef
		elseif motif.optionbgdef ~= nil then
			targetBg = 'optionbgdef'
		end
	end
	local lcw = (motif and motif.info and motif.info.localcoord and motif.info.localcoord[1]) or 640
	local baseX = math.floor(lcw / 2 - 150)
	local baseY = 70
	local lineSpacing = 20
	local cursorW = 320
	local cursorH = 15
	if #presetTextItems == 0 then
		keyCfgStage = 'grid'
		return true
	end
	if esc() or main.f_input(main.t_players, {'m'}) then
		menu.itemname = ''
		return false
	end
	if main.f_input(main.t_players, {'$U'}) then
		presetCursor = (presetCursor - 2 + #presetTextItems) % #presetTextItems + 1
	elseif main.f_input(main.t_players, {'$D'}) then
		presetCursor = (presetCursor % #presetTextItems) + 1
	end
	local currentPreset = presetTextItems[presetCursor]
	if main.f_input(main.t_players, {'pal', 's'}) then
		applyPresetToConfig(currentPreset.id)
		controlState.currentPreset = currentPreset.id
		options.modified = true
	elseif getKey('SPACE') then
		editingPresetId = currentPreset.id
		snapshotConfigFromPreset(currentPreset.id)
		keyCfgStage = 'grid'
		configall = false
		captureItem = nil
		item = item_start
		cursorPosY = item_start
		options.f_keyCfgReset(cfgType)
		main.f_cmdBufReset()
	end
	if not skipClear then
		clearColor(motif[targetBg].bgclearcolor[1], motif[targetBg].bgclearcolor[2], motif[targetBg].bgclearcolor[3])
	end
	bgDraw(motif[targetBg].bg, false)
	options.txt_title:draw()
	txt_presetHeader:update({
		font = motif.option_info.keymenu_item_font[1],
		bank = motif.option_info.keymenu_item_font[2],
		align = motif.option_info.keymenu_item_font[3],
		text = 'Choose Control Preset',
		x = baseX,
		y = baseY - lineSpacing * 1.2,
		scaleX = 0.7,
		scaleY = 0.7,
		r = motif.option_info.keymenu_item_font[4],
		g = motif.option_info.keymenu_item_font[5],
		b = motif.option_info.keymenu_item_font[6],
		height = motif.option_info.keymenu_item_font[7],
		defsc = motif.defaultOptions,
	})
	txt_presetHeader:draw()
	for i, preset in ipairs(presetTextItems) do
		local active = i == presetCursor
		local selected = preset.id == controlState.currentPreset
		local mark = selected and '✔ ' or '  '
		local fontBlock = active and motif.option_info.keymenu_item_active_font or motif.option_info.keymenu_item_font
		txt_presetItems[i]:update({
			font = fontBlock[1],
			bank = fontBlock[2],
			align = fontBlock[3],
			text = mark .. preset.name,
			x = baseX,
			y = baseY + (i - 1) * lineSpacing+ 5,
			scaleX = (fontBlock[8] or 1) * 0.7,
			scaleY = (fontBlock[9] or 1) * 0.7,
			r = fontBlock[4],
			g = fontBlock[5],
			b = fontBlock[6],
			height = fontBlock[7],
			defsc = motif.defaultOptions,
		})
		txt_presetItems[i]:draw()
	end
	txt_presetHint:update({
		font = motif.option_info.keymenu_item_info_font[1],
		bank = motif.option_info.keymenu_item_info_font[2],
		align = motif.option_info.keymenu_item_info_font[3],
		text = 'Enter = Select | Space = Edit | Esc = Back',
		x = baseX + 200,
		y = baseY + (#presetTextItems + 1.5) * lineSpacing,
		scaleX = 0.55,
		scaleY = 0.55,
		r = motif.option_info.keymenu_item_info_font[4],
		g = motif.option_info.keymenu_item_info_font[5],
		b = motif.option_info.keymenu_item_info_font[6],
		height = motif.option_info.keymenu_item_info_font[7],
		defsc = motif.defaultOptions,
	})
	txt_presetHint:draw()
	if motif.option_info.menu_boxcursor_visible == 1 then
		local src, dst = main.f_boxcursorAlpha(
			motif.option_info.menu_boxcursor_alpharange[1],
			motif.option_info.menu_boxcursor_alpharange[2],
			motif.option_info.menu_boxcursor_alpharange[3],
			motif.option_info.menu_boxcursor_alpharange[4],
			motif.option_info.menu_boxcursor_alpharange[5],
			motif.option_info.menu_boxcursor_alpharange[6]
		)
		rect_presetCursor:update({
			x1 = baseX - 8,
			y1 = baseY + (presetCursor - 1) * lineSpacing - 4,
			x2 = cursorW,
			y2 = cursorH + 2,
			src = src,
			dst = dst,
		})
		rect_presetCursor:draw()
	end
	bgDraw(motif[targetBg].bg, true)
	main.f_cmdInput()
	if not skipClear then
		refresh()
	end
	return true
end

function options.f_keyCfg(cfgType, controller, bgdef, skipClear)
if keyCfgStage == 'preset' then
	return f_keyPreset(cfgType, bgdef, skipClear)
end
local t = t_keyCfg
	local function skipHidden(direction)
		while t[item] ~= nil and t[item].itemname == 'page' do
			if direction == 'up' then
				item = item - 1
				if item < item_start then
					item = #t
				end
			else
				item = item + 1
				if item > #t then
					item = item_start
				end
			end
		end
		cursorPosY = item
	end
	if configall then
		key = ''
		if getKey('SPACE') then
			key = 'SPACE'
		elseif cfgType == 'KeyConfig' then
			key = getKey()
		else
			local tmp = getJoystickKey(joyNum)
			if tonumber(tmp) == nil then
				btnReleased = true
			elseif btnReleased then
				key = tmp
				btnReleased = false
			end
			key = tostring(key)
		end
		if key ~= '' then
			if key == 'SPACE' then
				sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
				if t_keyList[joyNum][btn] ~= nil and t_keyList[joyNum][btn] > 1 then
					t_keyList[joyNum][btn] = t_keyList[joyNum][btn] - 1
				else
					t_keyList[joyNum][btn] = nil
				end
				t[captureItem or item]['vardisplay' .. player] = motif.option_info.menu_valuename_nokey
				config[cfgType][player].Buttons[t_btnNameNum[t[captureItem or item].itemname]] = tostring(motif.option_info.menu_valuename_nokey)
				options.modified = true
			elseif cfgType == 'KeyConfig' or (cfgType == 'JoystickConfig' and tonumber(key) ~= nil) then
				sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
				if t_keyList[joyNum][btn] ~= nil and t_keyList[joyNum][btn] > 1 then
					t_keyList[joyNum][btn] = t_keyList[joyNum][btn] - 1
				else
					t_keyList[joyNum][btn] = nil
				end
				for k, v in ipairs(t) do
					if v['vardisplay' .. player] == key then
						v['vardisplay' .. player] = tostring(motif.option_info.menu_valuename_nokey)
						config[cfgType][player].Buttons[t_btnNameNum[v.itemname]] = tostring(motif.option_info.menu_valuename_nokey)
						if t_keyList[joyNum][key] ~= nil and t_keyList[joyNum][key] > 1 then
							t_keyList[joyNum][key] = t_keyList[joyNum][key] - 1
						else
							t_keyList[joyNum][key] = nil
						end
					end
				end
				if t_keyList[joyNum][key] == nil then
					t_keyList[joyNum][key] = 1
				else
					t_keyList[joyNum][key] = t_keyList[joyNum][key] + 1
				end
				t[captureItem or item]['vardisplay' .. player] = key
				config[cfgType][player].Buttons[t_btnNameNum[t[captureItem or item].itemname]] = key
				options.modified = true
			end
			configall = false
			captureItem = nil
			for pn = 1, #config[cfgType] do
				setKeyConfig(pn, config[cfgType][pn].Joystick, config[cfgType][pn].Buttons)
			end
			options.f_keyCfgReset(cfgType)
			main.f_cmdBufReset()
			key = ''
		end
		resetKey()
	else
		key = getKey()
		if key == 'F1' then
			player = 1
			side = main.f_playerSide(player)
			joyNum = config[cfgType][player].Joystick
		elseif key == 'F2' then
			player = 2
			side = main.f_playerSide(player)
			joyNum = config[cfgType][player].Joystick
		end
		if esc() or main.f_input(main.t_players, {'m'}) then
			if cfgType == 'KeyConfig' and controlSnapshotConfig[1] ~= nil then
				for pn = 1, #controlSnapshotConfig do
					if controlSnapshotConfig[pn] ~= nil and config.KeyConfig[pn] ~= nil then
						config.KeyConfig[pn].Buttons = main.f_tableCopy(controlSnapshotConfig[pn].Buttons)
						setKeyConfig(pn, config.KeyConfig[pn].Joystick, config.KeyConfig[pn].Buttons)
					end
				end
			end
			options.f_keyCfgReset(cfgType)
			keyCfgStage = 'preset'
			configall = false
			captureItem = nil
			presetCursor = capturePresetIndex()
			return true
		elseif main.f_input(main.t_players, {'$F'}) and player + 1 <= #config[cfgType] then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			player = player + 1
			side = main.f_playerSide(player)
			joyNum = config[cfgType][player].Joystick
		elseif main.f_input(main.t_players, {'$B'}) and player - 1 >= 1 then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			player = player - 1
			side = main.f_playerSide(player)
			joyNum = config[cfgType][player].Joystick
		elseif main.f_input(main.t_players, {'$U'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			item = item - 1
			if item < item_start then
				item = #t
			end
			skipHidden('up')
		elseif main.f_input(main.t_players, {'$D'}) then
			sndPlay(motif.files.snd_data, motif.option_info.cursor_move_snd[1], motif.option_info.cursor_move_snd[2])
			item = item + 1
			if item > #t then
				item = item_start
			end
			skipHidden('down')
		elseif t[item].itemname == 'page' and key == 'TAB' then
			return true
		elseif main.f_input(main.t_players, {'pal', 's'}) then
			local itemName = t[item].itemname
			if t_btnNameNum[itemName] ~= nil then
				captureItem = item
				configall = true
				btn = tostring(config[cfgType][player].Buttons[t_btnNameNum[itemName]] or motif.option_info.menu_valuename_nokey)
			elseif itemName == 'revert' and cfgType == 'KeyConfig' then
				revertPlayerToDefault(editingPresetId ~= '' and editingPresetId or controlState.currentPreset, player)
				t_savedConfig[player] = main.f_tableCopy(config[cfgType][player])
				options.modified = true
				options.f_keyCfgReset(cfgType)
			elseif itemName == 'saveexit' then
				if cfgType == 'KeyConfig' then
					saveConfigToBindings(editingPresetId ~= '' and editingPresetId or controlState.currentPreset)
				end
				options.modified = true
				keyCfgStage = 'preset'
				configall = false
				captureItem = nil
				presetCursor = capturePresetIndex()
				return true
			elseif itemName == 'exitnosave' then
				if cfgType == 'KeyConfig' and controlSnapshotConfig[1] ~= nil then
					for pn = 1, #controlSnapshotConfig do
						if controlSnapshotConfig[pn] ~= nil and config.KeyConfig[pn] ~= nil then
							config.KeyConfig[pn].Buttons = main.f_tableCopy(controlSnapshotConfig[pn].Buttons)
							setKeyConfig(pn, config.KeyConfig[pn].Joystick, config.KeyConfig[pn].Buttons)
						end
					end
				end
				options.f_keyCfgReset(cfgType)
				keyCfgStage = 'preset'
				configall = false
				captureItem = nil
				presetCursor = capturePresetIndex()
				return true
			end
		end
		resetKey()
	end
	t_conflict[joyNum] = false
	--draw clearcolor
	if not skipClear then
		clearColor(motif[bgdef].bgclearcolor[1], motif[bgdef].bgclearcolor[2], motif[bgdef].bgclearcolor[3])
	end
	--draw layerno = 0 backgrounds
	bgDraw(motif[bgdef].bg, false)
	local visibleCount = 0
	for i = 1, #t do
		if t[i].itemname ~= 'page' then
			visibleCount = visibleCount + 1
		end
	end
	--draw menu box
	if motif.option_info.menu_boxbg_visible == 1 then
		for i = 1, 2 do
			rect_boxbg:update({
				x1 = t_pos[i][1] + motif.option_info.keymenu_boxcursor_coords[1],
				y1 = t_pos[i][2] + motif.option_info.keymenu_boxcursor_coords[2],
				x2 = motif.option_info.keymenu_boxcursor_coords[3] - motif.option_info.keymenu_boxcursor_coords[1] + 1,
				y2 = motif.option_info.keymenu_boxcursor_coords[4] - motif.option_info.keymenu_boxcursor_coords[2] + 1 + (visibleCount - 1) * motif.option_info.keymenu_item_spacing[2],
			})
			rect_boxbg:draw()
		end
	end
	--draw title
	options.txt_title:draw()
	--draw player num
	for i = 1, 2 do
		txt_keyController[i]:update({
			font =   motif.option_info['keymenu_item_p' .. i .. '_font'][1],
			bank =   motif.option_info['keymenu_item_p' .. i .. '_font'][2],
			align =  motif.option_info['keymenu_item_p' .. i .. '_font'][3],
			text =   motif.option_info.keymenu_itemname_playerno:gsub('%%i', tostring(i + player - side)),
			x =      motif.option_info['keymenu_p' .. i .. '_pos'][1] + motif.option_info['keymenu_item_p' .. i .. '_offset'][1],
			y =      motif.option_info['keymenu_p' .. i .. '_pos'][2] + motif.option_info['keymenu_item_p' .. i .. '_offset'][2],
			scaleX = motif.option_info['keymenu_item_p' .. i .. '_scale'][1],
			scaleY = motif.option_info['keymenu_item_p' .. i .. '_scale'][2],
			r =      motif.option_info['keymenu_item_p' .. i .. '_font'][4],
			g =      motif.option_info['keymenu_item_p' .. i .. '_font'][5],
			b =      motif.option_info['keymenu_item_p' .. i .. '_font'][6],
			height = motif.option_info['keymenu_item_p' .. i .. '_font'][7],
			defsc =  motif.defaultOptions,
		})
		txt_keyController[i]:draw()
	end
	--draw menu items
	for i = 1, #t do
		if t[i].itemname ~= 'page' then
		for j = 1, 2 do
			if i > item - cursorPosY then
				if j == 1 then --left side
					if t[i].itemname == 'page' then
						t[i].displayname = motif.option_info.keymenu_itemname_back
						t[i].infodisplay = motif.option_info.menu_valuename_esc
					end
				else --right side
					if t[i].itemname == 'page' then
						if #config[cfgType] > 2 then
							t[i].displayname = motif.option_info.keymenu_itemname_page
							t[i].infodisplay = motif.option_info.menu_valuename_page
						else
							t[i].displayname = motif.option_info.keymenu_itemname_back
							t[i].infodisplay = motif.option_info.menu_valuename_esc
						end
					end
				end
				if i == item and j == side then --active item
					--draw active item background
					if t[i].paramname ~= nil then
						animDraw(motif.option_info['keymenu_bg_active_' .. t[i].itemname .. '_data'])
						animUpdate(motif.option_info['keymenu_bg_active_' .. t[i].itemname .. '_data'])
					end
					--draw displayname
					t[i].data[j]:update({
						font =   motif.option_info.keymenu_item_active_font[1],
						bank =   motif.option_info.keymenu_item_active_font[2],
						align =  motif.option_info.keymenu_item_active_font[3],
						text =   t[i].displayname,
						x =      t_pos[j][1] + motif.option_info.keymenu_item_active_offset[1] + (i - 1) * motif.option_info.keymenu_item_spacing[1],
						y =      t_pos[j][2] + motif.option_info.keymenu_item_active_offset[2] + (i - 1) * motif.option_info.keymenu_item_spacing[2],
						scaleX = motif.option_info.keymenu_item_active_scale[1],
						scaleY = motif.option_info.keymenu_item_active_scale[2],
						r =      motif.option_info.keymenu_item_active_font[4],
						g =      motif.option_info.keymenu_item_active_font[5],
						b =      motif.option_info.keymenu_item_active_font[6],
						height = motif.option_info.keymenu_item_active_font[7],
						defsc =  motif.defaultOptions,
					})
					t[i].data[j]:draw()
					--draw vardata
					if t[i].vardata ~= nil then
						if t_keyList[joyNum][tostring(t[i]['vardisplay' .. j + player - side])] ~= nil and t_keyList[joyNum][tostring(t[i]['vardisplay' .. j + player - side])] > 1 then
							t[i].vardata[j]:update({
								font =   motif.option_info.keymenu_item_value_conflict_font[1],
								bank =   motif.option_info.keymenu_item_value_conflict_font[2],
								align =  motif.option_info.keymenu_item_value_conflict_font[3],
								text =   t[i]['vardisplay' .. j + player - side],
								x =      t_pos[j][1] + motif.option_info.keymenu_item_value_conflict_offset[1] + (i - 1) * motif.option_info.keymenu_item_spacing[1],
								y =      t_pos[j][2] + motif.option_info.keymenu_item_value_conflict_offset[2] + (i - 1) * motif.option_info.keymenu_item_spacing[2],
								scaleX = motif.option_info.keymenu_item_value_conflict_scale[1],
								scaleY = motif.option_info.keymenu_item_value_conflict_scale[2],
								r =      motif.option_info.keymenu_item_value_conflict_font[4],
								g =      motif.option_info.keymenu_item_value_conflict_font[5],
								b =      motif.option_info.keymenu_item_value_conflict_font[6],
								height = motif.option_info.keymenu_item_value_conflict_font[7],
								defsc =  motif.defaultOptions,
							})
							t[i].vardata[j]:draw()
							t_conflict[joyNum] = true
						else
							t[i].vardata[j]:update({
								font =   motif.option_info.keymenu_item_value_active_font[1],
								bank =   motif.option_info.keymenu_item_value_active_font[2],
								align =  motif.option_info.keymenu_item_value_active_font[3],
								text =   t[i]['vardisplay' .. j + player - side],
								x =      t_pos[j][1] + motif.option_info.keymenu_item_value_active_offset[1] + (i - 1) * motif.option_info.keymenu_item_spacing[1],
								y =      t_pos[j][2] + motif.option_info.keymenu_item_value_active_offset[2] + (i - 1) * motif.option_info.keymenu_item_spacing[2],
								scaleX = motif.option_info.keymenu_item_value_active_scale[1],
								scaleY = motif.option_info.keymenu_item_value_active_scale[2],
								r =      motif.option_info.keymenu_item_value_active_font[4],
								g =      motif.option_info.keymenu_item_value_active_font[5],
								b =      motif.option_info.keymenu_item_value_active_font[6],
								height = motif.option_info.keymenu_item_value_active_font[7],
								defsc =  motif.defaultOptions,
							})
							t[i].vardata[j]:draw()
						end
					--draw infodata
					elseif t[i].infodata ~= nil then
						t[i].infodata[j]:update({
							font =   motif.option_info.keymenu_item_info_active_font[1],
							bank =   motif.option_info.keymenu_item_info_active_font[2],
							align =  motif.option_info.keymenu_item_info_active_font[3],
							text =   t[i].infodisplay,
							x =      t_pos[j][1] + motif.option_info.keymenu_item_info_active_offset[1] + (i - 1) * motif.option_info.keymenu_item_spacing[1],
							y =      t_pos[j][2] + motif.option_info.keymenu_item_info_active_offset[2] + (i - 1) * motif.option_info.keymenu_item_spacing[2],
							scaleX = motif.option_info.keymenu_item_value_active_scale[1],
							scaleY = motif.option_info.keymenu_item_value_active_scale[2],
							r =      motif.option_info.keymenu_item_info_active_font[4],
							g =      motif.option_info.keymenu_item_info_active_font[5],
							b =      motif.option_info.keymenu_item_info_active_font[6],
							height = motif.option_info.keymenu_item_info_active_font[7],
							defsc =  motif.defaultOptions,
						})
						t[i].infodata[j]:draw()
					end
				else --inactive item
					--draw active item background
					if t[i].paramname ~= nil then
						animDraw(motif.option_info['keymenu_bg_' .. t[i].itemname .. '_data'])
						animUpdate(motif.option_info['keymenu_bg_' .. t[i].itemname .. '_data'])
					end
					--draw displayname
					t[i].data[j]:update({
						font =   motif.option_info.keymenu_item_font[1],
						bank =   motif.option_info.keymenu_item_font[2],
						align =  motif.option_info.keymenu_item_font[3],
						text =   t[i].displayname,
						x =      t_pos[j][1] + motif.option_info.keymenu_item_offset[1] + (i - 1) * motif.option_info.keymenu_item_spacing[1],
						y =      t_pos[j][2] + motif.option_info.keymenu_item_offset[2] + (i - 1) * motif.option_info.keymenu_item_spacing[2],
						scaleX = motif.option_info.keymenu_item_scale[1],
						scaleY = motif.option_info.keymenu_item_scale[2],
						r =      motif.option_info.keymenu_item_font[4],
						g =      motif.option_info.keymenu_item_font[5],
						b =      motif.option_info.keymenu_item_font[6],
						height = motif.option_info.keymenu_item_font[7],
						defsc =  motif.defaultOptions,
					})
					t[i].data[j]:draw()
					--draw vardata
					if t[i].vardata ~= nil then
						if t_keyList[joyNum][tostring(t[i]['vardisplay' .. j + player - side])] ~= nil and t_keyList[joyNum][tostring(t[i]['vardisplay' .. j + player - side])] > 1 then
							t[i].vardata[j]:update({
								font =   motif.option_info.keymenu_item_value_conflict_font[1],
								bank =   motif.option_info.keymenu_item_value_conflict_font[2],
								align =  motif.option_info.keymenu_item_value_conflict_font[3],
								text =   t[i]['vardisplay' .. j + player - side],
								x =      t_pos[j][1] + motif.option_info.keymenu_item_value_conflict_offset[1] + (i - 1) * motif.option_info.keymenu_item_spacing[1],
								y =      t_pos[j][2] + motif.option_info.keymenu_item_value_conflict_offset[2] + (i - 1) * motif.option_info.keymenu_item_spacing[2],
								scaleX = motif.option_info.keymenu_item_value_conflict_scale[1],
								scaleY = motif.option_info.keymenu_item_value_conflict_scale[2],
								r =      motif.option_info.keymenu_item_value_conflict_font[4],
								g =      motif.option_info.keymenu_item_value_conflict_font[5],
								b =      motif.option_info.keymenu_item_value_conflict_font[6],
								height = motif.option_info.keymenu_item_value_conflict_font[7],
								defsc =  motif.defaultOptions,
							})
							t[i].vardata[j]:draw()
							t_conflict[joyNum] = true
						else
							t[i].vardata[j]:update({
								font =   motif.option_info.keymenu_item_value_font[1],
								bank =   motif.option_info.keymenu_item_value_font[2],
								align =  motif.option_info.keymenu_item_value_font[3],
								text =   t[i]['vardisplay' .. j + player - side],
								x =      t_pos[j][1] + motif.option_info.keymenu_item_value_offset[1] + (i - 1) * motif.option_info.keymenu_item_spacing[1],
								y =      t_pos[j][2] + motif.option_info.keymenu_item_value_offset[2] + (i - 1) * motif.option_info.keymenu_item_spacing[2],
								scaleX = motif.option_info.keymenu_item_value_scale[1],
								scaleY = motif.option_info.keymenu_item_value_scale[2],
								r =      motif.option_info.keymenu_item_value_font[4],
								g =      motif.option_info.keymenu_item_value_font[5],
								b =      motif.option_info.keymenu_item_value_font[6],
								height = motif.option_info.keymenu_item_value_font[7],
								defsc =  motif.defaultOptions,
							})
							t[i].vardata[j]:draw()
						end
					--draw infodata
					elseif t[i].infodata ~= nil then
						t[i].infodata[j]:update({
							font =   motif.option_info.keymenu_item_info_font[1],
							bank =   motif.option_info.keymenu_item_info_font[2],
							align =  motif.option_info.keymenu_item_info_font[3],
							text =   t[i].infodisplay,
							x =      t_pos[j][1] + motif.option_info.keymenu_item_info_offset[1] + (i - 1) * motif.option_info.keymenu_item_spacing[1],
							y =      t_pos[j][2] + motif.option_info.keymenu_item_info_offset[2] + (i - 1) * motif.option_info.keymenu_item_spacing[2],
							scaleX = motif.option_info.keymenu_item_value_active_scale[1],
							scaleY = motif.option_info.keymenu_item_value_active_scale[2],
							r =      motif.option_info.keymenu_item_info_font[4],
							g =      motif.option_info.keymenu_item_info_font[5],
							b =      motif.option_info.keymenu_item_info_font[6],
							height = motif.option_info.keymenu_item_info_font[7],
							defsc =  motif.defaultOptions,
						})
						t[i].infodata[j]:draw()
					end
				end
			end
		end
		end
	end
	--draw bottom hint text (smaller, anchored below the grid)
	local hintY = math.max(t_pos[1][2], t_pos[2][2]) + (visibleCount + 1) * motif.option_info.keymenu_item_spacing[2]
	txt_gridHint:update({
		font = motif.option_info.keymenu_item_info_font[1],
		bank = motif.option_info.keymenu_item_info_font[2],
		align = motif.option_info.keymenu_item_info_font[3],
		text = 'Enter = Edit/Assign | F1=P1 | F2=P2 | Esc = Back',
		x = t_pos[1][1] + motif.option_info.keymenu_item_info_offset[1],
		y = hintY,
		scaleX = 0.55,
		scaleY = 0.55,
		r = motif.option_info.keymenu_item_info_font[4],
		g = motif.option_info.keymenu_item_info_font[5],
		b = motif.option_info.keymenu_item_info_font[6],
		height = motif.option_info.keymenu_item_info_font[7],
		defsc = motif.defaultOptions,
	})
	txt_gridHint:draw()
	--draw menu cursor
	if motif.option_info.menu_boxcursor_visible == 1 then
		local src, dst = main.f_boxcursorAlpha(
			motif.option_info.menu_boxcursor_alpharange[1],
			motif.option_info.menu_boxcursor_alpharange[2],
			motif.option_info.menu_boxcursor_alpharange[3],
			motif.option_info.menu_boxcursor_alpharange[4],
			motif.option_info.menu_boxcursor_alpharange[5],
			motif.option_info.menu_boxcursor_alpharange[6]
		)
		for i = 1, 2 do
			if i == side then
				rect_boxcursor:update({
					x1 = t_pos[i][1] + motif.option_info.keymenu_boxcursor_coords[1] + (cursorPosY - 1) * motif.option_info.keymenu_item_spacing[1],
					y1 = t_pos[i][2] + motif.option_info.keymenu_boxcursor_coords[2] + (cursorPosY - 1) * motif.option_info.keymenu_item_spacing[2],
					x2 = motif.option_info.keymenu_boxcursor_coords[3] - motif.option_info.keymenu_boxcursor_coords[1] + 1,
					y2 = motif.option_info.keymenu_boxcursor_coords[4] - motif.option_info.keymenu_boxcursor_coords[2] + 1,
					src = src,
					dst = dst,
				})
				rect_boxcursor:draw()
			end
		end
	end
	--draw layerno = 1 backgrounds
	bgDraw(motif[bgdef].bg, true)
	main.f_cmdInput()
	if not skipClear then
		refresh()
	end
	return true
end

return options
