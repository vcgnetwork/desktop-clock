# Desktop Clock

A large clock with a stacked weekday/date line, drawn in the bottom-right
corner of the desktop on every monitor. It sits on the wallpaper layer, is
click-through, and takes no space in the bar.

An [Omarchy](https://omarchy.org/) shell plugin (Quickshell/QML, kind: `service`).

## Install

```bash
omarchy plugin add https://github.com/vcgnetwork/desktop-clock.git
~/.config/omarchy/plugins/dev.desktop-clock/install.sh
```

`install.sh` is safe to run again. It:

1. Installs the **Nunito** font (`ttf-nunito`), which Omarchy doesn't ship.
2. Restarts the shell, but only if the font was just installed. Quickshell
   loads fonts when it starts, so a new font isn't used until it restarts.
3. Turns the clock on.

Without Nunito the clock still works, but Qt falls back to another font and it
looks different.

Plugins run unsandboxed inside the long-lived `omarchy-shell` process, so only
install repositories you trust.

### Doing it by hand

```bash
omarchy pkg add ttf-nunito
omarchy restart shell
omarchy plugin add https://github.com/vcgnetwork/desktop-clock.git --enable
```

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
| `timeSize`     | `48`       | Time font size in px                 |
| `sideSize`     | `16`       | Date line font size in px            |
| `bottomMargin` | `80`       | Distance from the bottom of the screen |
| `rightMargin`  | `80`       | Distance from the right of the screen  |
| `textColor`    | `"#e0e0e0"`| Text color                           |

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

## Publishing changes

This repo is the plugin folder itself. After editing on a machine where the
folder is a git checkout:

```bash
cd ~/.config/omarchy/plugins/dev.desktop-clock
omarchy plugin validate .
git commit -am "Describe the change" && git push
```

Other machines pick it up with `omarchy plugin update dev.desktop-clock`.

## License

MIT — see [LICENSE](LICENSE).
