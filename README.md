# Desktop Clock

A large clock with a stacked weekday/date line, drawn in the bottom-right
corner of the desktop on every monitor. It sits on the wallpaper layer, is
click-through, and takes no space in the bar.

An [Omarchy](https://omarchy.org/) shell plugin (Quickshell/QML, kind: `service`).

## Requirements

- Omarchy (for the `omarchy` CLI and shell)
- The **Nunito** font, which Omarchy does not install by default:

  ```bash
  omarchy pkg add ttf-nunito
  omarchy restart shell
  ```

  Without it Qt falls back to another font, so the clock still works but looks
  different. The shell restart is required because Quickshell builds its font
  database at startup — a font installed while the shell is running is not
  picked up until it restarts.

## Install

```bash
omarchy plugin add https://github.com/vcgnetwork/desktop-clock.git --enable
```

The `--enable` flag activates it immediately. To install without enabling:

```bash
omarchy plugin add https://github.com/vcgnetwork/desktop-clock.git
omarchy plugin enable dev.desktop-clock
```

Plugins run unsandboxed inside the long-lived `omarchy-shell` process, so only
install repositories you trust.

## Update

```bash
omarchy plugin update dev.desktop-clock
```

## Remove

```bash
omarchy plugin remove dev.desktop-clock
```

## Customize

The clock reads its settings from the properties at the top of
`DesktopClock.qml`:

| Property       | Default    | Meaning                              |
| -------------- | ---------- | ------------------------------------ |
| `fontFamily`   | `"Nunito"` | Font used for both lines             |
| `timeSize`     | `72`       | Time font size in px                 |
| `sideSize`     | `22`       | Date line font size in px            |
| `bottomMargin` | `80`       | Distance from the bottom of the screen |
| `rightMargin`  | `80`       | Distance from the right of the screen  |
| `textColor`    | `"#f2f2f2"`| Text color                           |

Edit the installed copy instead of this repository:

```bash
$EDITOR ~/.config/omarchy/plugins/dev.desktop-clock/DesktopClock.qml
```

Saving the file reloads the plugin automatically. Local edits are overwritten by
`omarchy plugin update`, so keep tweaks in a fork or send them upstream.

## Manual install (no git)

Copy this folder to `~/.config/omarchy/plugins/dev.desktop-clock/`, then add it
to the plugin list in `~/.config/omarchy/shell.json`:

```json
"plugins": [
  { "id": "dev.desktop-clock" }
]
```

## Publishing this plugin

```bash
git init
git add .
git commit -m "Desktop Clock 1.0.0"
git branch -M main
git remote add origin git@github.com:<you>/desktop-clock.git
git push -u origin main
```

Before pushing, check that it passes Omarchy's manifest validation:

```bash
omarchy plugin validate .
```

The repository root must contain `manifest.json` and the files it points at —
`omarchy plugin add` clones the repo straight into
`~/.config/omarchy/plugins/<id>/`, so there is no subdirectory to point at.

## License

MIT — see [LICENSE](LICENSE).
