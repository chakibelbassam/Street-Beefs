# Street Beefs (Ikemen GO Mod)

## Quickstart (play + test AI vs AI)
1. Run `Street Beefs.exe`.
2. On the main menu, press **Arrow Down** to highlight **VS Mode**, then press **Enter**.
3. In the character select:
   - Move to **Chakib** (custom Mizoguchi). Press **K** to confirm.
   - Move to **Kung Fu Man**. Press **X** to confirm.
4. When the match starts, press **Ctrl+1** (P1 AI) and **Ctrl+2** (P2 AI) to engage both characters’ AIs.
5. Watch the match; Mizoguchi’s AI will surface thought bubbles describing its current plan (pressure/keepaway/frustration/etc.).

## Changing Controls (preset system)
1. From the main menu, go to **Options** → **Key Config**.
2. The first screen is the **Preset** picker. Use **Up/Down** to select a preset; **Enter** to apply.
3. To edit bindings, enter the binding screen, change keys, then **Save** to persist. **Reset** restores the preset defaults. **Cancel** restores the snapshot taken on entry.
4. Presets live in `data/control_presets.json`; runtime bindings in `save/control_bindings.json`.

## Project Overview
Street Beefs builds on Ikemen GO v0.99.0 with:
- **AI intent overlay**: `external/mods/ai_thoughts.lua` reads per-character vars (51/52) and renders thought bubbles with category colors and randomized text variants.
- **Character AI upgrade**: `chars/chak/Mizoguchixiii.cmd` adds plan locks (corner pressure, keepaway, frustration), frustration meter, pattern checks, and emits thought IDs/categories.
- **Controls UX**: Preset-driven keybinding UI in `external/script/options.lua`, backed by JSON presets and saved bindings.
- **Screenpack assets**: Custom backgrounds under `assets/`; trimmed roster in `data/select.def`.
- **Content**: Custom Mizoguchi port (`chars/chak`), added Jon Moxley slot, custom stage (`stages/Mizoguchixiii.*`).

## Notable Files
- `external/mods/ai_thoughts.lua` — AI thought HUD overlay.
- `chars/chak/Mizoguchixiii.cmd` — AI logic and thought emission.
- `external/script/options.lua` — Control preset picker, save/load/reset.
- `data/control_presets.json` — Preset definitions (5 presets shipped).
- `save/control_bindings.json` — Last-used preset + resolved bindings.
- `data/system.def` — Screenpack backgrounds/menu tweaks.
- `data/select.def` — Roster/stage entries.

## Workflow: Inspect AI vs Mugen AI
1. Follow Quickstart to launch VS MODE and engage both AIs.
2. Observe Mizoguchi’s thought bubbles to see plan transitions (corner pressure, keepaway, frustration).
3. To adjust AI text or colors: edit `external/mods/ai_thoughts.lua` (thoughts table, categoryStyles).
4. To tweak AI triggers/locks: edit `chars/chak/Mizoguchixiii.cmd` (states setting `var(51/52/60/61/62)`).

## Cleaning note
Ephemeral files removed: `Ikemen.log`, `Screenshot 2025-11-26 225533.png`. Baseline engine kept at `Ikemen_GO-v0.99.0-windows/` for reference.
# Street-Beefs
