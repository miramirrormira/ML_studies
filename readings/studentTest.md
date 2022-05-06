# Student's Test (T-Test)
The t test tells you how significant the differences between group means are. 



## Assumptions
- the data follows a normal distribution. If the distribution is skewed, the p-value will be inaccurate. T-Test can 
- the sample size is between 20-30
- the sample size between the two groups are similar
- the two sample have similar variance
- the measure 

### how to overcome violations of these assumptions
- Use **Monte Carlo Simulations** to understand how t-tests can hold up under particular conditions
- **Mann-Whitney U test** can do the same job as t-test, but it can work with non-normal distributions and ordered-level data. But these tests are also less powerful.


## T Score
The t score is a ratio between the variance between two groups and the variance within the groups.
```
t-score = signal / noise
```
- signal: the absolute difference of the two means
- noise: the variance of within the groups

p-value: the probability that the difference of the samples is produced by chance (randomly). 

For independent-samples t-test
$$
t-score = \frac{|m1 - m2|}{\sqrt{\frac{s~1~^2}{n1} + \frac{s2^2}{n2}}}
$$

- m1 is the mean of group 1, m2 is the mean of group 2
- s1 is the standard deviation of group 1, s2 is the standard deviation of group 2
- n1 is the sample size of group 1, n2 is the sample size of group 2

## Types of student's test
1. Independent-samples t-test (aka between-samples/unpaired-samples t-test): compare the means of two different groups
2. Paired-samples t-test: compare the means of one group twice, at different times. Example: testing blood samples before and after drinking
3. One sample t-test: compares the mean of one group against an arbitrary mean value.