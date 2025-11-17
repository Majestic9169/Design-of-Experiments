# Factors: City and Car Brand
city <- factor(rep(c("Chennai", "Delhi", "Kolkata", "Mumbai"), each = 8))
brand <- factor(rep(c("A", "A", "B", "B", "C", "C", "D", "D"), times = 4))

# Kilometers traveled for each car (2 cars per brand per city)
km <- c(
  92.3, 104.1, 90.4, 103.8, 110.2, 115.0, 120.0, 125.4, # Chennai
  96.2, 98.6, 91.8, 100.4, 112.3, 111.7, 124.1, 121.1, # Delhi
  90.8, 96.2, 90.3, 89.1, 107.2, 103.8, 118.4, 115.6, # Kolkata
  98.5, 97.3, 96.8, 98.8, 115.2, 110.2, 126.2, 120.4 # Mumbai
)

# Create data frame
data <- data.frame(city, brand, km)
print(data)

# Perform two-way ANOVA including interaction
anova_result <- aov(km ~ city + brand, data = data)

# Print ANOVA table
print(summary(anova_result))
