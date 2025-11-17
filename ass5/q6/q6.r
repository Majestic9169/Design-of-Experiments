data <- data.frame(
  Block = rep(1:8, each = 4),
  Interaction = rep(c(
    "ABC", "AB", "AC", "BC"
  ), each = 8),
  Treatment = c(
    "000", "110", "101", "011", # I   (ABC)
    "100", "010", "001", "111", # II  (ABC)
    "000", "110", "001", "111", # III (AB)
    "100", "010", "101", "011", # IV  (AB)
    "001", "100", "011", "110", # V   (AC)
    "000", "101", "010", "111", # VI  (AC)
    "100", "000", "011", "111", # VII (BC)
    "010", "110", "001", "101" # VIII (BC)
  ),
  Response = c(
    2208, 2133, 2459, 3096, # I
    2196, 2086, 3356, 2776, # II
    2004, 2112, 3073, 2631, # III
    2179, 2073, 3474, 3360, # IV
    2839, 2189, 3522, 2095, # V
    1916, 2979, 2151, 2500, # VI
    2056, 2010, 3209, 3066, # VII
    1878, 2156, 3423, 2524 # VIII
  )
)

# Function for coding (A,B,C)
treat_to_code <- function(code) {
  a <- ifelse(substr(code, 1, 1) == "1", 1, -1)
  b <- ifelse(substr(code, 2, 2) == "1", 1, -1)
  c <- ifelse(substr(code, 3, 3) == "1", 1, -1)
  c(a, b, c)
}

abc_codes <- t(sapply(data$Treatment, treat_to_code))
data$A <- abc_codes[, 1]
data$B <- abc_codes[, 2]
data$C <- abc_codes[, 3]

data$AB <- data$A * data$B
data$AC <- data$A * data$C
data$BC <- data$B * data$C
data$ABC <- data$A * data$B * data$C

print(data)

print(summary(
  aov(Response ~ Block + A + B + C + AB + BC + AC + ABC, data = data)
))

############################
# DATA ENTRY
############################

# Vector of 32 responses in order I listed them
y <- c(
  2208, 2133, 2459, 3096,
  2196, 2086, 3356, 2776,
  2004, 2112, 3073, 2631,
  2179, 2073, 3474, 3360,
  2839, 2189, 3522, 2095,
  1916, 2979, 2151, 2500,
  2056, 2010, 3209, 3066,
  1878, 2156, 3423, 2524
)

# Treatment labels (as strings)
treat <- c(
  "000", "110", "101", "011",
  "100", "010", "001", "111",
  "000", "110", "001", "111",
  "100", "010", "101", "011",
  "001", "100", "011", "110",
  "000", "101", "010", "111",
  "100", "000", "011", "111",
  "010", "110", "001", "101"
)

block <- factor(rep(1:8, each = 4))

############################
# SUM OF SQUARES VIA CONTRASTS
############################

# function to compute contrast signs
signfun <- function(t, effect) {
  a <- ifelse(substr(t, 1, 1) == "1", 1, -1)
  b <- ifelse(substr(t, 2, 2) == "1", 1, -1)
  c <- ifelse(substr(t, 3, 3) == "1", 1, -1)
  if (effect == "A") {
    return(a)
  }
  if (effect == "B") {
    return(b)
  }
  if (effect == "C") {
    return(c)
  }
  if (effect == "AB") {
    return(a * b)
  }
  if (effect == "AC") {
    return(a * c)
  }
  if (effect == "BC") {
    return(b * c)
  }
  if (effect == "ABC") {
    return(a * b * c)
  }
}

effects <- c("A", "B", "C", "AB", "AC", "BC", "ABC")

# compute treatment totals
Tt <- tapply(y, treat, sum)

# compute contrasts
contrasts <- sapply(effects, function(eff) {
  sum(signfun(names(Tt), eff) * Tt)
})

# SS for effects
SS <- contrasts^2 / 32

############################
# BLOCK SS AND TOTAL SS
############################

# block totals
Bt <- tapply(y, block, sum)

SS_block <- sum(Bt^2 / 4) - (sum(y)^2) / 32
SS_total <- sum(y^2) - (sum(y)^2) / 32
SS_treatment <- sum(SS)
SS_error <- SS_total - SS_block - SS_treatment

MS_error <- SS_error / 17

############################
# OUTPUT ANOVA TABLE
############################

options(scipen = 999)

ANOVA <- data.frame(
  Source = c("Blocks", effects, "Error", "Total"),
  df = c(7, rep(1, 7), 17, 31),
  SS = c(SS_block, SS, SS_error, SS_total),
  MS = c(SS_block / 7, SS, SS_error / 17, NA),
  F = c((SS_block / 7) / MS_error, SS / MS_error, NA, NA)
)

print(ANOVA)
