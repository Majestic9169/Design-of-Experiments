light <- factor(rep(c("9h", "14h"), each = 4))
temp <- factor(rep(rep(c("16", "17"), each = 2), 2))
growth <- c(1.30, 1.88, 0.90, 1.06, 1.01, 1.52, 0.83, 0.67)

data <- data.frame(light, temp, growth)

print(data)

print(aggregate(growth ~ light + temp, data = data, mean))

anova_result <- aov(growth ~ light * temp, data = data)
print(summary(anova_result))
