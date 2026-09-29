sitename = "KONZ_AmeriFlux"

df_input = fread(paste0("data_for_XGB_", sitename, ".csv"))
df_input$PPFD[df_input$PPFD < 0] = NA
df_input$NEE = df_input$NEE_for_gapfill 
data_filtered = df_input[df_input$Month == 7, ]

light_response_NEE <- function(PPFD, Amax, alpha, Rd) {
  -((Amax * PPFD) / (alpha + PPFD) - Rd)  # NEE is negative when GPP is high
}

fit_NEE <- nls(NEE ~ light_response_NEE(PPFD, Amax, alpha, Rd), 
               data = data_filtered, 
               start = list(Amax = max(-data_filtered$NEE, na.rm = TRUE), 
                            alpha = 200, Rd = 2))
# Extract model parameter estimates
params <- coef(fit_NEE)
Amax_est <- round(params["Amax"], 2)
alpha_est <- round(params["alpha"], 2)
Rd_est <- round(params["Rd"], 2)
A2000 = Amax_est * 2000/(alpha_est + 2000)

# Generate predicted values from the fitted model
data_filtered$NEE_pred <- predict(fit_NEE, newdata = data_filtered)
annotation_text <- paste0(
  "Amax = ", Amax_est, " µmol CO₂ m⁻² s⁻¹\n",
  "alpha = ", alpha_est, " µmol CO₂ m⁻² s⁻¹ per PPFD\n",
  "Rd = ", Rd_est, " µmol CO₂ m⁻² s⁻¹\n",
  "A2000 = ", round(A2000, 2)
)  

ylab = expression(FCO[2] ~ '('* μmol ~ m^{-2} ~ s^{-1}*')')

ggplot(data_filtered, aes(x = PPFD, y = NEE))  +
  geom_pointdensity(adjust = 1000) +
  geom_line(aes(y = NEE_pred), color = "red", size = 1.2) +  # Predicted NEE line
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey", size = 1) +  
  geom_vline(xintercept = 1800, linetype = "dashed", color = "grey", size = 1) +
  labs(x = "PPFD (µmol m⁻² s⁻¹)", y = ylab, title = sitename) +
  geom_text(aes(x = 700, y = 5, label = annotation_text),
            hjust = 0, size = 5, color = "black", lineheight = 1.1) 

