# Tegan Jain
# 23CS30065
# Assignment 1
# Question 1

# Install packages
if (!require(car)) install.packages("car", dependencies = TRUE)
library(car)
if (!require(DescTools)) install.packages("DescTools", dependencies = TRUE)
library(DescTools)
if (!require(agricolae)) install.packages("agricolae", dependencies = TRUE)
library(agricolae)

# Input the data
brand <- rep(c("A", "B", "C", "D"), each = 5)
lifetime <- c(
  42, 30, 39, 28, 29, # Brand A
  28, 31, 31, 32, 27, # Brand B
  24, 36, 28, 28, 33, # Brand C
  20, 32, 38, 28, 25 # Brand D
)
battery_data <- data.frame(brand, lifetime)

# Bartlett's Test
cat("\n=== Bartlett's Test (equal variance assumption) ===\n")
print(bartlett.test(lifetime ~ brand, data = battery_data))

# Levene's Test
cat("\n=== Levene's Test ===\n")
print(leveneTest(lifetime ~ brand, data = battery_data))

# Overall Mean & Treatment Effects
overall_mean <- mean(battery_data$lifetime)
brand_means <- aggregate(lifetime ~ brand, data = battery_data, FUN = mean)
brand_means$effect <- brand_means$lifetime - overall_mean
cat("\n=== Overall Mean ===\n")
print(overall_mean)
cat("\n=== Brand Means & Treatment Effects ===\n")
print(brand_means)

# One-way ANOVA
battery_aov <- aov(lifetime ~ brand, data = battery_data)
cat("\n=== ANOVA Results ===\n")
print(summary(battery_aov))

# Tukey's HSD Test
cat("\n=== Tukey's HSD ===\n")
print(TukeyHSD(battery_aov))

# Scheffe's Test
cat("\n=== Scheffe's Test ===\n")
print(ScheffeTest(battery_aov))

# Fisher's LSD
cat("\n=== Fisher's LSD Test ===\n")
print(pairwise.t.test(
  battery_data$lifetime,
  battery_data$brand,
  p.adjust.method = "none"
))

# Duncan's Multiple Range Test
cat("\n=== Duncan's Multiple Range Test ===\n")
print(duncan.test(battery_aov, "brand"))

# Simultaneous Confidence Intervals (Tukey)
cat("\n=== Tukey Simultaneous Confidence Intervals ===\n")
print(TukeyHSD(battery_aov, conf.level = 0.95))
