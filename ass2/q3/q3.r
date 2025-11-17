# Define factors: Subject (blocks) and Stimulus (treatments)
subject <- factor(rep(1:4, each = 3))
stimulus <- factor(c(
  1, 3, 2,
  3, 1, 2,
  1, 2, 3,
  2, 1, 3
))

# Response variable: time to reaction (seconds)
response <- c(
  1.7, 2.3, 3.4,
  2.1, 1.5, 2.6,
  0.1, 2.3, 0.8,
  2.2, 0.6, 1.6
)

# Create data frame
data <- data.frame(subject, stimulus, response)
print(data)

# Perform Two-way ANOVA with blocking (subject as factor) without interaction
anova_result <- aov(response ~ stimulus + subject, data = data)

# Print ANOVA summary
print(summary(anova_result))
