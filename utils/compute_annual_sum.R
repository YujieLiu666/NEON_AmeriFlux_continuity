#------------------------------------------------------------------------------
# Calculate annual carbon flux (g C m^-2 yr^-1)
#
# Inputs:
#   data       : data frame containing CO2 flux observations
#   var_name   : column name of the CO2 flux variable (µmol CO2 m^-2 s^-1)
#   start_year : first year to calculate
#   end_year   : last year to calculate
#
# Output:
#   Data frame with Year and annual carbon flux (g C m^-2 yr^-1)
#------------------------------------------------------------------------------
cal_FC_annual_sum <- function(data, var_name, start_year, end_year) {
  
  # Helper function to determine whether a year is a leap year
  is_leap_year <- function(year) {
    (year %% 4 == 0 & year %% 100 != 0) | (year %% 400 == 0)
  }
  
  # Molar mass of carbon (g mol^-1)
  molar_mass <- 12.011
  
  # Initialize output list
  agg_list <- list()
  
  # Loop through each year
  for (yr in start_year:end_year) {
    
    # Subset data for the current year
    data_sub <- data[data$Year == yr, ]
    
    # Extract CO2 flux values
    half_hour <- data_sub[[var_name]]
    
    # Calculate the annual mean CO2 flux (µmol m^-2 s^-1)
    agg_co2 <- mean(half_hour, na.rm = TRUE)
    
    # Determine the number of days in the year
    n_days <- ifelse(is_leap_year(yr), 366, 365)
    
    # Convert the annual mean flux to annual carbon flux (g C m^-2 yr^-1)
    agg <- agg_co2 * 1e-6 * molar_mass * 3600 * 24 * n_days
    
    # Store the annual result
    agg_list[[as.character(yr)]] <- data.frame(
      Year = yr,
      annual_sum = round(agg, 0)
    )
  }
  
  # Combine yearly results into a single data frame
  agg_data <- do.call(rbind, agg_list)
  
  return(agg_data)
}


#------------------------------------------------------------------------------
# Calculate summer (JJA) carbon flux (g C m^-2)
#
# Inputs:
#   data       : data frame containing half-hourly CO2 flux observations
#   var_name   : column name of the CO2 flux variable (µmol CO2 m^-2 s^-1)
#   start_year : first year to calculate
#   end_year   : last year to calculate
#
# Output:
#   Data frame with Year and summer (JJA) carbon flux (g C m^-2)
#------------------------------------------------------------------------------
cal_FC_JJA_sum <- function(data, var_name, start_year, end_year) {
  
  # Molar mass of carbon (g mol^-1)
  molar_mass <- 12.011
  
  # Duration of each half-hour measurement (seconds)
  seconds_per_step <- 1800
  
  # Initialize output list
  agg_list <- list()
  
  # Loop through each year
  for (yr in start_year:end_year) {
    
    # Keep only June, July, and August observations
    data_sub <- data[data$Year == yr & data$Month %in% c(6, 7, 8), ]
    
    # Extract CO2 flux values
    flux <- data_sub[[var_name]]
    
    # Calculate total summer carbon flux (g C m^-2)
    agg <- sum(flux, na.rm = TRUE) * 1e-6 * molar_mass * seconds_per_step
    
    # Store the annual result
    agg_list[[as.character(yr)]] <- data.frame(
      Year = yr,
      annual_sum = round(agg, 0)
    )
  }
  
  # Combine yearly results into a single data frame
  agg_data <- do.call(rbind, agg_list)
  
  return(agg_data)
}


#------------------------------------------------------------------------------
# Calculate annual latent heat flux (MJ m^-2 yr^-1)
#
# Inputs:
#   data       : data frame containing latent heat flux observations (W m^-2)
#   var_name   : column name of the latent heat flux variable
#   start_year : first year to calculate
#   end_year   : last year to calculate
#
# Output:
#   Data frame with Year and annual latent heat flux (MJ m^-2 yr^-1)
#------------------------------------------------------------------------------
cal_LE_annual_sum <- function(data, var_name, start_year, end_year) {
  
  agg_data <- data |>
    dplyr::filter(
      Year >= start_year,
      Year <= end_year
    ) |>
    dplyr::group_by(Year) |>
    dplyr::summarise(
      # Convert annual mean latent heat flux to annual latent heat (MJ m^-2 yr^-1)
      annual_sum =
        mean(.data[[var_name]], na.rm = TRUE) *
        3600 * 24 * 365.25 / 1e6,
      .groups = "drop"
    )
  
  return(agg_data)
}


#------------------------------------------------------------------------------
# Calculate summer (JJA) latent heat flux (MJ m^-2)
#
# Inputs:
#   data       : data frame containing latent heat flux observations (W m^-2)
#   var_name   : column name of the latent heat flux variable
#   start_year : first year to calculate
#   end_year   : last year to calculate
#
# Output:
#   Data frame with Year and summer (JJA) latent heat flux (MJ m^-2)
#------------------------------------------------------------------------------
cal_LE_JJA_sum <- function(data, var_name, start_year, end_year) {
  
  agg_data <- data |>
    dplyr::filter(
      Year >= start_year,
      Year <= end_year,
      Month %in% c(6, 7, 8)
    ) |>
    dplyr::group_by(Year) |>
    dplyr::summarise(
      # Convert mean summer latent heat flux to total summer latent heat (MJ m^-2)
      annual_sum =
        mean(.data[[var_name]], na.rm = TRUE) *
        3600 * 24 * (30 + 31 + 31) / 1e6,
      .groups = "drop"
    )
  
  return(agg_data)
}