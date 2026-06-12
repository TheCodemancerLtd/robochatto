---
# robochatto-wyji
title: Add docker-compose.yaml
status: completed
type: task
priority: normal
created_at: 2026-06-12T15:31:23Z
updated_at: 2026-06-12T15:31:55Z
---

Compose file for running the container with no exposed ports, joined to the external nginx network.



## Summary of Changes

Added `docker-compose.yaml`:
- Builds from local `Dockerfile` with `CHATTOLIB_REF=main` (override at build time if you want a pinned chattolib).
- No `ports:` block — robochatto only opens outbound connections (Chatto websocket, Ollama).
- Loads `robochatto.env` for `CHATTO_LOGIN` / `CHATTO_PASSWORD` / optional `OLLAMA_*` overrides.
- Persists the SQLite db in a named volume `robochatto-data` mounted at `/data`.
- `restart: unless-stopped` — closest equivalent to the systemd unit's `Restart=on-failure`.
- Joins the external `nginx` docker network so a sibling nginx (or any container on that net) can reach robochatto by hostname `robochatto` if needed.

**Validation:** `docker compose config` parses the file cleanly. Image not actually built — Docker daemon wasn't running on this host.

**Operator note:** the nginx network must already exist (`docker network create nginx` if not). `external: true` means compose won't create it.
