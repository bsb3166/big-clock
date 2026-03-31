# big-clock

A fullscreen web clock with large display styles, floating timers, world clocks, dynamic themes, alarm effects, and a highly interactive layout.

## Features

- **Large Centered Fullscreen Clock**
- **YouTube Music-Style Player**: 
    - Floating glassmorphic control bar.
    - **Radio Mix Integration**: Automatically generates an infinite queue of related music when playing a single video.
    - **History Navigation**: Intelligent "Previous" button that tracks your played videos.
    - Persistence for volume and tracks.
- **Dynamic Date & Timezones**: Automatically positioned date, timezone, and Chinese Lunar Date display.
    - **Decoupled Visibility**: Toggle each element (Date, Lunar, TZ) independently.
- **Expanded World Clocks**: Live pinned clocks for New York, London, Beijing, **Tokyo (JST)**, **Paris (CET)**, and **Denver (MST/MDT)**.
    - Includes timezone abbreviations for each city.
- **Multiple Clock Styles**: Default, LED Neon Green/Blue/Orange, Mixed Neon, 7-Segment, Flip Clock, and Retro Tech.
- **Premium Built-in Themes**: 
    - **Dark (Default)**: Classic minimalist deep black.
    - **Midnight Blue / Deep Forest**: Elegant dark gradients.
    - **Frosted Glass**: Sophisticated blurred acrylic look.
    - **Modern Tiles**: Architectural charcoal tile pattern.
    - **Natural Rock**: Tactile dark slate stone texture.
    - **Elegant Marble**: High-end white marble (features **Smart Light-Mode** which automatically inverts text for readability).
    - **Custom Image Background**: Upload your own image via the sub-menu.
- **Adjustable Display**: Scale the main clock size, or adjust UI panel opacity.
- **Interactive To-Do List**: Built-in floating to-do list featuring native **HTML5 Drag & Drop sorting** and one-click removal.
- **Floating Timers**: Persistent quick timer presets, plus a custom hours/minutes timer.
- **Alarm Customizations**: Choose between Default, Digital Beep, or Marimba. Features an auto-firing screen shake effect and an alarm stop modal.
- **Auto-Hiding Menus**: The settings menu cleanly tucks itself into a capsule icon when your mouse leaves the area.
- **iOS-Style Toggles**: Premium toggle switches in the settings bar for all major sections (YouTube, Date, Lunar, TZ, World Clock).
- **Local Persistence**: Remembers literally everything contextually (clock style, theme, custom background, sounds, active to-dos, panel opacities, and collapsed states).

## Controls / Hotkeys

### Main Controls
- `F` — Toggle Fullscreen (Hint: **Fullscreen (F)**)
- `T` — Toggle 12/24 Hour Mode (Hint: **12/24 hr (T)**)

### Panel Controls
- `Q` — Toggle Quick Timers panel (Hint: **Quick timers (Q)**)
- `W` — Toggle Custom Timer panel (Hint: **Custom timer (W)**)
- `R` — Toggle To-Do List panel (Hint: **To-do list (R)**)

### Alarm Controls
- `Esc` — Stop active alarm (or click the **Stop** button)

## Running Locally

Because Big Clock is built purely natively, just open `index.html` in any browser!

**Note for YouTube Player**: Due to security restrictions on the YouTube IFrame API, the player functionality requires the page to be served via a local HTTP server (e.g., `python -m http.server 8888`) and accessed via `http://localhost:8888/`.

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
- YouTube IFrame API.
- Native HTML5 Drag and Drop API.
- Native `Intl.DateTimeFormat` for dates, zones, and calendars.
- Zero dependencies.
