#!/usr/bin/env bash
set -e

ROOT_DIR="$(pwd)"
ASSETS_DIR="$ROOT_DIR/assets"
IMG_DIR="$ASSETS_DIR/images"
AUD_DIR="$ASSETS_DIR/audio"

mkdir -p "$IMG_DIR" "$AUD_DIR"

# placeholder image (1x1 png)
cat > "$IMG_DIR/placeholder.png" <<'PNGBASE64'
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=
PNGBASE64
base64 --decode "$IMG_DIR/placeholder.png" > "$IMG_DIR/placeholder.tmp.png" || true
mv "$IMG_DIR/placeholder.tmp.png" "$IMG_DIR/placeholder.png" || true

if [ ! -f "$ROOT_DIR/assets/levels.json" ]; then
  echo "ضع ملف assets/levels.json (levels data) في المجلد ثم أعد تشغيل السكريبت."
  exit 1
fi

python3 - <<'PY'
import json, wave, struct, os
with open('assets/levels.json', 'r', encoding='utf-8') as f:
    levels = json.load(f)
audio_dir = 'assets/audio'
nchannels = 1
sampwidth = 2
framerate = 22050
duration_seconds = 0.5
nframes = int(framerate * duration_seconds)
silen_frame = struct.pack('<h', 0)
for lv in levels:
    for key in ('audioLetter', 'audioWord'):
        name = lv.get(key, '')
        if not name:
            continue
        filename = os.path.join(audio_dir, f"{name}.wav")
        if os.path.exists(filename):
            continue
        with wave.open(filename, 'w') as wf:
            wf.setnchannels(nchannels)
            wf.setsampwidth(sampwidth)
            wf.setframerate(framerate)
            wf.writeframes(silen_frame * nframes)
print("تم إنشاء ملفات WAV صامتة في assets/audio/")
PY

zip -r assets_package.zip assets > /dev/null
echo "تم إنشاء assets_package.zip"