
📄 Code and data for the paper:
### A tale of two towers: comparing NEON and AmeriFlux data streams at Bartlett Experimental Forest

Yujie Liu; Paul Stoy; Housen Chu; Dave Y. Hollinger; Scott V. Ollinger; Andrew P. Ouimette; Dave Durden; Cove Sturtevant; Ben Lucas; Andrew D. Richardson

🎉 The paper has been accepted for publication in _Agricultural and Forest Meteorology_.

💼 Contact information: yujie.liu@nau.edu

---
### Project Files and Descriptions

🟩 01_download_data_PhenoCam.Rmd

• Downloads PhenoCam data (GCC and transition dates) using the R package `phenocamr`.

📦 02_download_AmeriFlux_BASE.Rmd

• Downloads AmeriFlux BASE data using R package `amerifluxr`.

• Organizes data into the format required for R package `REddyProc`.

⚙️ 03_REddyProc.Rmd

• Performs IQR filtering, u* filtering, and MDS gapfilling.

• A comprehensive tutorial for these steps is available here:
https://github.com/YujieLiu666/Bridginggap-flux. The tutorial has been presented for FLUXNET workshop "Bridging the Gap: Flux Data Meets Land Surface Models" in August 2025: https://fluxnet.org/bridging-the-gap-flux-data-meets-land-surface-models-a-successful-workshop/.

🤖 04_train_XGBoost.ipynb

• Performs FCO₂ gapfilling using the machine learning model `XGBoost`. A comprehensive tutorial for gap-filling can be found here https://github.com/YujieLiu666/NEON_gapfill_test/. This was presented in a breakout session at AmeriFlux annual meeting 2025: https://ameriflux.lbl.gov/community/ameriflux-meetings-workshops/2025-ameriflux-annual-meeting/2025-breakout-sessions/

🌊 05_wavelet_FCO2.R

• Conducts wavelet analysis for FCO₂ using the R package `WaveletComp`.






