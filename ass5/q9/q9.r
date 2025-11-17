dev_strength <- rep(1:3, each = 12)
dev_time <- rep(rep(c(10, 14, 18), each = 4), 3)
density <- c(
  0, 2, 5, 4, 1, 3, 4, 2, 2, 5, 4, 6,
  4, 6, 7, 5, 6, 8, 7, 7, 9, 10, 8, 5,
  7, 10, 8, 7, 10, 10, 8, 7, 12, 10, 9, 8
)

data <- data.frame(
  Strength = factor(dev_strength),
  Time = factor(dev_time),
  Density = density
)

print(data)

means <- aggregate(Density ~ Strength + Time, data = data, mean)
cat("---\nMeans by Strength and Time:\n")
print(means)

model <- aov(Density ~ Strength * Time, data = data)
print(summary(model))

interaction.plot(
  data$Time, data$Strength, data$Density,
  type = "b", pch = 1:3, legend = TRUE,
  ylab = "Mean Density", xlab = "Development Time"
)
