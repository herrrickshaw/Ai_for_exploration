# AI for Resource Prognostication — Literature, Startups & the India Opening
*Compiled 2026-08-02. Sources: arXiv/journal literature, funding press, PIB release
index (123,052 releases, 2017–2026, `india-trade-sector-policy-recommendations`).*

## 1. The literature: what's proven

**Foundation-model substrate.** Google's *Earth AI* (arXiv 2510.18318) shows
cross-modal geospatial foundation models (remote sensing + population + environment,
Gemini-orchestrated) beating single-model baselines by wide margins (0.82 vs 0.50 on
geospatial QA). NASA/IBM's *Prithvi* (2310.18660, → Prithvi-EO-2.0), *Panopticon*
(2503.10845, any-sensor EO) and *FM composition* (2506.20174) supply the open
pretrained backbones.

**Mineral-specific methods.** *GFM4MPM* (2406.12756) is the key bridge:
self-supervised masked-image pretraining on unlabeled multi-modal geoscience stacks
(geology, geophysics, geochemistry), fine-tuned on sparse deposit labels for
prospectivity mapping. *Masked Mineral Modeling* (2511.09722, Nov 2025) infills
continent-scale US mineral maps the same way. Surface alteration halos are now
resolvable from orbit: EMIT+PRISMA hyperspectral mapping of epithermal Cu-Au-Ag and
porphyry systems (S2590056026000083; 10.1080/10106049.2025.2591763).

**Upstream O&G analog** (from the two NotebookLM briefs in
`~/.ruflo/data-library/docs/`): modular ANNs translate seismic attributes to
lithology (0.88 correlation, MANN), smart proxies replace reservoir simulation for
real-time optimization, ONGC's Pragya AIX (3,200 wellheads, $47M downtime saved
2025) and OIL's Sarathi prove production-grade deployment in India.

**The gap the literature exposes:** every published FM is trained on *surface*
observables; deposits are a *subsurface* inference problem. No one has published a
model jointly pretrained on surface EO + geophysics + drill data — that is exactly
the proprietary moat the funded startups are building, and it is open territory
academically.

## 2. The startups: who is monetizing it

| Company | Model | Funding / status |
|---|---|---|
| **KoBold Metals** (US) | AI asset generator; TerraShed data engine incl. NLP over field reports | $537M Series C, ~$4.4B val; 70+ projects; Mingomba Cu (Zambia) flagship, friction reported 2026 |
| **Earth AI** (Australia) | Vertically integrated: AI targeting + own rigs (~$100/m) | $20M Series B (Jan 2026); 6 new W-Co-Au prospects AI-found |
| **VerAI** (US/IL) | Asset generator for *concealed* deposits | $12M Series A; 80+ Americas projects |
| **GeologicAI** (CA) | Picks-and-shovels: AI core-scanning robots | $20M Series A |

Strategic split: asset generators capture discovery upside; Earth AI integrates to
drilling; GeologicAI sells tooling. General geospatial FMs will likely commoditize
targeting; the moat migrates to proprietary drill data + land positions.

## 3. India: the policy machine is already funding this (PIB record)

- **National Critical Mineral Mission** — Cabinet approved ₹34,300 crore over 7
  years (PIB 2097309, Jan 2025), explicit exploration + value-chain mandate.
- **IndiaAI × GSI Hackathon for AI-driven mineral targeting** — MeitY + Ministry of
  Mines, launched with India's **first Exploration Licence auction** in Goa
  (PIB 2112453 + 2111246, Mar 2025). The government is directly crowdsourcing
  prospectivity models over GSI data.
- **56 critical-mineral blocks + 11 Exploration Licence blocks auctioned**
  (PIB 2277041, Jun 2026) — EL blocks are precisely the vehicle a
  KoBold/Earth-AI-style junior needs in India.
- **Mines Ministry startup pipeline**: first Mining Start-up Summit with IIT Bombay
  (PIB 1927434, May 2023) → open call for startup/MSME R&D proposals under
  S&T-PRISM (PIB 1977027, Nov 2023) → **five startups handed financial grants**
  (PIB 2010517, Mar 2024) → follow-on webinar (PIB 2017603, Apr 2024).
- **NMET** (National Mineral Exploration Trust): 162 exploration projects complete,
  108 ongoing (PIB 1985835) — a standing funder of exploration work; Mines
  Secretary publicly urging "new age technology in mineral exploration"
  (PIB 1989639).
- **Upstream**: Petroleum Minister positioning AI as core to Viksit Bharat 2047
  (PIB 2067399); draft PNG Rules modernizing the upstream framework (PIB 2143395).

## 4. The data is finally open (this repo's scoping)

NGDR (21,071 MERT-standardized exploration reports, login-gated), Bhukosh (1:50k
geology, NGCM geochem, NGPM magnetics — watcher installed), NDR/DGH (free metadata
tier + bid-round packages), EMIT (1,015 granules over the Aravalli belt alone, 321
cloud-free), USGS MRDS labels. See `../README.md` and the Global Data Library
catalog entries `ndr_dgh_upstream_ep`, `dgh_public_ep_stats`, `ngdr_gsi_geoscience`.

## 5. Synthesis: the opening

The literature says the methods transfer (GFM4MPM-style SSL needs no big label
set); the startups prove the business model at four different points on the value
chain; PIB shows India funding both sides (NCMM money, EL auctions as the asset
vehicle, S&T-PRISM/NMET as grant channels, IndiaAI-GSI hackathon as the explicit
demand signal for AI targeting). Nobody has yet published — or productized — a
GFM4MPM-class model on NGDR/Bhukosh data over an Indian belt. The Aravalli
scaffolding in this repo (labels + EMIT scenes + watcher) is step one of exactly
that play, with three plausible monetization paths: EL-block bidding partner,
NMET/NCMM-funded technical services, or an S&T-PRISM grant-backed startup.
