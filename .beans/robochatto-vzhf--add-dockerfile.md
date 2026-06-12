---
# robochatto-vzhf
title: Add Dockerfile
status: completed
type: task
priority: normal
created_at: 2026-06-12T15:29:16Z
updated_at: 2026-06-12T15:29:43Z
---

Containerize robochatto so it can run without the host venv.



## Summary of Changes

Added `Dockerfile` and `.dockerignore`.

**Dockerfile** (`python:3.13-slim` base):
- Installs `git` to fetch chattolib (since 0.1.0b3 isn't on PyPI yet), then purges it after install to keep the image small.
- Pulls chattolib from `github.com/TheCodemancerLtd/chattolib` — overridable with `--build-arg CHATTOLIB_REF=v0.1.0b3` (or any branch/tag/sha).
- Installs robochatto via `pip install .` against the existing `pyproject.toml`. pip sees chattolib is already satisfied and won't try to pull it from PyPI.
- `ROBOCHATTO_DB=/data/robochatto.db` so the SQLite file lives on a mountable volume; declares `VOLUME /data`.
- `PYTHONUNBUFFERED=1` mirrors the systemd unit so stdout is flushed.

**.dockerignore** keeps `.venv`, `dist`, `*.egg-info`, `.beans`, `.git`, the local SQLite db, and `robochatto.env` out of the build context.

**Build & run:**
```
docker build -t robochatto:0.1.0b1 .
docker run --rm \
  -e CHATTO_LOGIN -e CHATTO_PASSWORD \
  -e OLLAMA_URL -e OLLAMA_MODEL \
  -v robochatto-data:/data \
  robochatto:0.1.0b1
```

Not verified by an actual build — Docker daemon wasn't running on this host. Worth a smoke build before deploying.
