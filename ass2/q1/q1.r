# Data for each combination of factors A (location) and B (week)
location <- factor(rep(c("Loc1", "Loc2", "Loc3", "Loc4"), 2))
week <- factor(rep(c("Midterm", "Final"), each = 4))
hours_not_used <- c(16.5, 11.8, 12.3, 16.6, 21.4, 17.3, 16.9, 21.0)

# Create a data frame
print("[~] === DATA ===")
data <- data.frame(location, week, hours_not_used)
print(data)

# Perform Two-way ANOVA
print("[+] === TWO WAY ANOVA ===")
anova_result <- aov(hours_not_used ~ location + week, data = data)

# Summary of ANOVA
print(summary(anova_result))

# (Optional) Interaction term
print("[+] === INTERACTION EFFECT ===")
anova_result_interaction <- aov(hours_not_used ~ location * week, data = data)
print(summary(anova_result_interaction))
