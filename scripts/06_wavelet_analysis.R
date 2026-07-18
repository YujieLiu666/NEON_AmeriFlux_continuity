#------------------------------------------------------------------------------
# Load required packages and define analysis parameters
#------------------------------------------------------------------------------
{
  # Load packages for wavelet analysis, visualization, and time series processing
  library("WaveletComp")
  library("fields")
  library(zoo)
  
  # Define color palette for wavelet plots
  my_palette <- colorRampPalette(c("#f480a1", "#ffa840", "#e6da97", "#9bebcc", "#2166ac"))
  
  # Number of color levels in the wavelet plot
  n.levels = 250
  
  # Time step of the data (half-hourly = 1/48 day)
  dt = 1/48
  
  # Maximum wavelet period (~6 years)
  upperPeriod = 6 * 365 + 100
  
}


#------------------------------------------------------------------------------
# Read and preprocess input data
#------------------------------------------------------------------------------
{
  # Input file containing gap-filled flux data
  input = "input_filename.csv"
  
  # Read input data
  gapfilled.df <- read.csv(input, header = T)
  
  # Replace missing value flag (-9999) with NA
  gapfilled.df[gapfilled.df == -9999] <- NA
  
  # Standardize NEE time series (mean = 0, standard deviation = 1)
  gapfilled.df$XGB_NEE_U50_f =
    (gapfilled.df$XGB_NEE_U50_f -
       mean(gapfilled.df$XGB_NEE_U50_f, na.rm = T)) /
    sd(gapfilled.df$XGB_NEE_U50_f)
  
}


#------------------------------------------------------------------------------
# Perform wavelet analysis
#------------------------------------------------------------------------------
{
  # Set output directory
  setwd(output_dir)
  
  # Define site name and input data
  site = "AmeriFlux"
  data = gapfilled.df
  
  # Perform continuous wavelet analysis
  wavelet_FC <- analyze.wavelet(
    data,
    "XGB_NEE_U50_f",
    method = "AR",
    loess.span = 0,
    dt = 1/48,
    dj = 1/50,
    make.pval = TRUE,
    n.sim = 100,
    upperPeriod = upperPeriod,
    lowerPeriod = 2 * dt
  )
  
  # Save wavelet analysis results
  save(wavelet_FC, file = "wavelet_FC")
  
}