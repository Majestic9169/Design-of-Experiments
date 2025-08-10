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
    'coating': ['C1']*4 + ['C2']*4 + ['C3']*4 + ['C4']*4 + ['C5']*4,
    'conductivity': [
        143, 141, 150, 146, # C1
        152, 149, 137, 143, # C2
        134, 133, 132, 127, # C3
        129, 127, 132, 129, # C4
        147, 148, 144, 142, # C5
    ]
}
df = pd.DataFrame(data)

# Bartlett's test
print("\n=== Bartlett's Test ===")
coatings = [df[df.coating == br]['conductivity'] for br in df.coating.unique()]
bart_result = bartlett(*coatings)
print(f"Statistic: {bart_result.statistic:.3f}, p-value: {bart_result.pvalue:.3f}")

# Levene's test
print("\n=== Levene's Test ===")
lev_result = levene(*coatings)
print(f"Statistic: {lev_result.statistic:.3f}, p-value: {lev_result.pvalue:.3f}")

# Overall mean & treatment effects
print("\n=== Overall Mean ===")
overall_mean = df['conductivity'].mean()
print(f"Overall mean: {overall_mean:.2f}")

print("\n=== coating Means & Treatment Effects ===")
coating_means = df.groupby('coating')['conductivity'].mean().reset_index()
coating_means['treatment_effect'] = coating_means['conductivity'] - overall_mean
print(coating_means)

# One-way ANOVA
print("\n=== ANOVA Results ===")
anova = f_oneway(*coatings)
print(f"F-statistic: {anova.statistic:.3f}, p-value: {anova.pvalue:.3f}")
# Also, show statsmodels enhanced table:
model = smf.ols('conductivity ~ coating', data=df).fit()
anova_table = sm.stats.anova_lm(model, typ=2)
print(anova_table)

# Multiple Comparisons: Tukey's HSD
print("\n=== Tukey's HSD ===")
multicomp = MultiComparison(df['conductivity'], df['coating'])
tukey_result = multicomp.tukeyhsd()
print(tukey_result.summary())

# Fisher's LSD (pairwise t-tests, unadjusted)
print("\n=== Fisher's LSD ===")
from itertools import combinations
for b1, b2 in combinations(df.coating.unique(), 2):
    stat, p = ttest_ind(df[df.coating == b1]['conductivity'], df[df.coating == b2]['conductivity'])
    print(f"{b1} vs {b2} p-value: {p:.3f}")

# Simultaneous Confidence Intervals (Tukey)
print("\n=== Tukey Confidence Intervals ===")
for res in tukey_result._results_table.data[1:]:
    print(f"Diff: {res[2]:.2f} CI: ({res[4]:.2f}, {res[5]:.2f})")
