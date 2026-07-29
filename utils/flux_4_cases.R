calc_case_summary <- function(diff, Ncase, NEON_ID, year, case_name) {
  
  if (Ncase == 0) {
    return(data.frame(
      NEON_ID = NEON_ID,
      Year = year,
      case = case_name,
      Ncase = 0,
      delta_F = NA,
      delta_Ctot_1000 = NA,
      delta_Ctot = NA
    ))
  }
  
  delta_F <- round(mean(diff, na.rm = TRUE), 3)
  sum_diff <- sum(diff, na.rm = TRUE)
  
  # µmol CO2 m-2 s-1 → g C (30-min timestep)
  sum_g_C <- sum_diff * 12 * 30 * 60 / 1e6
  
  delta_Ctot_1000 <- round(sum_g_C / Ncase * 1000, 1)
  delta_Ctot <- round(sum_g_C, 0)
  
  data.frame(
    NEON_ID = NEON_ID,
    Year = year,
    case = case_name,
    Ncase = Ncase,
    delta_F = delta_F,
    delta_Ctot_1000 = delta_Ctot_1000,
    delta_Ctot = delta_Ctot
  )
}

# run all 4 cases for one year
run_case_analysis_one_year <- function(df_year, NEON_ID) {
  
  year <- unique(df_year$Year)
  
  # case 1: both measured
  d1 <- df_year[df_year$case == "case1", ]
  diff1 <- d1$FC_measured_NEON - d1$FC_measured_ameriflux
  s1 <- calc_case_summary(diff1, nrow(d1), NEON_ID, year, "case1")
  
  # case 2: NEON gap-filled
  d2 <- df_year[df_year$case == "case2", ]
  diff2 <- d2$FC_fall_NEON - d2$FC_measured_ameriflux
  s2 <- calc_case_summary(diff2, nrow(d2), NEON_ID, year, "case2")
  
  # case 3: AmeriFlux gap-filled
  d3 <- df_year[df_year$case == "case3", ]
  diff3 <- d3$FC_measured_NEON - d3$FC_fall_ameriflux
  s3 <- calc_case_summary(diff3, nrow(d3), NEON_ID, year, "case3")
  
  # case 4: both gap-filled
  d4 <- df_year[df_year$case == "case4", ]
  diff4 <- d4$FC_fall_NEON - d4$FC_fall_ameriflux
  s4 <- calc_case_summary(diff4, nrow(d4), NEON_ID, year, "case4")
  
  rbind(s1, s2, s3, s4)
}