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
    'technique': ['T1']*6 + ['T2']*7 + ['T3']*6 + ['T4']*4,
    'scores': [
         65, 87, 73, 79, 81, 69,        # T1
         75, 69, 83, 81, 72, 79, 90,    # T2
         59, 78, 67, 62, 83, 76,        # T3
         94, 89, 80, 88                 # T4
    ]
}
df = pd.DataFrame(data)

# Bartlett's test
print("\n=== Bartlett's Test ===")
techniques = [df[df.technique == br]['scores'] for br in df.technique.unique()]
bart_result = bartlett(*techniques)
print(f"Statistic: {bart_result.statistic:.3f}, p-value: {bart_result.pvalue:.3f}")

# Levene's test
print("\n=== Levene's Test ===")
lev_result = levene(*techniques)
print(f"Statistic: {lev_result.statistic:.3f}, p-value: {lev_result.pvalue:.3f}")

# Overall mean & treatment effects
print("\n=== Overall Mean ===")
overall_mean = df['scores'].mean()
print(f"Overall mean: {overall_mean:.2f}")

print("\n=== technique Means & Treatment Effects ===")
technique_means = df.groupby('technique')['scores'].mean().reset_index()
technique_means['treatment_effect'] = technique_means['scores'] - overall_mean
print(technique_means)

# One-way ANOVA
print("\n=== ANOVA Results ===")
anova = f_oneway(*techniques)
print(f"F-statistic: {anova.statistic:.3f}, p-value: {anova.pvalue:.3f}")
# Also, show statsmodels enhanced table:
model = smf.ols('scores ~ technique', data=df).fit()
anova_table = sm.stats.anova_lm(model, typ=2)
print(anova_table)

# Multiple Comparisons: Tukey's HSD
print("\n=== Tukey's HSD ===")
multicomp = MultiComparison(df['scores'], df['technique'])
tukey_result = multicomp.tukeyhsd()
print(tukey_result.summary())

# Fisher's LSD (pairwise t-tests, unadjusted)
print("\n=== Fisher's LSD ===")
from itertools import combinations
for b1, b2 in combinations(df.technique.unique(), 2):
    stat, p = ttest_ind(df[df.technique == b1]['scores'], df[df.technique == b2]['scores'])
    print(f"{b1} vs {b2} p-value: {p:.3f}")

# Simultaneous Confidence Intervals (Tukey)
print("\n=== Tukey Confidence Intervals ===")
for res in tukey_result._results_table.data[1:]:
    print(f"Diff: {res[2]:.2f} CI: ({res[4]:.2f}, {res[5]:.2f})")
