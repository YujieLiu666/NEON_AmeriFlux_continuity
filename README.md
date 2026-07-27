
📄 Code and data for the paper:
### A tale of two towers: comparing NEON and AmeriFlux data streams at Bartlett Experimental Forest

Yujie Liu; Paul Stoy; Housen Chu; Dave Y. Hollinger; Scott V. Ollinger; Andrew P. Ouimette; Dave Durden; Cove Sturtevant; Ben Lucas; Andrew D. Richardson

🎉 [Agricultural and Forest Meteorology](https://doi.org/10.1016/j.agrformet.2025.110939)

💼 Contact information: yujie.liu@nau.edu

---

## Repository Structure

```text
.
├── raw_data_BART/
│   ├── AmeriFlux and NEON source datasets
│   ├── Processed daily flux products
│   └── Disturbance transition date files
│
├── scripts/
│   ├── 01_download_data_PhenoCam.Rmd
│   ├── 02_download_AmeriFlux_BASE.Rmd
│   ├── 03_REddyProc.html
│   ├── 04_download_NEON_Bundled_EC.html
│   └── 06_wavelet_analysis.R
│
├── utils/
│   └── Utility functions and helper scripts
│
└── README.md


## Tutorials 
- Flux data postprocessing using REddyProc
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/YujieLiu666/Bridginggap-flux/main?urlpath=rstudio&reset=1&fake=129)

- Flux data gapfilling using XGBoost
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/YujieLiu666/NEON_gapfill_test/blob/main/workflow_XGB_google_colab.ipynb)


## Folders

| Folder | Description |
|----------|-------------|
| `raw_data_BART/` | Raw and processed datasets used in this study, including AmeriFlux, NEON, and disturbance transition date products. |
| `scripts/` | Data download, preprocessing, quality control, and wavelet analysis workflows. |
| `utils/` | Supporting functions, helper scripts, and reusable utilities used throughout the project. |

## Scripts

| Script | Description |
|----------|-------------|
| `01_download_data_PhenoCam.Rmd` | Downloads PhenoCam vegetation indices and phenological transition dates. |
| `02_download_AmeriFlux_BASE.Rmd` | Downloads and formats AmeriFlux BASE data. |
| `03_REddyProc.html` | Flux data post processing: Flux quality control, u* filtering, and gap-filling with REddyProc. |
| `04_download_NEON_Bundled_EC.html` | Downloads and organizes NEON bundled eddy covariance products. |
| `06_wavelet_analysis.R` | Wavelet analysis of ecosystem carbon fluxes using WaveletComp. |

## Raw Data Files

| File | Description |
|----------|-------------|
| `AMF_US-Bar_BASE-BADM_6-5.zip` | AmeriFlux BASE: US-Bar. |
| `AMF_US-xBR_BASE-BADM_9-5.zip` | AmeriFlux BASE: US-xBR. |
| `NEON.D01.BART.DP1.00033_DB_1000_1day.csv` |  PhenoCam data: GCC. |
| `NEON.D01.BART.DP1.00033_DB_1000_1day_transition_dates.csv` | PhenoCam data: transition dates. |
| `bartlettir_DB_1000_1day.csv` | PhenoCam data: GCC. |
| `bartlettir_DB_1000_1day_transition_dates.csv` | PhenoCam data: transition dates. |
| `bbc7_DB_1000_1day.csv` | PhenoCam data: GCC. |
| `bbc7_DB_1000_1day_transition_dates.csv` | PhenoCam data: transition. |

