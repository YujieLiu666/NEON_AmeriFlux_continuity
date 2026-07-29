library(data.table)
library(dplyr)
library(tidyr)
library(vegan)

#=========================================================
# Function 1: Bray-Curtis dissimilarity from footprint weighted EVI
#=========================================================
compute_evi_dissimilarity <- function(wdata,
                                      value_col = "value",
                                      weight_col = "weight",
                                      site_col = "site",
                                      bins = seq(0.09, 0.4, by = 0.01)) {
  
  # Create bins
  wdata <- wdata %>%
    mutate(bin = cut(.data[[value_col]],
                     breaks = bins,
                     include.lowest = TRUE))
  
  # Relative weight per site-bin
  binned_data <- wdata %>%
    group_by(.data[[site_col]], bin) %>%
    summarise(weight_sum = sum(.data[[weight_col]]),
              .groups = "drop") %>%
    group_by(.data[[site_col]]) %>%
    mutate(weight_rel = weight_sum / sum(weight_sum)) %>%
    select(all_of(site_col), bin, weight_rel)
  
  # Fill missing bins
  binned_data <- binned_data %>%
    ungroup() %>%
    complete(
      !!rlang::sym(site_col),
      bin,
      fill = list(weight_rel = 0)
    ) %>%
    pivot_wider(
      names_from = bin,
      values_from = weight_rel,
      values_fill = 0
    )
  
  # Community matrix
  mat <- as.data.frame(binned_data)
  rownames(mat) <- mat[[site_col]]
  mat <- mat %>% select(-all_of(site_col))
  
  # Bray-Curtis dissimilarity
  vegdist(mat, method = "bray")
}


#=========================================================
# Function 2: Bray-Curtis dissimilarity from footprint weighted land cover
#=========================================================
compute_landcover_dissimilarity <- function(data,
                                            site_col = "sitename",
                                            class_col = "Class",
                                            percent_col = "percentage") {
  
  land_cover_df <- data %>%
    select(all_of(c(site_col, class_col, percent_col))) %>%
    pivot_wider(
      names_from = all_of(class_col),
      values_from = all_of(percent_col),
      values_fill = 0
    )
  
  rownames(land_cover_df) <- land_cover_df[[site_col]]
  land_cover_df <- land_cover_df %>%
    select(-all_of(site_col))
  
  vegdist(land_cover_df, method = "bray")
}


