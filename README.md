# TEMP (public-safe transient inbox)

This repo is **ephemeral-by-policy**. Treat it as a transient scratchpad/inbox.

**PUBLIC RULE:** do NOT place IP-sensitive / patent-adjacent / crown-jewel details here.  
Allowed: process notes, sanitized checklists, non-sensitive scripts, and pointers.

## Usage
- Drop items under: INBOX/<UTC>__<slug>/
- Each item should include:
  - README.md (1 screen)
  - SideNote.ps7.txt (single-line <# ... #> payload)
  - sha256.txt for key files

## Retention / Purge policy
- There is **no guarantee** of retention. Anything in TEMP may be purged at any time.
- Purge is **manual-only** (explicit operator action). “24 hours” is a *target*, not a promise.

### Manual purge “button” (PS7)
Copy/paste (dry run first):
- Dry run: & .\TOOLS\Purge_INBOX.ps1 -OlderThanHours 24 -KeepNewest 3 -DryRun
- Execute : & .\TOOLS\Purge_INBOX.ps1 -OlderThanHours 24 -KeepNewest 3

Anything worth keeping must be copied out by CoPrime into a real repo/vault path.
