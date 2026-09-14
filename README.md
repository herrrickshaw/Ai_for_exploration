# Aravalli Belt — AI Mineral Prospectivity (data scaffolding)

Started 2026-08-01. Goal: GFM4MPM-style prospectivity model over the Aravalli
belt (Rajasthan / N. Gujarat / S. Haryana), bbox **72–78°E, 23–29°N**.

## data/
- `mrds_aravalli_bbox.csv` — 60 USGS MRDS records in the bbox (all India):
  24 producers, 19 prospects, 8 occurrences; Cu, Pb-Zn, W, phosphate.
  Seed *label* set until NGDR/Bhukosh occurrence layers are available.
  Note: MRDS file vintage 2022-08 (USGS stopped updating foreign records).
- `emit_l2b_min_aravalli_inventory.csv` — 1,015 NASA EMIT L2B mineralogy
  granules intersecting the bbox; 321 with cloud ≤10%; sorted cloud-asc with
  direct `.nc` download URLs. Downloads need a (free) NASA Earthdata token.

## scripts/
- `bhukosh_watcher.sh` — cron every 3h (`17 */3 * * *`): probes
  bhukosh.gsi.gov.in (down since at least 2026-08-01); when it responds,
  saves the ArcGIS REST service catalog, fires a macOS notification, and
  writes `logs/bhukosh_up.flag` (delete the flag to re-arm).

## Blocked / manual next steps
- **NGDR** (geodataindia.gov.in): fully login-gated — register (free,
  email+OTP), then pull MERT-standardized exploration reports for the belt.
- **Bhukosh** (once up): Map Viewer → AOI over bbox → download 1:50k geology,
  NGCM stream-sediment geochem, NGPM magnetics, mineral occurrence shapefiles.
  If the watcher stays dark much longer, don't just assume "down" — check
  whether the documented `arcgis/rest/services` path has simply moved by
  mining the site's own JS bundles for the current backend host before
  concluding it's fully blocked.
