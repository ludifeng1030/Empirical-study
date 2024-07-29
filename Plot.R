library(ggplot2)
library(dplyr)
library(ggrepel)
setwd("/Users/ludifeng/Desktop/Master thesis")
Data<- read.csv("/Users/ludifeng/Desktop/Master thesis/Data.csv", header = TRUE, sep = ",")


Data <- Data %>%
  arrange(region, year)

# GDP per capita growth rate over time by province
ggplot(Data, aes(x = year, y = GDP_pgr, group = region, color = region)) +
  geom_line() +
  labs(title = "GDP per capita growth rate over time by province",
       x = "Year",
       y = "GDP per capita growth rate (%)",
       color = "region") +
  theme_bw()+
  scale_y_continuous(
    breaks = seq(from = 0, to = 30, by = 5),  
    labels = scales::comma  
  )

# Provincial GDP per capita over time
ggplot(Data, aes(x = year, y = gdp_per, group = region, color = region)) +
  geom_line() +
  labs(title = "Provincial GDP per capita over time",
       x = "Year",
       y = "GDP per capita (RMB/person)",
       color = "region") +
  theme_bw()+
  scale_y_continuous(
    breaks = seq(from = 0, to = 150000, by = 25000),  
    labels = scales::comma  
  )

# Relationship between Real Interest Rate and Savings Rate by Province
ggplot(Data, aes(x = Rir, y = Rsr)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +  
  labs(title = "Relationship between Real Interest Rate and Savings Rate by Province",
       x = "Real Interest Rate",
       y = "Savings Rate") +
  theme_light()

 


Data_summarized <- Data %>%
  group_by(year) %>%
  summarise(
    average_nominal_rate = mean(Nir, na.rm = TRUE),  
    average_real_rate = mean(Rir, na.rm = TRUE),     
    average_savings_rate = mean(Rsr, na.rm = TRUE)   
  )

# Average Annual Real and Nominal Interest Rates and Change in Residents Savings Rate
ggplot(data = Data_summarized, aes(x = year)) +
  geom_line(aes(y = average_nominal_rate, colour = "Nominal Interest Rate", linetype = "Nominal Interest Rate"), size = 0.5) +
  geom_point(aes(y = average_nominal_rate, colour = "Nominal Interest Rate", shape = "Nominal Interest Rate"), size = 3) +
  geom_line(aes(y = average_real_rate, colour = "Real Interest Rate", linetype = "Real Interest Rate"), size = 0.5) +
  geom_point(aes(y = average_real_rate, colour = "Real Interest Rate", shape = "Real Interest Rate"), size = 3) +
  geom_line(aes(y = average_savings_rate, colour = "Residents Savings Rate", linetype = "Residents Savings Rate"), size = 0.5) +
  geom_point(aes(y = average_savings_rate, colour = "Residents Savings Rate", shape = "Residents Savings Rate"), size = 3) +
  labs(
    title = "Average Annual Real and Nominal Interest Rates and Change in Residents Savings Rate",
    x = "Year",
    y = "Rate (%)",
    colour = "Indicator",  
    linetype = "Indicator",  
    shape = "Indicator"  
  ) +
  scale_x_continuous(breaks = 2004:2022, limits = c(2004, 2022)) +
  scale_y_continuous(breaks = seq(-10, 40, by = 5), limits = c(-10, 40)) +
  scale_colour_manual(values = c("Nominal Interest Rate" = "black", "Real Interest Rate" = "black", "Residents Savings Rate" = "black")) +
  scale_linetype_manual(values = c("Nominal Interest Rate" = "solid", "Real Interest Rate" = "dashed", "Residents Savings Rate" = "dotted")) +
  scale_shape_manual(values = c("Nominal Interest Rate" = 4, "Real Interest Rate" = 18, "Residents Savings Rate" = 17)) +
  theme_minimal() +
  theme(
    legend.position = "top",
    legend.title.align = 0.5,
    panel.grid.major = element_blank(),  
    panel.grid.minor = element_blank(),  
    panel.background = element_blank(), 
    axis.line = element_line(color = "black"),
    plot.title = element_text(hjust = 0.5)
  )



###############Pairs plot

library(GGally)
pairs_plot <- ggpairs(Data_selected,
                      lower = list(
                        continuous = wrap("smooth", method = "lm", colour = "blue", size = 0.5, alpha = 0.5)
                      ),
                      upper = list(
                        continuous = wrap("cor", size = 4, colour = "red")
                      ),
                      diag = list(
                        continuous = wrap("barDiag", fill = "darkgray")
                      )
) +
  theme_light(base_size = 14) +
  theme(
    panel.spacing = grid::unit(2, "lines"),  
    axis.text.x = element_text(angle = 45, hjust = 1, size = 12),
    axis.text.y = element_text(size = 12),
    plot.margin = margin(15, 15, 15, 15)  
  )
# Print the figure
print(pairs_plot)
ggsave("Improved_PairsPlot.png", plot = pairs_plot, width = 30, height = 30, dpi = 300)




