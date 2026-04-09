# Changelog

## 1.0.5

- Reworked the multi-character cooldown view into a combined recipe list with a character column
- Added recipe sorting by recipe name, character, ready first, and longest remaining first
- Kept quick-craft actions limited to ready recipes owned by the current character
- Improved automatic cooldown window width for long recipe names
- Reworked config character selection to support per-character recipe filters with pending changes until save
- Fixed multiple Turtle/Vanilla Lua scope issues in the character selection flow

## 1.0.4

- Added account-wide character cooldown aggregation with optional other-character tabs
- Added character visibility filters and tab sorting options in the config window
- Improved cooldown window tab styling and stabilized width across tab switches
- Fixed character list issues caused by per-character saved variable migration
- Fixed Blizzard tab template errors and reduced delay when switching character tabs
- Reworked multiple config layout issues and improved options window behavior

## 1.0.3

- Added support for resizing the cooldown window with a bottom-right resize grip
- Saved manual cooldown window size per character
- Added automatic fallback to content-based window sizing when more enabled recipes no longer fit
- Improved ready notifications so linked cooldowns only trigger one sound and one combined message
- Completed localization coverage for material availability lines and test-ready messages across Turtle WoW client languages
- Improved visibility and behavior of the resize grip for Turtle/Vanilla clients

## 1.0.2

- Fixed duplicate recipe entries that could appear during active cooldowns
- Improved recipe deduplication between static and dynamically discovered cooldown recipes
- Refined options window layout and control placement
- Added full localization coverage for newer options and ready notification texts

## 1.0.1

- Added Gardening and Survival profession support
- Added dynamic cooldown recipe discovery for Turtle professions
- Added full options window with recipe visibility filters
- Added minimap right-click and header gear button to open options
- Added ready notifications with optional sound and center-screen message
- Added test button and separate toggles for ready sound and ready message
- Improved localization coverage for all supported Turtle WoW client languages
- Improved options window sizing and layout behavior
- Fixed multiple Turtle/Vanilla compatibility issues in the config UI
- Hidden empty profession categories in the cooldown window

## 1.0.0

- Initial public release
- Movable cooldown frame with dynamic width
- Ready state and live cooldown timers
- Quick-craft hammer button
- Material checks with bank snapshot hints
- Minimap toggle button
