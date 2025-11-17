d <- rep(c(-1, 1), each = 8)
c <- rep(rep(c(-1, 1), each = 4), 2)
b <- rep(rep(c(-1, 1), each = 2), 4)
a <- rep(rep(c(-1, 1), each = 1), 8)

y <- c(
  229.5, 39.2, 32.1, 38.2,
  27.3, 33.8, 25.3, 35.7,
  31.4, 37.6, 31.0, 38.9,
  24.9, 35.9, 27.1, 34.1
)

abcd <- a * b * c * d
lab <- ifelse(abcd == 1, "lab1", "lab2")

df <- data.frame(
  a = factor(a), b = factor(b),
  c = factor(c), d = factor(d),
  lab = factor(lab), y = y
)

print(df)

contrast_a <- sum(df$y[df$a == 1] - df$y[df$a == -1])
contrast_b <- sum(df$y[df$b == 1] - df$y[df$b == -1])
contrast_c <- sum(df$y[df$c == 1] - df$y[df$c == -1])
contrast_d <- sum(df$y[df$d == 1] - df$y[df$d == -1])
ss_a <- (contrast_a^2) / (16)
ss_b <- (contrast_b^2) / (16)
ss_c <- (contrast_c^2) / (16)
ss_d <- (contrast_d^2) / (16)

cat("\n")
cat("Contrast for A: ", contrast_a, "\n")
cat("Contrast for B: ", contrast_b, "\n")
cat("Contrast for C: ", contrast_c, "\n")
cat("Contrast for D: ", contrast_d, "\n")
cat("\n")
cat("SS_a: ", ss_a, "\n")
cat("SS_b: ", ss_b, "\n")
cat("SS_c: ", ss_c, "\n")
cat("SS_d: ", ss_d, "\n")
cat("\n")

mod <- lm(
  y ~ lab + a + b + c + d + a:b + a:c + a:d + b:c + b:d + c:d,
  data = df
)

print(anova(mod))
