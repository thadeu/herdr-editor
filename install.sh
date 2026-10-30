#!/bin/sh
# Installs herdr-editor into the Herdr app. Safe to run again: it updates the mod,
# and leaves your other layouts, mods and keys as they are.
set -eu

here=$(cd "$(dirname "$0")" && pwd)
home=${HERDR_APP_HOME:-$HOME/.config/herdr-app}
name=herdr-editor

command -v herdr-app >/dev/null || { echo "herdr-app not found. Install the Herdr app first." >&2; exit 1; }
command -v python3 >/dev/null || { echo "python3 is needed to merge keys.json." >&2; exit 1; }

mkdir -p "$home/mods/$name"
cd "$here/mods/$name"
cp main.js icons.js mod.json ./*.svg "$home/mods/$name/"
herdr-app check "$home/mods/$name"

python3 - "$home/keys.json" keys.json <<'PY'
import json, os, sys

path, snippet = sys.argv[1:]
keys = json.load(open(path)) if os.path.exists(path) else {}

for section, bindings in json.load(open(snippet)).items():
    keys.setdefault(section, {}).update(bindings)

with open(path, "w") as out:
    json.dump(keys, out, indent=2, ensure_ascii=False)
    out.write("\n")
PY

if [ -f "$home/layouts/$name.json" ]; then
  herdr-app do layout.switch "{\"name\":\"$name\"}" >/dev/null || true
  echo "Updated. Layout: $name"
  exit 0
fi

if ! herdr-app do layout.clone "{\"name\":\"main\",\"as\":\"$name\"}" >/dev/null; then
  echo "Mod installed. Open Herdr and run this script again to add the layout."
  exit 0
fi

sed -i.bak "s/\"mod\": \"files\"/\"mod\": \"$name\"/" "$home/layouts/$name.json"
rm -f "$home/layouts/$name.json.bak"

echo "Installed. Layout: $name. Switch back with ctrl-shift-l."
