d <- rep(c(-1, 1), each = 8)
c <- rep(rep(c(-1, 1), each = 4), 2)
b <- rep(rep(c(-1, 1), each = 2), 4)
a <- rep(rep(c(-1, 1), each = 1), 8)

y <- c(
  190, 174, 181, 183, 177, 181, 188, 173,
  198, 172, 187, 185, 199, 179, 187, 180
)

abcd <- a * b * c * d
block <- ifelse(abcd == 1, "Block1", "Block2")

df <- data.frame(
  a = factor(a), b = factor(b),
  c = factor(c), d = factor(d),
  block = factor(block), y = y
)

print(df)

mod <- lm(
  y ~ block + a + b + c + d + a:b + a:c + a:d + b:c + b:d + c:d,
  data = df
)

print(anova(mod))
