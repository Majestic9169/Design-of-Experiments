import numpy as np
import pandas as pd
from scipy.stats import bartlett, levene, f_oneway, ttest_ind
import statsmodels.api as sm
import statsmodels.formula.api as smf
from statsmodels.stats.multicomp import pairwise_tukeyhsd, MultiComparison
from statsmodels.stats.multicomp import MultiComparison
from statsmodels.stats.weightstats import DescrStatsW

# Input data
data = {
    'brand': ['A']*5 + ['B']*5 + ['C']*5 + ['D']*5,
    'lifetime': [
         42, 30, 39, 28, 29,   # A
         28, 31, 31, 32, 27,   # B
         24, 36, 28, 28, 33,   # C
         20, 32, 38, 28, 25    # D
    ]
}
df = pd.DataFrame(data)

# Bartlett's test
print("\n=== Bartlett's Test ===")
brands = [df[df.brand == br]['lifetime'] for br in df.brand.unique()]
bart_result = bartlett(*brands)
print(f"Statistic: {bart_result.statistic:.3f}, p-value: {bart_result.pvalue:.3f}")

# Levene's test
print("\n=== Levene's Test ===")
lev_result = levene(*brands)
print(f"Statistic: {lev_result.statistic:.3f}, p-value: {lev_result.pvalue:.3f}")

# Overall mean & treatment effects
print("\n=== Overall Mean ===")
overall_mean = df['lifetime'].mean()
print(f"Overall mean: {overall_mean:.2f}")

print("\n=== Brand Means & Treatment Effects ===")
brand_means = df.groupby('brand')['lifetime'].mean().reset_index()
brand_means['treatment_effect'] = brand_means['lifetime'] - overall_mean
print(brand_means)

# One-way ANOVA
print("\n=== ANOVA Results ===")
anova = f_oneway(*brands)
print(f"F-statistic: {anova.statistic:.3f}, p-value: {anova.pvalue:.3f}")
# Also, show statsmodels enhanced table:
model = smf.ols('lifetime ~ brand', data=df).fit()
anova_table = sm.stats.anova_lm(model, typ=2)
print(anova_table)

# Multiple Comparisons: Tukey's HSD
print("\n=== Tukey's HSD ===")
multicomp = MultiComparison(df['lifetime'], df['brand'])
tukey_result = multicomp.tukeyhsd()
print(tukey_result.summary())

# Fisher's LSD (pairwise t-tests, unadjusted)
print("\n=== Fisher's LSD ===")
from itertools import combinations
for b1, b2 in combinations(df.brand.unique(), 2):
    stat, p = ttest_ind(df[df.brand == b1]['lifetime'], df[df.brand == b2]['lifetime'])
    print(f"{b1} vs {b2} p-value: {p:.3f}")

# Simultaneous Confidence Intervals (Tukey)
print("\n=== Tukey Confidence Intervals ===")
for res in tukey_result._results_table.data[1:]:
    print(f"Diff: {res[2]:.2f} CI: ({res[4]:.2f}, {res[5]:.2f})")
