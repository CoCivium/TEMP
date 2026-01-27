# TEMP (24h parking lot)

This repo is intentionally **ephemeral**. Treat it as a transient inbox / scratchpad.

**If this repo is Public (it is right now), do NOT place IP-sensitive material here.**
Allowed: process notes, sanitized checklists, non-sensitive scripts, and pointers.

## How to use
- Drop items under INBOX/<UTC>__<slug>/
- Each item should include:
  - README.md (1 screen)
  - SideNote.ps7.txt (single-line <# ... #> payload)
  - sha256.txt for key files

## Purge policy
A scheduled workflow wipes INBOX/, DRAFTS/, and ARTIFACTS/ back to .keep daily.
Anything worth keeping must be copied out to a real repo/vault by CoPrime.
