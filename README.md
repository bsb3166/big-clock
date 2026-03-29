# big-clock

A fullscreen web clock with large display styles, floating timers, alarm effects, and a clean always-on-screen layout.

## Features

- Large centered fullscreen clock
- 12 / 24 hour mode
- Adjustable clock size
- Adjustable timer panel opacity
- Floating quick timers and custom timer panel
- Collapsible timer panels
- Custom timer with minutes + seconds
- Alarm sound, shake effect, and stop modal when timer finishes
- Multiple clock styles:
  - Default
  - LED neon green
  - LED neon blue
  - LED neon orange
  - 7 segment
  - Flip clock
  - Retro tech
- Remembers settings locally:
  - clock size
  - panel opacity
  - panel collapsed state
  - 12/24h mode
  - selected clock style

## Screenshot

Add a screenshot to this repo and update this section if you want a visual preview in GitHub.

## Run locally

Just open `index.html` in a browser.

For best results:
- use Chrome, Edge, or another modern browser
- enter fullscreen mode
- allow sound so timer alarms can play

## Controls

### Main controls
- `F` — toggle fullscreen
- `T` — toggle 12/24 hour mode

### Timer panel controls
- `Q` — toggle quick timers panel
- `W` — toggle custom timer panel

### Alarm controls
- `Esc` — stop active alarm
- Or click the **Stop** button in the alarm modal

## Timer features

### Quick timers
Includes preset buttons for:
- 1 min
- 5 min
- 15 min
- 30 min
- 1 hr
- 2 hr
- 3 hr

### Custom timer
Set:
- minutes
- seconds

Then start, pause, resume, or clear the timer.

## GitHub Pages

This repo is compatible with GitHub Pages because the app is a static `index.html` file.

To enable GitHub Pages:
1. Open the repo on GitHub
2. Go to **Settings** → **Pages**
3. Under **Build and deployment**:
   - **Source**: `Deploy from a branch`
   - **Branch**: `main`
   - **Folder**: `/ (root)`
4. Save

After that, GitHub will publish the app at a URL like:

`https://bsb3166.github.io/big-clock/`

## Files

- `index.html` — the full app

## Notes

This project is intentionally lightweight and dependency-free at runtime except for web fonts loaded in the page.
