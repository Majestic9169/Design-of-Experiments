# Tegan Jain
# 23CS30065
# Assignment 1
# Question 3

# Install packages
if (!require(car)) install.packages("car", dependencies = TRUE)
library(car)
if (!require(DescTools)) install.packages("DescTools", dependencies = TRUE)
library(DescTools)
if (!require(agricolae)) install.packages("agricolae", dependencies = TRUE)
library(agricolae)

# Input the data
coating <- rep(c("C1", "C2", "C3", "C4", "C5"), each = 4)
conductivity <- c(
  143, 141, 150, 146, # C1
  152, 149, 137, 143, # C2
  134, 133, 132, 127, # C3
  129, 127, 132, 129, # C4
  147, 148, 144, 142 # C5
)
battery_data <- data.frame(coating, conductivity)

# Bartlett's Test
cat("\n=== Bartlett's Test (equal variance assumption) ===\n")
print(bartlett.test(conductivity ~ coating, data = battery_data))

# Levene's Test
cat("\n=== Levene's Test ===\n")
print(leveneTest(conductivity ~ coating, data = battery_data))

# Overall Mean & Treatment Effects
overall_mean <- mean(battery_data$conductivity)
coating_means <- aggregate(
  conductivity ~ coating,
  data = battery_data,
  FUN = mean
)
coating_means$effect <- coating_means$conductivity - overall_mean
cat("\n=== Overall Mean ===\n")
print(overall_mean)
cat("\n=== coating Means & Treatment Effects ===\n")
print(coating_means)

# One-way ANOVA
battery_aov <- aov(conductivity ~ coating, data = battery_data)
cat("\n=== ANOVA Results ===\n")
print(summary(battery_aov))

# Duncan's Multiple Range Test
cat("\n=== Duncan's Multiple Range Test ===\n")
print(duncan.test(battery_aov, "coating"))
