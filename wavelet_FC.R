# packages and paramters
{
  library("WaveletComp")
  library("fields")
  library(zoo)

  my_palette <- colorRampPalette(c("#f480a1", "#ffa840","#e6da97", "#9bebcc", "#2166ac"))
  n.levels = 250
  dt = 1/48
  upperPeriod = 6*365 +100
  
}

# read in data 
{
  input = "input_filename.csv"
  gapfilled.df <- read.csv(input, header = T); XGB.combined[XGB.combined == -9999] <- NA 
  gapfilled.df$XGB_NEE_U50_f = ( gapfilled.df$XGB_NEE_U50_f - mean( gapfilled.df$XGB_NEE_U50_f, na.rm = T))/sd( gapfilled.df$XGB_NEE_U50_f)
 
}


# wavelet analysis
{
  setwd(output_dir)
  site = "AmeriFlux"; data = gapfilled.df
  wavelet_FC <- analyze.wavelet(data, "XGB_NEE_U50_f", method = "AR",
                                              loess.span = 0,
                                              dt = 1/48,
                                              dj = 1/50,
                                              make.pval = TRUE,
                                              n.sim = 100,
                                              upperPeriod = upperPeriod,
                                              lowerPeriod = 2*dt)
  save(wavelet_FC, file = "wavelet_FC")
  
}


