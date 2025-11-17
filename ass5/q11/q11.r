c <- rep(rep(c(-1, 1), each = 8), 2)
b <- rep(rep(c(-1, 1), each = 4), 4)
a <- rep(rep(c(-1, 1), each = 2), 8)
data <- c(
  -3, -1,
  0, 1,
  -1, 0,
  2, 3,
  -1, 0,
  2, 1,
  1, 1,
  6, 5
)

raw_data <- data.frame(
  a = factor(a), b = factor(b), c = factor(c), data = data
)

print(raw_data)

print(summary(aov(data ~ a * b * c, raw_data)))
