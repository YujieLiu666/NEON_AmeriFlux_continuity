
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
│   ├── AMF_US-Bar_BASE-BADM_6-5.zip
│   ├── AMF_US-xBR_BASE-BADM_9-5.zip
│   ├── NEON.D01.BART.DP1.00033_DB_1000_1day.csv
│   ├── NEON.D01.BART.DP1.00033_DB_1000_1day_transition_dates.csv
│   ├── bartlettir_DB_1000_1day.csv
│   ├── bartlettir_DB_1000_1day_transition_dates.csv
│   ├── bbc7_DB_1000_1day.csv
│   └── bbc7_DB_1000_1day_transition_dates.csv
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
```

---

## Tutorials

### Flux data postprocessing using REddyProc

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/YujieLiu666/Bridginggap-flux/main?urlpath=rstudio&resetx data gap-filling using XGBoost

https://colab.research.google.com/assets/colab-badge.svg](https://colab.research.google.com/github/YujieLiu666/NEON_gapfill_test/blob/main/workflow_XGB_google_colab.ipynb)

---

## Folders

| Folder | Description |
|----------|-------------|
| `raw_data_BART/` | Raw and processed datasets used in this study, including AmeriFlux, NEON, and phenological transition date products. |
| `scripts/` | Data download, preprocessing, quality control, flux processing, and wavelet analysis workflows. |
| `utils/` | Supporting functions, helper scripts, and reusable utilities used throughout the project. |

---

## Scripts

| Script | Description |
|----------|-------------|
| `01_download_data_PhenoCam.Rmd` | Downloads PhenoCam vegetation indices (GCC) and phenological transition dates using the `phenocamr` package. |
| `02_download_AmeriFlux_BASE.Rmd` | Downloads AmeriFlux BASE data and prepares files for downstream processing. |
| `03_REddyProc.html` | Flux post-processing including quality control, u★ filtering, and MDS gap-filling using REddyProc. |
| `04_download_NEON_Bundled_EC.html` | Downloads and organizes NEON bundled eddy covariance products. |
| `06_wavelet_analysis.R` | Performs wavelet analysis of ecosystem carbon fluxes using the `WaveletComp` package. |

---

## Raw Data Files

| File | Description |
|----------|-------------|
| `AMF_US-Bar_BASE-BADM_6-5.zip` | AmeriFlux BASE and BADM data for the Bartlett Experimental Forest site (US-Bar). |
| `AMF_US-xBR_BASE-BADM_9-5.zip` | AmeriFlux BASE and BADM data for the companion site (US-xBR). |
| `NEON.D01.BART.DP1.00033_DB_1000_1day.csv` | NEON disturbance database observations at Bartlett Experimental Forest. |
| `NEON.D01.BART.DP1.00033_DB_1000_1day_transition_dates.csv` | Transition dates derived from the NEON disturbance database. |
| `bartlettir_DB_1000_1day.csv` | Daily PhenoCam Green Chromatic Coordinate (GCC) observations. |
| `bartlettir_DB_1000_1day_transition_dates.csv` | Phenological transition dates derived from PhenoCam observations. |
| `bbc7_DB_1000_1day.csv` | Daily PhenoCam Green Chromatic Coordinate (GCC) observations. |
| `bbc7_DB_1000_1day_transition_dates.csv` | Phenological transition dates derived from PhenoCam observations. |

---

## Workflow

1. Download PhenoCam data.
2. Download AmeriFlux BASE data.
3. Download NEON eddy covariance products.
4. Process flux observations with REddyProc.
5. Gapfill flux data using XGBoost. 
6. Analyze ecosystem carbon flux dynamics using wavelet methods.

---

## Citation

If you use this repository, please cite:

> Liu, Y., Stoy, P., Chu, H., Hollinger, D. Y., Ollinger, S. V., Ouimette, A. P., Durden, D., Sturtevant, C., Lucas, B., & Richardson, A. D. (2025). *A tale of two towers: comparing NEON and AmeriFlux data streams at Bartlett Experimental Forest*. Agricultural and Forest Meteorology, 110939.
