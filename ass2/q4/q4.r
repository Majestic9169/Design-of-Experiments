# Define factors: Variety and Fertilizer
variety <- factor(rep(c("A", "B", "C", "D"), each = 3))
fertilizer <- factor(rep(c("α", "β", "γ"), 4))

# Yield data (quintals per plot)
yield <- c(8, 3, 7, 10, 4, 8, 6, 5, 6, 8, 4, 7)

# Create data frame
data <- data.frame(variety, fertilizer, yield)
print(data)

# Perform two-way ANOVA without interaction
anova_result <- aov(yield ~ variety + fertilizer, data = data)

# Print summary
print(summary(anova_result))
