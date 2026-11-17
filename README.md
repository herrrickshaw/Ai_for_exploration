# Aravalli Belt — AI mineral prospectivity (data scaffolding)

Seed data and a service watcher for a GFM4MPM-style mineral-prospectivity model over
the Aravalli belt (Rajasthan / northern Gujarat / southern Haryana), bounding box
**72–78°E, 23–29°N**. For geoscience and ML researchers scoping an Indian
prospectivity project. It produces two tracked CSV inventories (USGS MRDS deposit
labels, NASA EMIT hyperspectral granules) and a research note on the literature,
startups and Indian policy context. No model code exists yet.

> Status: research-only data scaffolding, started 2026-08-01. No model, no pipeline — two
> inventory CSVs, one cron watcher script and one literature/policy note. Research use only.

<!-- how-to-use-with-ai -->
> **New here?** See [How to use this repo with AI (Claude, Gemini, ChatGPT)](HOW_TO_USE_WITH_AI.md) — clone it, paste it into an AI tool, and ask in plain English.

## What it does
- Tracks 60 USGS MRDS mineral-site records inside the bbox (24 producers, 19 prospects,
  8 occurrences, 6 plants, 3 past producers): Cu, Pb-Zn, W, phosphate, fluorite. Seed *label* set.
- Tracks an inventory of 1,015 NASA EMIT L2B mineralogy granules intersecting the bbox
  (2022-08 to 2026-07), 321 with cloud cover ≤10%, sorted cloud-ascending, with direct `.nc` URLs.
- `scripts/bhukosh_watcher.sh` polls the GSI Bhukosh portal (down since at least 2026-08-01)
  and, when it answers, saves its ArcGIS REST service catalog and fires a macOS notification.
- `docs/AI_RESOURCE_PROGNOSTICATION_OPPORTUNITY.md` summarises the literature (GFM4MPM, Prithvi,
  Earth AI), the funded startups (KoBold, Earth AI, VerAI, GeologicAI) and the Indian policy record
  (NCMM, Exploration Licence auctions, IndiaAI × GSI hackathon) from PIB releases.

## Quick start
```bash
git clone https://github.com/herrrickshaw/Ai_for_exploration.git
cd Ai_for_exploration
head data/mrds_aravalli_bbox.csv                 # deposit labels
awk -F, '$4<=10' data/emit_l2b_min_aravalli_inventory.csv | head   # cloud-free EMIT scenes
```
Downloading EMIT `.nc` files needs a free NASA Earthdata token (never commit it).

To run the watcher every 3 hours from cron:
```
17 */3 * * * /bin/bash /path/to/Ai_for_exploration/scripts/bhukosh_watcher.sh
```

## How it works
| Stage | Module | Output |
|---|---|---|
| Deposit labels (bbox filter of USGS MRDS) | done offline, result tracked | `data/mrds_aravalli_bbox.csv` |
| EMIT granule search (bbox, sorted by cloud) | done offline, result tracked | `data/emit_l2b_min_aravalli_inventory.csv` |
| Wait for Bhukosh to come back | `scripts/bhukosh_watcher.sh` | `$HOME/aravalli-prospectivity/data/bhukosh_services.json`, `logs/bhukosh_up.flag` |
| Scoping note | `docs/AI_RESOURCE_PROGNOSTICATION_OPPORTUNITY.md` | — |

Watcher behaviour: exits immediately while `logs/bhukosh_up.flag` exists (delete the flag to
re-arm); probes `https://bhukosh.gsi.gov.in/Bhukosh/Public` with a 45 s timeout; on HTTP 200/302
it fetches `arcgis/rest/services?f=json` (best effort), writes the flag and notifies via `osascript`.
Note that all state lives under `$HOME/aravalli-prospectivity`, not the repo checkout, so the
script is cron-safe on macOS (no TCC-protected paths).

## Repository layout
| Path | Purpose |
|---|---|
| `data/mrds_aravalli_bbox.csv` | 60 USGS MRDS records (tracked) |
| `data/emit_l2b_min_aravalli_inventory.csv` | 1,015 EMIT L2B MIN granules (tracked) |
| `scripts/bhukosh_watcher.sh` | cron watcher for bhukosh.gsi.gov.in |
| `docs/AI_RESOURCE_PROGNOSTICATION_OPPORTUNITY.md` | literature / startup / PIB policy note (compiled 2026-08-02) |
| `HOW_TO_USE_WITH_AI.md` | non-programmer guide |
| `graphify-out/` | generated knowledge-graph output |
| `.github/workflows/quality-gates.yml` | gitleaks secret scan on push/PR |

## Data sources
| Source | What is taken | Access route | Licence / caveat |
|---|---|---|---|
| USGS MRDS, https://mrdata.usgs.gov/mrds/ | 60 sites in bbox | public download, bbox filter | File vintage 2022-08; USGS stopped updating foreign records |
| NASA EMIT L2B MIN v001, https://lpdaac.usgs.gov/products/emitl2bminv001/ | granule inventory + URLs | CMR search; downloads need Earthdata token | NASA open data |
| GSI Bhukosh, https://bhukosh.gsi.gov.in | 1:50k geology, NGCM geochem, NGPM magnetics, occurrences (planned) | portal, when up | down since at least 2026-08-01 |
| NGDR, https://geodataindia.gov.in | MERT-standardised exploration reports (planned) | login-gated (free, email+OTP) | not yet pulled |
| PIB release index | policy record cited in `docs/` | owner's `india-trade-sector-policy-recommendations` repo | secondary compilation |

## Configuration
No environment variables. The watcher hard-codes `BASE="$HOME/aravalli-prospectivity"` for its
log, flag and catalog output. The only secret ever needed is a NASA Earthdata token for EMIT
downloads; it is not read by anything in this repo and must never be committed.

## Testing
```bash
bash -n scripts/bhukosh_watcher.sh
```
No automated tests; CI runs only a gitleaks secret scan.

## Limitations and known issues
- No prospectivity model or training pipeline exists yet; this is step one (labels + scenes + watcher).
- MRDS labels are sparse (60 sites, 28 without a primary commodity) and dated 2022-08.
- Bhukosh has been unreachable since 2026-08-01. If the watcher stays dark, do not assume "down":
  the documented `arcgis/rest/services` path may simply have moved — mine the site's own JS bundles
  for the current backend host before concluding it is blocked.
- NGDR is login-gated; nothing from it is in the repo.
- The watcher's macOS notification (`osascript`) silently fails on Linux.

## Related repositories
- `india-trade-sector-policy-recommendations` (same account) — PIB release index that the policy
  section of `docs/` is compiled from.

## Licence
No licence file yet — all rights reserved.
