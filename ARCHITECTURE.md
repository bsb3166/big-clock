# Big Clock — Architecture Diagram

## Overview

```
index.html (6,400 lines, single file)
├── CSS    (lines 23–1909)      — Styling, themes, responsive
├── HTML   (lines 2101–2289)    — DOM structure, panels, modals
└── JS     (lines 2291–6404)    — All application logic
```

---

## 1. System Architecture

```mermaid
graph TB
    subgraph Browser["Browser (Client)"]
        direction TB
        HTML["index.html<br/>Single-Page App"]
        WA["Web Audio API"]
        LS["localStorage<br/>big-clock-settings-v1"]
        YT["YouTube IFrame API<br/>(CDN)"]
        FA["Fullscreen API"]
    end

    subgraph Server["Lock-Screen Daemon (Optional)"]
        PY["server.py<br/>Python HTTP :8888"]
        LOCK["POST /api/lock<br/>→ Win+L"]
        HEALTH["GET /api/health"]
    end

    subgraph OS["Windows OS Integration"]
        BAT_I["install.bat<br/>Auto-startup setup"]
        BAT_U["uninstall.bat<br/>Cleanup"]
        VBS["Startup/*.vbs<br/>Silent launch"]
    end

    subgraph CDN["External Resources"]
        GF["Google Fonts<br/>Audiowide, Orbitron<br/>Share Tech Mono"]
        MOON_IMG["copyexchange.com<br/>Moon Phase PNGs ×8"]
        YT_API["youtube.com<br/>IFrame API"]
    end

    HTML --> WA
    HTML --> LS
    HTML --> YT
    HTML --> FA
    HTML -.->|fetch /api/lock| PY
    PY --> LOCK
    PY --> HEALTH
    BAT_I --> VBS
    VBS -->|auto-start| PY
    HTML --> GF
    HTML --> MOON_IMG
    HTML --> YT_API
```

---

## 2. Application Layers

```mermaid
graph LR
    subgraph Rendering["Rendering Layer"]
        direction TB
        R1["updateClock()<br/>Main rAF Loop ~60fps"]
        R1 --> R2["Clock Dispatcher"]
        R2 --> CS1["renderStandardClock"]
        R2 --> CS2["renderSegmentClock"]
        R2 --> CS3["renderFlipClock"]
        R2 --> CS4["renderAnalogClock"]
        R2 --> CS5["renderRolexClock"]
        R2 --> CS6["renderDotMatrixClock"]
        R2 --> CS7["renderMathClock"]
        R2 --> CS8["renderCuckooClock"]
        R2 --> CS9["renderPixelArtClock"]
        R2 --> CS10["renderPremiumClock"]
        R2 --> CS11["renderTimerClock"]
    end

    subgraph State["State Layer"]
        direction TB
        S1["Clock Style & Theme"]
        S2["Timer / Alarm State"]
        S3["Todo Items"]
        S4["YouTube Playlist"]
        S5["Relax Sound Toggles"]
        S6["Toggle Visibility Flags"]
    end

    subgraph Persist["Persistence"]
        LS2["localStorage<br/>saveSettings()<br/>loadSettings()"]
    end

    State --> Persist
    Rendering -.->|reads| State
```

---

## 3. Module Map (by line range)

```mermaid
graph TD
    subgraph CSS["CSS (lines 23–1909)"]
        direction LR
        C1["Root Variables<br/>23–49"]
        C2["Layout & Panels<br/>93–400"]
        C3["Clock Styles<br/>400–660"]
        C4["YouTube Player<br/>700–950"]
        C5["World Clocks<br/>950–1022"]
        C6["Timer & Alarm UI<br/>1045–1436"]
        C7["Todo List<br/>1364–1625"]
        C8["Mobile Responsive<br/>1815–1909"]
    end

    subgraph HTML["HTML (lines 2101–2289)"]
        direction LR
        H1[".topbar-wrapper<br/>Settings Menu"]
        H2[".center > .time<br/>Clock Display"]
        H3["Floating Panels ×4<br/>Quick / Alarm /<br/>Custom / Todo"]
        H4[".world-clocks<br/>6 Cities"]
        H5[".date-info-container<br/>Date / Lunar / Moon"]
        H6["Alarm Modal"]
    end

    subgraph JS["JavaScript (lines 2291–6404)"]
        direction TB

        subgraph Core["Core Systems"]
            J1["Constants & State<br/>2295–2440"]
            J2["Keyboard Handlers<br/>2442–2453"]
            J3["YouTube Integration<br/>2698–2966"]
            J4["Settings Persistence<br/>2967–3007"]
            J5["Hash Routing<br/>3012–3030"]
            J6["applyClockStyle()<br/>3031–3150"]
            J7["applyTheme()<br/>3151–3192"]
        end

        subgraph Clocks["Clock Renderers"]
            J8["renderSegmentClock<br/>3193–3265"]
            J9["renderStandardClock<br/>3266–3297"]
            J10["renderTimerClock<br/>3298–3383"]
            J11["renderPremiumClock<br/>+ Relax Sounds<br/>3391–3981"]
            J12["renderFlipClock<br/>3982–3995"]
            J13["renderAnalogClock<br/>3996–4086"]
            J14["renderMathClock<br/>4087–4208"]
            J15["renderCuckooClock<br/>+ playCuckooSound<br/>4209–4416"]
            J16["renderPixelArtClock<br/>+ Mario Physics<br/>4417–4873"]
            J17["renderDotMatrixClock<br/>4874–5028"]
            J18["renderRolexClock<br/>5029–5242"]
        end

        subgraph Features["Feature Systems"]
            J19["Todo List<br/>5243–5370"]
            J20["Panel & Scale<br/>5373–5450"]
            J21["Timer System<br/>5453–5512"]
            J22["Audio & Alarms<br/>5513–5664"]
            J23["Alarm Chips<br/>5665–5737"]
            J24["Moon Phase Calc<br/>5788–5868"]
        end

        subgraph Init["Initialization"]
            J25["updateClock() main loop<br/>5796–5900"]
            J26["Event Registration<br/>5965–6288"]
            J27["Boot Sequence<br/>6290–6404"]
        end
    end
```

---

## 4. Clock Styles (16 total)

```mermaid
graph LR
    subgraph Digital["Digital Text"]
        D0["#0 Default"]
        D1["#1 LED Green"]
        D2["#2 LED Blue"]
        D3["#3 LED Orange"]
        D4["#4 Mixed Neon"]
        D7["#7 Retro Tech"]
    end

    subgraph Mechanical["Mechanical / Flip"]
        D5["#5 7-Segment"]
        D6["#6 Flip Clock"]
    end

    subgraph SVG_Clocks["SVG Rendered"]
        D8["#8 Analog Classic"]
        D9["#9 Rolex Day-Date"]
        D10["#10 Dot Matrix"]
        D11["#11 Math Clock"]
        D12["#12 Cuckoo Clock"]
        D14["#14 Premium Minimal"]
    end

    subgraph Special["Special"]
        D13["#13 Pixel Art<br/>(Mario Game)"]
        D99["#99 Timer<br/>(Countdown)"]
    end

    style Digital fill:#1a1a2e,color:#e0e0e0
    style Mechanical fill:#16213e,color:#e0e0e0
    style SVG_Clocks fill:#0f3460,color:#e0e0e0
    style Special fill:#533483,color:#e0e0e0
```

---

## 5. Audio System

```mermaid
graph TB
    subgraph WebAudio["Web Audio API (Synthesized)"]
        direction TB
        RAIN["Rain<br/>Pink noise + LPF<br/>gain 0.18"]
        CRICKET["Crickets<br/>Scheduled oscillators<br/>gain 0.12"]
        THUNDER["Thunder<br/>Brown noise + envelope<br/>gain 0.32"]
        ALARM["Alarm Tones<br/>Default / Beep /<br/>Marimba / Gong"]
        CUCKOO["Cuckoo Call<br/>Two-tone oscillator"]
    end

    subgraph MP3["HTMLAudioElement (MP3)"]
        direction TB
        N1["Amazon Jungle<br/>83 MB"]
        N2["Melk River Valley<br/>86 MB"]
        N3["Saikan Temple Rain<br/>13 MB"]
    end

    subgraph YouTube["YouTube IFrame"]
        YTP["YouTube Player<br/>IFrame API"]
    end

    subgraph Controls["User Controls"]
        BTN_R["Rain Button"]
        BTN_C["Crickets Button"]
        BTN_T["Thunder Button"]
        BTN_N["Nature Button<br/>3-dot cycle"]
        TIMER_DONE["Timer Done"]
        HOUR["On the Hour"]
        YT_UI["YT Controls"]
    end

    BTN_R --> RAIN
    BTN_C --> CRICKET
    BTN_T --> THUNDER
    BTN_N -->|level 1| N1
    BTN_N -->|level 2| N2
    BTN_N -->|level 3| N3
    TIMER_DONE --> ALARM
    HOUR --> CUCKOO
    YT_UI --> YTP
```

---

## 6. Data Flow

```mermaid
flowchart TB
    subgraph Input["User Input"]
        KB["Keyboard<br/>F T Q A W R Esc<br/>Arrow/IJKL (Mario)"]
        MOUSE["Mouse/Touch<br/>Buttons, Sliders<br/>Toggles, Drag"]
        URL["URL Hash<br/>#0–#14, #99, #name"]
    end

    subgraph Process["Processing"]
        DISPATCH["Event Dispatcher"]
        STYLE["applyClockStyle()"]
        THEME["applyTheme()"]
        TIMER["Timer Logic<br/>start/pause/resume"]
        ALARM_CHK["checkClockAlarms()"]
        TODO_MGR["Todo Manager"]
        YT_MGR["YouTube Manager"]
    end

    subgraph Render["Render Loop (rAF)"]
        UC["updateClock()"]
        CLOCK_R["Clock Renderer<br/>(1 of 11)"]
        DATE_R["Date / Lunar /<br/>Moon / TZ"]
        WORLD_R["World Clocks ×6"]
        TIMER_R["Timer UI"]
    end

    subgraph Output["Output"]
        DOM["DOM Update<br/>#time innerHTML"]
        AUDIO["Audio Output<br/>WebAudio + MP3"]
        STORE["localStorage<br/>saveSettings()"]
        LOCK_API["Lock API<br/>POST /api/lock"]
    end

    KB --> DISPATCH
    MOUSE --> DISPATCH
    URL --> STYLE

    DISPATCH --> STYLE
    DISPATCH --> THEME
    DISPATCH --> TIMER
    DISPATCH --> TODO_MGR
    DISPATCH --> YT_MGR

    UC --> CLOCK_R --> DOM
    UC --> DATE_R --> DOM
    UC --> WORLD_R --> DOM
    UC --> TIMER_R --> DOM
    UC --> ALARM_CHK -->|match| AUDIO

    TIMER -->|done + lock| LOCK_API
    STYLE --> STORE
    THEME --> STORE
    TODO_MGR --> STORE
```

---

## 7. Theme System

```mermaid
graph LR
    subgraph Themes["9 Built-in + Custom"]
        T1["Dark (Default)"]
        T2["Midnight Blue"]
        T3["Deep Forest"]
        T4["Frosted Glass"]
        T5["Modern Tiles"]
        T6["Natural Rock"]
        T7["Elegant Marble<br/>(Smart Light Mode)"]
        T8["Aurora Pink"]
        T9["Checkerboard"]
        T10["Custom Image<br/>(Upload → base64)"]
    end

    APPLY["applyTheme()"] --> VARS["CSS Custom Properties<br/>--bg, --fg, --panel<br/>--blue, --red, --gold"]
    VARS --> DOM_STYLE["document.body.style"]

    Themes --> APPLY
```

---

## 8. localStorage Schema

```mermaid
classDiagram
    class Settings {
        +boolean use24Hour
        +string clockStyle
        +number sizeScale
        +number panelOpacity
        +string alarmSound
        +string theme
        +string customBg
        +boolean showYt
        +boolean showDateDisplay
        +boolean showLunarDate
        +boolean showMoonPhase
        +boolean showTz
        +boolean showWorldClock
        +boolean lockScreenOnDone
        +number ytVolume
        +string[] alarmTimes
    }

    class TodoItem {
        +string text
        +boolean completed
    }

    class TodoSize {
        +number width
        +number height
    }

    class YTTrack {
        +string videoId
        +string title
        +string author
    }

    Settings "1" --> "many" TodoItem : todoItems
    Settings "1" --> "1" TodoSize : todoSize
    Settings "1" --> "many" YTTrack : ytPlaylist
```

---

## 9. Lock-Screen Service

```mermaid
sequenceDiagram
    participant User
    participant Browser as index.html
    participant Daemon as server.py :8888
    participant Windows

    Note over User: One-time setup
    User->>Daemon: Run install.bat
    Daemon-->>Windows: Add to Startup folder

    Note over User: Every login
    Windows->>Daemon: Auto-start (VBS → pythonw)

    Note over User: Normal usage
    Browser->>Daemon: GET /api/health
    Daemon-->>Browser: { ok: true }
    Browser-->>Browser: Show green status dot

    Note over User: Timer finishes
    Browser->>Daemon: POST /api/lock
    Daemon->>Windows: LockWorkStation()
    Windows-->>User: Screen locked (Win+L)
```

---

## 10. File Map

```
big-clock/
├── index.html              ← Entire app (HTML + CSS + JS)
├── server.py               ← Lock-screen HTTP daemon
├── install.bat             ← Windows auto-startup installer
├── uninstall.bat           ← Remove from startup
├── start.bat               ← Open browser to localhost
├── robots.txt              ← SEO
├── sitemap.xml             ← SEO
├── README.md               ← Documentation + screenshots
├── ARCHITECTURE.md         ← This file
└── assets/
    ├── app-screenshot.png
    ├── screenshot-*.png    ← 16 clock style previews
    ├── *.mp3               ← Nature sound recordings (4 files)
    ├── *Moon*.png           ← Moon phase images (8 phases)
    ├── marble.png           ← Theme backgrounds
    ├── rock.png
    ├── tiles.png / tiles2.png
    └── ...
```

---

## Quick Reference: Where to Edit

| Want to change...          | Go to (line ~)       |
|---------------------------|----------------------|
| Add new clock style       | New `render*()` + register in `STYLE_BY_NUM`, `applyClockStyle()` switch, `ALL_CLOCK_STYLES` |
| Add new theme             | `applyTheme()` (~3151) + dropdown HTML (~2170) |
| Change timer behavior     | `startTimer/pauseTimer/resumeTimer` (~5480) |
| Modify alarm sounds       | `playAlarmBurst()` (~5524) |
| Add new ambient sound     | `relaxState` + new `start*Sound()` + button in `renderPremiumClock` |
| Change persistence schema | `saveSettings()` (~2976) + `loadSettings()` (~2967) |
| Add world clock city      | HTML (~2236) + `updateClock()` world clock section |
| Mobile layout tweaks      | `@media (max-width: 768px)` (~1815) |
| Hash shortcut for new style | `STYLE_BY_NUM` map (~3012) |
