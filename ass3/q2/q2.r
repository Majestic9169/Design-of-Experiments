# Factor levels
hardwood <- factor(rep(c(10, 15, 20), each = 12))
cooking_time <- factor(rep(c("1.5_hours", "2.0_hours"), each = 6, times = 3))
freeness <- factor(rep(c(400, 500, 650), times = 12))

# Response variable: Strength measurements
strength <- c(
  96.6, 97.7, 99.4,
  96.0, 96.0, 99.8,
  98.4, 99.6, 100.6,
  98.6, 100.4, 100.9,
  98.5, 96.0, 98.4,
  97.2, 96.9, 97.6,
  97.5, 98.7, 99.6,
  98.1, 98.0, 99,
  97.5, 95.6, 97.4,
  96.6, 96.2, 98.1,
  97.6, 97.0, 98.6,
  98.4, 97.8, 99.8
)

# Create data frame
data <- data.frame(hardwood, cooking_time, freeness, strength)
print(data)

# Perform three-way ANOVA with interaction terms
anova_result <- aov(strength ~ hardwood * cooking_time * freeness, data = data)

# Print ANOVA table
print(summary(anova_result))
