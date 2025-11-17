blocks <- rep(c("Block1", "Block2"), each = 4, times = 2)
replicates <- rep(c(1, 2), each = 8)
treatments <- rep(c("(1)", "ab", "ac", "bc", "a", "b", "c", "abc"), times = 2)
responses <- c(
  99, 52, 42, 95, 18, 51, 108, 35, 46, -47, 22, 67, 18, 62, 104, 36
)

raw_data <- data.frame(
  Block = factor(blocks), Replicate = replicates,
  Treatment = treatments, Response = responses
)

coding <- data.frame(
  Treatment = c("(1)", "a", "b", "ab", "c", "ac", "bc", "abc"),
  A = c(-1, 1, -1, 1, -1, 1, -1, 1),
  B = c(-1, -1, 1, 1, -1, -1, 1, 1),
  C = c(-1, -1, -1, -1, 1, 1, 1, 1)
)

library(dplyr)

full_data <- left_join(raw_data, coding, by = "Treatment")

full_data <- full_data %>% mutate(
  A = as.numeric(A),
  B = as.numeric(B),
  C = as.numeric(C)
)

print(full_data)

model <- lm(Response ~ Block + A + B + C + A:B + A:C + B:C, data = full_data)

print(anova(model))
