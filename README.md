# big-clock

A fullscreen web clock with large display styles, floating timers, world clocks, dynamic themes, alarm effects, and a highly interactive layout.

## Features

- **Large Centered Fullscreen Clock**
- **Dynamic Date & Timezones**: Automatically positioned date, timezone, and Chinese Lunar Date display.
- **World Clocks**: Live pinned clocks for New York, London, and Beijing.
- **Multiple Clock Styles**: Default, LED Neon Green/Blue/Orange, Mixed Neon, 7-Segment, Flip Clock, and Retro Tech.
- **Customizable Themes**: Dark, Midnight Blue, Deep Forest, or even upload your own **Custom Image Background**.
- **Adjustable Display**: Scale the main clock size, or adjust UI panel opacity.
- **Interactive To-Do List**: Built-in floating to-do list featuring native **HTML5 Drag & Drop sorting** and one-click removal.
- **Floating Timers**: Persistent quick timer presets, plus a custom hours/minutes timer.
- **Alarm Customizations**: Choose between Default, Digital Beep, or Marimba. Features an auto-firing screen shake effect and an alarm stop modal.
- **Auto-Hiding Menus**: The settings menu cleanly tucks itself into a capsule icon when your mouse leaves the area.
- **Local Persistence**: Remembers literally everything contextually (clock style, theme, custom background, sounds, active to-dos, panel opacities, and collapsed states).

## Controls / Hotkeys

### Main Controls
- `F` — Toggle Fullscreen
- `T` — Toggle 12/24 Hour Mode

### Panel Controls
- `Q` — Toggle Quick Timers panel
- `W` — Toggle Custom Timer panel
- `R` — Toggle To-Do List panel

### Alarm Controls
- `Esc` — Stop active alarm (or click the **Stop** button)

## Running Locally

Because Big Clock is built purely natively, just open `index.html` in any browser!

For best results:
- Use Chrome, Edge, or Firefox.
- Hit `F` to enter fullscreen mode.
- Allow sound so timer alarms can play through the Web Audio API without interruption.

## GitHub Pages Setup

This repo is completely compatible with GitHub Pages.

To deploy it globally:
1. Open your repo on GitHub.
2. Go to **Settings** → **Pages**.
3. Under **Build and deployment**:
   - **Source**: `Deploy from a branch`
   - **Branch**: `main`
   - **Folder**: `/ (root)`
4. Save. GitHub will publish it to `https://<your-username>.github.io/big-clock/`.

## Built With
- Pure HTML5 / CSS3 / Vanilla JavaScript.
- Native HTML5 Drag and Drop API.
- Native `Intl.DateTimeFormat` for dates, zones, and calendars.
- Zero dependencies.
