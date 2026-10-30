# herdr-editor

A VS Code style file sidebar and editor for the [Herdr](https://herdr.dev) app.

![herdr-editor](mods/herdr-editor/preview.png)

- **Your own icons.** It uses the file icon theme active in your VS Code or Cursor.
  No icon ships with this mod.
- **Git colors.** New, changed and ignored files, and a mark on the folders that
  hold changes.
- **An editor.** Click a file, edit it and press `cmd-s`.
- **Safe with agents.** A file an agent changes reloads while you have nothing
  unsaved. With unsaved changes, saving stops and asks: Reload or Overwrite.

## Install

```sh
git clone https://github.com/thadeu/herdr-editor
cd herdr-editor
./install.sh
```

The script copies the mod, adds `cmd-s` to your keys, and creates a layout named
`herdr-editor` from your `main` layout, with this mod in place of `files`. Herdr's
own layout and mod do not change.

Press `ctrl-shift-l` to switch layouts. To remove it, delete
`~/.config/herdr-app/mods/herdr-editor` and `layouts/herdr-editor.json`.

## Icons

On start, the mod reads `workbench.iconTheme` from the settings of VS Code, Cursor,
VS Code Insiders or VSCodium, and copies that theme's icons to
`~/.config/herdr-app/data/herdr-editor/`.

Themes with SVG or PNG icons work. VS Code's default theme, Seti, draws its icons
with a font, so the mod shows plain icons with it. Install any SVG theme to see them.

## Limits

- Files on another machine and files over 400 KB open as read only.
- You cannot create, rename or delete files from the tree.

## License

Apache-2.0. See [NOTICE](NOTICE).
