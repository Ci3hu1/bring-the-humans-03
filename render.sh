#!/usr/bin/env bash
# bring-the-humans-03 — render the entry video with ffmpeg.
# Written fresh for this entry from BRIEF.md. All visuals come from the
# press-kit files in assets/ (used as they are). Music is synthesized
# in-session by music.py (cheerful 120 BPM beat) — no downloaded tracks.
# Output: video.mp4 (1080x1920, ~20s, 60fps, AAC audio).
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
ASSETS="$REPO/assets/make-fun-press-kit"
FONT_JB="$REPO/assets/fonts/JetBrainsMono-Bold.ttf"
FONT_BOLD="/usr/share/fonts/truetype/noto/NotoSans-Bold.ttf"
CARD="$ASSETS/referral-card/9x16/makefun-card-9x16-transparent.webm"
BADGE="$ASSETS/brand-badge/9x16/makefun-badge-9x16.png"
GHOST_SPY="$ASSETS/illustrations/ghost-spyglass.png"
GHOST_LAPTOP="$ASSETS/illustrations/ghost-laptop-recording.png"
GHOST_TROPHY="$ASSETS/illustrations/ghost-pile-trophy.png"
BOARD="$ASSETS/screenshots/board-dark.png"
LOCKUP="$ASSETS/lockup-on-dark-2400.png"
CODE="cc7tcnw6"
TMP="/tmp/bth03"
mkdir -p "$TMP"

INK="0x191419"
MAGENTA="0xC41C83"

# --- Scene 1 (3s): hook -----------------------------------------------
ffmpeg -y -v error -f lavfi -i "color=c=$INK:s=1080x1920:r=30:d=3" -i "$GHOST_SPY" \
  -filter_complex \
  "[1:v]scale=520:-1[ghost];[0:v][ghost]overlay=280:1250,drawtext=fontfile=$FONT_BOLD:text='Your AI agent':fontsize=92:fontcolor=white:x=(w-text_w)/2:y=470,drawtext=fontfile=$FONT_BOLD:text='is sitting idle.':fontsize=92:fontcolor=$MAGENTA:x=(w-text_w)/2:y=600,drawtext=fontfile=$FONT_BOLD:text='Put it to work.':fontsize=64:fontcolor=white:x=(w-text_w)/2:y=810,fade=t=in:st=0:d=0.4,fade=t=out:st=2.6:d=0.4[v]" \
  -map "[v]" -c:v libx264 -pix_fmt yuv420p -crf 18 -r 30 "$TMP/s1.mp4"

# --- Scene 2 (6s): what make.fun is ------------------------------------
ffmpeg -y -v error -f lavfi -i "color=c=$INK:s=1080x1920:r=30:d=6" -i "$BOARD" \
  -filter_complex \
  "[1:v]scale=980:-1[board];[0:v][board]overlay=50:980,drawtext=fontfile=$FONT_BOLD:text='AI agents compete':fontsize=84:fontcolor=white:x=(w-text_w)/2:y=430,drawtext=fontfile=$FONT_BOLD:text='in bounties':fontsize=84:fontcolor=white:x=(w-text_w)/2:y=550,drawtext=fontfile=$FONT_BOLD:text='for real money.':fontsize=84:fontcolor=$MAGENTA:x=(w-text_w)/2:y=670,fade=t=in:st=0:d=0.4,fade=t=out:st=5.6:d=0.4[v]" \
  -map "[v]" -c:v libx264 -pix_fmt yuv420p -crf 18 -r 30 "$TMP/s2.mp4"

# --- Scene 3 (6s): you enter with your agent ---------------------------
ffmpeg -y -v error -f lavfi -i "color=c=$INK:s=1080x1920:r=30:d=6" -i "$GHOST_LAPTOP" \
  -filter_complex \
  "[0:v][1:v]overlay=290:1120,drawtext=fontfile=$FONT_BOLD:text='You enter with':fontsize=88:fontcolor=white:x=(w-text_w)/2:y=430,drawtext=fontfile=$FONT_BOLD:text='your agent.':fontsize=88:fontcolor=white:x=(w-text_w)/2:y=550,drawtext=fontfile=$FONT_BOLD:text='It does the work.':fontsize=72:fontcolor=$MAGENTA:x=(w-text_w)/2:y=750,fade=t=in:st=0:d=0.4,fade=t=out:st=5.6:d=0.4[v]" \
  -map "[v]" -c:v libx264 -pix_fmt yuv420p -crf 18 -r 30 "$TMP/s3.mp4"

# --- Scene 4 (5s): the prize -------------------------------------------
ffmpeg -y -v error -f lavfi -i "color=c=$INK:s=1080x1920:r=30:d=5" -i "$GHOST_TROPHY" -i "$LOCKUP" \
  -filter_complex \
  "[1:v]scale=-1:560[trophy];[2:v]scale=860:-1[lock];[0:v][trophy]overlay=120:820[bg];[bg][lock]overlay=110:1450,drawtext=fontfile=$FONT_BOLD:text='\$500 on the table':fontsize=88:fontcolor=white:x=(w-text_w)/2:y=430,drawtext=fontfile=$FONT_BOLD:text='right now.':fontsize=88:fontcolor=$MAGENTA:x=(w-text_w)/2:y=550,fade=t=in:st=0:d=0.4,fade=t=out:st=4.6:d=0.4[v]" \
  -map "[v]" -c:v libx264 -pix_fmt yuv420p -crf 18 -r 30 "$TMP/s4.mp4"

# --- Concat scenes (20s) ------------------------------------------------
ffmpeg -y -v error -i "$TMP/s1.mp4" -i "$TMP/s2.mp4" -i "$TMP/s3.mp4" -i "$TMP/s4.mp4" \
  -filter_complex "[0:v][1:v][2:v][3:v]concat=n=4:v=1:a=0[v]" \
  -map "[v]" -c:v libx264 -pix_fmt yuv420p -crf 18 -r 30 "$TMP/base.mp4"

# --- Music (synthesized in-session by music.py, 20s) ----------------------
python3 "$REPO/music.py" "$TMP/music.wav"

# --- Badge from frame 1 + progress bar + music ---------------------------
ffmpeg -y -v error -i "$TMP/base.mp4" -i "$BADGE" -i "$TMP/music.wav" \
  -filter_complex "[0:v][1:v]overlay=0:0,drawbox=x=0:y=1908:w='1080*t/20':h=12:color=$MAGENTA:t=fill[v]" \
  -map "[v]" -map 2:a -c:v libx264 -pix_fmt yuv420p -crf 18 -c:a aac -b:a 128k -shortest "$TMP/badged.mp4"

# --- Referral end card over the last 2.5s (press-kit recipe) -------------
# Card rests 1.433s in; code typed from x=210, centred y=1271, 62px.
T=17.5
REST=1.433
ffmpeg -y -v error -i "$TMP/badged.mp4" -c:v libvpx-vp9 -i "$CARD" -filter_complex "
[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,setsar=1,fps=60,tpad=stop_mode=clone:stop_duration=0,format=yuva420p,split[clip][soft];
[soft]gblur=sigma=28,eq=saturation=0.35,fade=t=in:st=$T:d=0.8:alpha=1[soft];
[clip][soft]overlay[bg];
[1:v]format=yuva420p,setpts=PTS-STARTPTS+$T/TB[card];
[bg][card]overlay=eof_action=pass,
drawbox=x=208:y=1230:w=9:h=82:color=white:t=fill:enable='gte(t,$T+$REST)',
drawtext=fontfile=$FONT_JB:text=$CODE:fontsize=62:fontcolor=0x191419:x=210:y=1271-(ascent-descent)/2:enable='gte(t,$T+$REST)'[v]" \
  -map "[v]" -map "0:a?" -c:v libx264 -pix_fmt yuv420p -crf 18 -c:a aac -movflags +faststart "$REPO/video.mp4"

ffprobe -v error -show_entries format=duration,size -show_entries stream=codec_type,codec_name,width,height,r_frame_rate -of default=noprint_wrappers=1 "$REPO/video.mp4"
echo "render done: $REPO/video.mp4"
