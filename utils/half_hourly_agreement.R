# Install and load required packages
if (!require(e1071)) install.packages("e1071", dependencies = TRUE)
library(lmodel2)


#------------------------------------------------------------------------------
# Calculate the perpendicular (orthogonal) distance from each point to a line
#
# Inputs:
#   x         : x coordinates
#   y         : y coordinates
#   slope     : slope of the fitted line
#   intercept : intercept of the fitted line
#
# Output:
#   Vector of perpendicular distances
#------------------------------------------------------------------------------
perpendicular_distances <- function(x, y, slope, intercept) {
  abs(slope * x - y + intercept) / sqrt(slope^2 + 1)
}


#------------------------------------------------------------------------------
# Calculate perpendicular root mean square error (RMSE)
#
# Inputs:
#   x         : x coordinates
#   y         : y coordinates
#   slope     : slope of the fitted line
#   intercept : intercept of the fitted line
#
# Output:
#   Orthogonal RMSE
#------------------------------------------------------------------------------
perpendicular_rmse <- function(x, y, slope, intercept) {
  distances <- perpendicular_distances(x, y, slope, intercept)
  sqrt(mean(distances^2, na.rm = TRUE))
}


#------------------------------------------------------------------------------
# Calculate Model II regression statistics using Major Axis (MA) regression
#
# Inputs:
#   df : data frame containing two columns:
#        v1 = predictor
#        v2 = response
#
# Output:
#   Data frame containing:
#     - number of observations
#     - intercept
#     - slope
#     - angle
#     - p-value
#     - R-squared
#     - 95% confidence intervals
#     - orthogonal RMSE
#------------------------------------------------------------------------------
work_agreement <- function(df) {
  library(lmodel2)
  
  # Fit Model II regression
  fit <- lmodel2(v2 ~ v1, df, range.y = "interval", range.x = "interval", 99)
  
  # Extract regression results
  reg <- fit$regression.results
  names(reg) <- c("method", "intercept", "slope", "angle", "p-value")
  reg <- reg[2,]  # Major Axis (MA) regression
  
  # Regression statistics
  intercept <- round(as.numeric(reg[2]), 4)
  slope <- round(as.numeric(reg[3]), 4)
  angle <- round(as.numeric(reg[4]), 4)
  pvalue <- round(as.numeric(reg[5]), 4)
  rsquare <- round(fit$rsquare, 4)
  
  # Extract 95% confidence intervals
  df.conf = fit$confidence.intervals[2,]
  intercept_lower <- round(df.conf$`2.5%-Intercept`, 4)
  intercept_higher <- round(df.conf$`97.5%-Intercept`, 4)
  slope_lower <- round(df.conf$`2.5%-Slope`, 4)
  slope_higher <- round(df.conf$`97.5%-Slope`, 4)
  
  # Remove missing observations before calculating orthogonal RMSE
  df_clean <- na.omit(df[, c("v1", "v2")])
  
  # Calculate orthogonal RMSE
  rmse_value <- perpendicular_rmse(
    x = df_clean$v1,
    y = df_clean$v2,
    slope = slope,
    intercept = intercept
  )
  
  rmse_value <- round(rmse_value, 4)
  
  # Number of paired observations
  n_obs <- min(sum(!is.na(df$v1)), sum(!is.na(df$v2)))
  
  # Return summary statistics
  result <- data.frame(
    number_of_observations = n_obs,
    intercept = intercept,
    slope = slope,
    angle = angle,
    pvalue = pvalue,
    rsquare = rsquare,
    intercept_lower = intercept_lower,
    intercept_higher = intercept_higher,
    slope_lower = slope_lower,
    slope_higher = slope_higher,
    rmse = rmse_value
  )
  
  return(result)
}


#------------------------------------------------------------------------------
# Compute descriptive statistics for a numeric vector
#
# Inputs:
#   values : numeric vector
#
# Output:
#   Named list containing:
#     - mean
#     - median
#     - mode
#     - standard deviation
#     - skewness
#     - kurtosis
#
# The statistics are also printed to the console.
#------------------------------------------------------------------------------
compute_stats <- function(values) {
  
  # Ensure the input is numeric
  if (!is.numeric(values)) {
    stop("Input must be a numeric vector")
  }
  
  # Remove missing values
  values_clean <- values[!is.na(values)]
  
  # Calculate descriptive statistics
  mean_original <- mean(values_clean)
  median_original <- median(values_clean)
  
  # Calculate the mode (most frequent value)
  mode_original <- as.numeric(
    names(sort(table(values_clean), decreasing = TRUE)[1])
  )
  
  # Standard deviation
  sd_original <- sd(values_clean)
  
  # Distribution shape statistics
  skewness_original <- skewness(values_clean)
  kurtosis_original <- kurtosis(values_clean)
  
  # Print summary statistics
  cat("Mean: ", round(mean_original, 2), "\n")
  cat("Median: ", round(median_original, 2), "\n")
  cat("Mode: ", round(mode_original, 2), "\n")
  cat("Standard Deviation: ", round(sd_original, 2), "\n")
  cat("Skewness: ", round(skewness_original, 2), "\n")
  cat("Kurtosis: ", round(kurtosis_original, 2), "\n")
  
  # Return results as a named list
  return(list(
    mean = mean_original,
    median = median_original,
    mode = mode_original,
    sd = sd_original,
    skewness = skewness_original,
    kurtosis = kurtosis_original
  ))
}