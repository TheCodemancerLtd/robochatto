---
# robochatto-8cy0
title: update robochatto to chattolib's latest version
status: completed
type: task
priority: normal
created_at: 2026-06-12T14:45:06Z
updated_at: 2026-06-12T14:47:29Z
---

## Summary of Changes

Latest chattolib is **0.1.0b3** (local repo at `/home/f3l1x/source/repos/chattolib`, schema: Chatto v0.1.0-beta.3). Previous pin was `>=0.0.174a0`.

Verified that every chattolib API used by `bot.py` is still present with the same signatures in 0.1.0b3:
- `ChattoClient.login / me / update_presence / post_message / add_reaction / remove_reaction`
- `subscribe_events(url, token)` from `chattolib.subscriptions`
- `PresenceStatus.ONLINE`
- The yielded event shape (`event.event.body`, `event.event.roomId`, `event.event.inThread`, `event.actor.{id,login}`, `event.id`) is unchanged.

No code changes were required — only the version pins:
- `pyproject.toml`: `chattolib>=0.0.174a0` → `chattolib>=0.1.0b3`
- `requirements.txt`: `chattolib>=0.0.1` → `chattolib>=0.1.0b3`

Recreated `.venv` (the existing one referenced a stale interpreter path from another machine) and confirmed `bot.py` imports cleanly against the new chattolib.
