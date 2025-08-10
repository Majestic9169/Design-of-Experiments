# Tegan Jain
# 23CS30065
# Assignment 1
# Question 2

# Install packages
if (!require(car)) install.packages("car", dependencies = TRUE)
library(car)
if (!require(DescTools)) install.packages("DescTools", dependencies = TRUE)
library(DescTools)
if (!require(agricolae)) install.packages("agricolae", dependencies = TRUE)
library(agricolae)

# Input the data
technique <- c(
  rep("T1", 6),
  rep("T2", 7),
  rep("T3", 6),
  rep("T4", 4)
)
scores <- c(
  65, 87, 73, 79, 81, 69, # T1
  75, 69, 83, 81, 72, 79, 90, # T2
  59, 78, 67, 62, 83, 76, # T3
  94, 89, 80, 88 # T4
)
battery_data <- data.frame(technique, scores)

# Bartlett's Test
cat("\n=== Bartlett's Test (equal variance assumption) ===\n")
print(bartlett.test(scores ~ technique, data = battery_data))

# Levene's Test
cat("\n=== Levene's Test ===\n")
print(leveneTest(scores ~ technique, data = battery_data))

# Overall Mean & Treatment Effects
overall_mean <- mean(battery_data$scores)
technique_means <- aggregate(scores ~ technique, data = battery_data, FUN = mean)
technique_means$effect <- technique_means$scores - overall_mean
cat("\n=== Overall Mean ===\n")
print(overall_mean)
cat("\n=== technique Means & Treatment Effects ===\n")
print(technique_means)

# One-way ANOVA
battery_aov <- aov(scores ~ technique, data = battery_data)
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
  battery_data$scores,
  battery_data$technique,
  p.adjust.method = "none"
))

# Duncan's Multiple Range Test
cat("\n=== Duncan's Multiple Range Test ===\n")
print(duncan.test(battery_aov, "technique"))

# Simultaneous Confidence Intervals (Tukey)
cat("\n=== Tukey Simultaneous Confidence Intervals ===\n")
print(TukeyHSD(battery_aov, conf.level = 0.95))
