#!/usr/bin/env python3
"""Synthesize the bring-the-humans-03 backing track, in-session.

Cheerful 120 BPM C-major loop: four-on-the-floor kick, snare on beats 2
and 4, offbeat hats, walking bass, plucky C-major arpeggio, soft pad.
No samples, no downloads — every sample is computed here with
math.sin / random noise. Stdlib only.

Usage: python3 music.py <output.wav>  (20 s, stereo, 48 kHz, 16-bit)
"""
import math
import random
import struct
import sys
import wave

SR = 48000
BAR = 2.0        # seconds: 4 beats at 120 BPM
BARS = 10        # 10 bars = 20 s
BEAT = 0.5
EIGHTH = 0.25

random.seed(20261122)

# One chord per beat: C - G - Am - F (roots), one note per eighth.
BASS_NOTES = [65.41, 65.41, 98.00, 98.00, 110.00, 110.00, 87.31, 98.00]
# Plucky arpeggio, one note per eighth: E G C' G A G F E.
PLUCK_NOTES = [659.25, 783.99, 1046.50, 783.99, 880.00, 783.99, 698.46, 659.25]
PAD = [130.81, 164.81, 196.00]  # C3 E3 G3


def kick(u):
    """u: seconds since the beat started. Pitch 130 -> 45 Hz, fast decay."""
    if u < 0 or u >= 0.35:
        return 0.0
    phase = 2 * math.pi * (45 * u + 85 * (1 - math.exp(-12 * u)) / 12)
    return math.sin(phase) * math.exp(-14 * u)


def snare(u):
    """u: seconds since the beat started. Noise burst + 190 Hz body."""
    if u < 0 or u >= 0.18:
        return 0.0
    noise = random.uniform(-1, 1)
    body = math.sin(2 * math.pi * 190 * u) * math.exp(-22 * u)
    return (noise * 0.55 + body * 0.45) * math.exp(-20 * u)


def hat(u):
    """u: seconds since the eighth started. Short bright tick."""
    if u < 0 or u >= 0.07:
        return 0.0
    return random.uniform(-1, 1) * math.exp(-90 * u)


def fade_in(e, ms=0.005):
    return min(1.0, e / ms)


def bar_samples():
    n = int(SR * BAR)
    out = [0.0] * n
    prev_hat = 0.0
    for i in range(n):
        t = i / SR
        s = 0.0
        # Kick on every beat.
        s += 0.9 * kick(t % BEAT)
        # Snare on beats 2 and 4.
        beat_idx = int(t / BEAT)
        if beat_idx in (1, 3):
            s += 0.5 * snare(t % BEAT)
        # Hats on every eighth (crude highpass by differencing).
        raw_hat = hat(t % EIGHTH)
        hp = raw_hat - prev_hat
        prev_hat = raw_hat
        s += 0.35 * hp
        # Bass + pluck, one note per eighth, global phase (no clicks).
        e = t % EIGHTH
        eighth_idx = int(t / EIGHTH)
        bf = BASS_NOTES[eighth_idx]
        s += 0.5 * math.sin(2 * math.pi * bf * t) * math.exp(-8 * e) * fade_in(e)
        pf = PLUCK_NOTES[eighth_idx]
        env = math.exp(-10 * e) * fade_in(e)
        s += 0.22 * (
            math.sin(2 * math.pi * pf * t)
            + 0.3 * math.sin(2 * math.pi * 2 * pf * t)
        ) * env
        # Soft pad underneath.
        for pfreq in PAD:
            s += 0.05 * math.sin(2 * math.pi * pfreq * t)
        out[i] = s
    return out


def main():
    out_path = sys.argv[1] if len(sys.argv) > 1 else "music.wav"
    bar = bar_samples()
    full = bar * BARS  # loop the 2 s bar 10 times -> 20 s
    total = len(full)
    # Global fades: 0.3 s in, 1 s out.
    fade_in_n = int(0.3 * SR)
    fade_out_n = int(1.0 * SR)
    for i in range(total):
        g = 1.0
        if i < fade_in_n:
            g = i / fade_in_n
        elif i >= total - fade_out_n:
            g = (total - i) / fade_out_n
        full[i] *= g
    # Soft-clip + normalize to 0.85 peak.
    peak = max(abs(v) for v in full) or 1.0
    scale = 0.85 / peak
    frames = b"".join(
        struct.pack(
            "<hh",
            int(max(-1.0, min(1.0, math.tanh(v * scale))) * 32767),
            int(max(-1.0, min(1.0, math.tanh(v * scale))) * 32767),
        )
        for v in full
    )
    with wave.open(out_path, "wb") as w:
        w.setnchannels(2)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(frames)
    print(f"wrote {out_path}: {len(full) / SR:.1f}s stereo {SR} Hz")


if __name__ == "__main__":
    main()
