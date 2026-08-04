#!/usr/bin/env bash
#
# Regenerates every asset in static/media/ from the originals in media-src/.
# Safe to re-run: static/media is treated as build output, media-src is the source of truth.
#
# Requires: ffmpeg, cwebp  (brew install ffmpeg webp)
#
set -euo pipefail

cd "$(dirname "$0")/.."

SRC_IMAGES="media-src/images"
SRC_VIDEOS="media-src/videos"
OUT_IMAGES="static/media/images"
OUT_VIDEOS="static/media/videos"

# --- Encoding targets -------------------------------------------------------
HERO_WIDTH_LARGE=2000
HERO_WIDTH_SMALL=1400
ABOUT_WIDTH=800
IMAGE_QUALITY=78
POSTER_QUALITY=70
POSTER_TIMESTAMP=1          # seconds into the clip to grab the poster frame

# 540x960 output. The height has to keep the 9:16 width even for yuv420p: 720 would give
# 405, which ffmpeg rounds to 406 and quietly stretches the frame by 0.2%.
REEL_HEIGHT=960
REEL_CRF=26
REEL_PRESET=slow
REEL_AUDIO_BITRATE=96k
# ---------------------------------------------------------------------------

mkdir -p "$OUT_IMAGES" "$OUT_VIDEOS"

echo "==> Images"
cwebp -quiet -q "$IMAGE_QUALITY" -resize "$HERO_WIDTH_LARGE" 0 \
  "$SRC_IMAGES/cover.webp" -o "$OUT_IMAGES/cover-2000.webp"
cwebp -quiet -q "$IMAGE_QUALITY" -resize "$HERO_WIDTH_SMALL" 0 \
  "$SRC_IMAGES/cover.webp" -o "$OUT_IMAGES/cover-1400.webp"
cwebp -quiet -q "$IMAGE_QUALITY" -resize "$ABOUT_WIDTH" 0 \
  "$SRC_IMAGES/about.webp" -o "$OUT_IMAGES/about.webp"

echo "==> Reels"
# name|trim (empty = full clip)
REELS=(
  "video-1-allure|-t 30"
  "video-2-fiji|"
  "video-3-hotel-vista-alegre|"
  "video-3-prcocktail|"
)

for entry in "${REELS[@]}"; do
  IFS='|' read -r name trim <<< "$entry"
  src="$SRC_VIDEOS/$name.mp4"
  echo "    $name"

  # Scale only, no crop: the sources are already 9:16 with square pixels, so any crop here
  # would throw away real framing. Earlier masters were anamorphic (1920x1080 coded, 9:16
  # display) and a coded-pixel crop cut them down to a third of the frame.
  filter="scale=-2:$REEL_HEIGHT"

  # shellcheck disable=SC2086 # $trim is intentionally word-split into ffmpeg flags
  ffmpeg -loglevel error -y -i "$src" $trim \
    -vf "$filter" \
    -c:v libx264 -profile:v high -crf "$REEL_CRF" -preset "$REEL_PRESET" \
    -pix_fmt yuv420p -movflags +faststart \
    -c:a aac -b:a "$REEL_AUDIO_BITRATE" \
    "$OUT_VIDEOS/$name.mp4"

  ffmpeg -loglevel error -y -ss "$POSTER_TIMESTAMP" -i "$src" -frames:v 1 \
    -vf "$filter" \
    -c:v libwebp -quality "$POSTER_QUALITY" \
    "$OUT_VIDEOS/$name.webp"
done

echo "==> Done"
du -sh "$OUT_IMAGES" "$OUT_VIDEOS"
