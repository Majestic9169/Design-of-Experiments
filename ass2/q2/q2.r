# Create factors for Technicians and Makes (3 levels each)
technician <- factor(rep(c("Tech1", "Tech2", "Tech3"), each = 15))
make <- factor(rep(rep(c("Make1", "Make2", "Make3"), each = 5), 3))

# Data vector - hours or measurement values provided in row-wise order per technician and make
values <- c(
  62, 48, 63, 57, 69, # Tech1, Make1
  51, 57, 45, 50, 39, # Tech1, Make2
  59, 65, 55, 52, 70, # Tech1, Make3
  57, 45, 39, 54, 44, # Tech2, Make1
  61, 58, 70, 66, 51, # Tech2, Make2
  58, 63, 70, 53, 60, # Tech2, Make3
  59, 53, 67, 66, 47, # Tech3, Make1
  55, 58, 50, 69, 49, # Tech3, Make2
  47, 56, 51, 44, 50 # Tech3, Make3
)

# Create data frame
data <- data.frame(technician, make, values)

# Perform two-way ANOVA with interaction
anova_result <- aov(values ~ technician * make, data = data)

# Print summary of ANOVA
print(summary(anova_result))
