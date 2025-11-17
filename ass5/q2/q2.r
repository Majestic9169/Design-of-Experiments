rate <- factor(rep(c("r1", "r2"), each = 8))
temp <- factor(rep(rep(c("120", "135"), each = 4), 2))
time <- factor(rep(rep(c("30", "60"), each = 2), 4))

dye <- c(
  19.9, 18.6, 17.4, 16.8,
  25.0, 22.8, 19.5, 18.3,
  14.5, 16.1, 16.3, 14.6,
  27.7, 18.0, 28.3, 26.2
)

data <- data.frame(rate, temp, time, dye)

print(data)

print(aggregate(dye ~ rate + temp + time, data = data, mean))

anova_result <- aov(dye ~ rate * temp * time, data = data)
print(summary(anova_result))
