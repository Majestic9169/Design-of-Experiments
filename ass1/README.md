# Single Factor - One way ANOVA - Completely Randomised Block Design

$$
Y_{ij} = \mu + \tau_i + \varepsilon_{ij}
$$

- $\tau_i$ is treatment effect

1. Before ANOVA: Test if variances can be considered equal
- Bartlett's Test and Levene's Test

2. Perform One-Way ANOVA[^3]
- One way ANOVA is pretty easy, practice a little.

3. Post-hoc analysis
- if means are significantly different then perform post hoc analysis to identify which ones are different
- We have Fischer's LSD -> t-distribution
- Duncan's MRT[^1] and Tukey's HSD -> studentized range distribution
- Scheffe's Test[^2] -> F-distribution (has a weird critical value calc)

4. Confidence intervals
- construct tukey's simultaneous confidence intervals
- these follow pretty dircetly from tukey's HSD

[^1]: https://soniavieira.blogspot.com/2025/08/an-analysis-of-variance-anova-indicates.html?m=1
[^2]: https://stattrek.com/anova/follow-up-tests/scheffe
[^3]: https://www.youtube.com/watch?v=XuPkDGjq_-8&list=PLIfM0lEfH5PVUhY_etTBhmm31m7r8c6Ea&index=13
