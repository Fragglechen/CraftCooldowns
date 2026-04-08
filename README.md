# Craft Cooldowns

Profession cooldown tracker for Turtle WoW.

## Features

- Movable cooldown window
- Shows learned cooldown recipes from supported professions
- `Frei` or live remaining cooldown timer
- Small hammer button for quick crafting
- Material check from bags
- Bank snapshot support for missing material hints
- Minimap button to show or hide the window
- Dynamic frame width for longer recipe names

## Supported professions

- `Alchemy`
- `Tailoring`

## Usage

- Open each supported profession once so the addon can scan learned cooldown recipes
- Left-click the hammer button to craft a ready recipe
- Left-click the minimap button to show or hide the main window
- Drag the main window with the left mouse button
- Drag the minimap button to move it around the minimap

## Slash commands

- `/ccd`
- `/craftcd`
- `/ccd scan`
- `/ccd reset`

## Bank snapshot

To include bank materials in the missing-material hints, open the bank at least once on that character.

## Release

Use the release build script to prepare a clean release folder and zip:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\Build-Release.ps1
```

The script creates `_release\CraftCooldowns` and `_release\CraftCooldowns-1.0.1.zip`.

## License

See [LICENSE](LICENSE).
