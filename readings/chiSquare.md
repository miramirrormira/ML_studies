# Chi Square

A Chi Square is a statistic that checks for patterns or relationships in categorical variables.

## Two Types of Chi Square Test

### Chi-Square Test for Independence
The Chi-Square Test for Independence evaluates the relationship between two variables. It's non-parametric test.

EXAMPLE: Gender and Favorite Color 

Observed values:
|                      |     blue    |     green   |    pink     |    total    |
|----------------------|-------------|-------------|-------------|-------------|
|          boys        |     100     |     150     |     50      |    300      |
|          girls       |     20      |     30      |     130     |    200      |
|          total       |     120     |     180     |     180     |    500      |

**Null hypothese h0**: For the population of elementary school students, gender and favorite color are not related\
**Alternative hypothese h1**: For the population of elementary school students, gender and favorite color are related

Expected values: 
|                      |     blue    |     green   |    pink     |    total    |
|----------------------|-------------|-------------|-------------|-------------|
|          boys        |     72      |     108     |     108     |    300      |
|          girls       |     48      |     72      |     72      |    200      |
|          total       |     120     |     180     |     180     |    500      |

$$
Chi-square = \sum \frac{(Observed - Expected)^2}{Expected^2}
$$


DF(degree of freedom): (rows - 1) * (columns - 1), which in this case equals to 6\
After plugging the values, we get Chi-squared value 276.\
Pick the alpha level 0.05\
Check the Chi-square distribution table based on the alpha level and the degrees of freedom. If our chi squared scores is higher, then we can reject the null hypothesis.\


### Goodness of Fit
In an art class of 75 students, 11 are left handed. Does this class fit the prevailing theory that 12% of people are left handed?
|              |Observed|Expected|
|--------------|--------|--------|
| Left handed  |   11   |   9    |
| Right handed |   64   |   66   |

Null hypothesis: p = 0.12 \
Alternative hypothesis: p != 0.12

$$
Chi-Squared = \frac{(11-9)^2}{9} + \frac{(64-66)^2}{66} = 0.505
$$

DF(degree of freedom) = 1\
At alpha level of 0.05, the reject threshold is 3.841. Since our chi-squared value is 0.505, we cannot reject the null hypothesis.


## Limitations
1. more robust than parametric tests, e.g. t-test or ANOVAs. 
2. don't require normal distributions
3. should have at lease one value in each cell of the contingency table
4. at least 80% of values should be five or more
5. a significant Chi-square doesn't tell you which levels of your variables are driving the effect.
6. the result can only be generalized to a similar population
7. all data should be independent

### overcoming limitation
1. if you have empty cells or too many low count cells, consider combining or dropping certain category levels. Or collect more data
2. if the chi-square table to too complex, consider decompose the total chi-squared value into its component parts


## Chi-squared distribution
Every frequency count at each sub-category level in the contingency table has a **Binomial Distribution** 
$$
P(x|n,p) = \frac{n!}{x!(n-x)!}*p^x*(1-p)^{n-x}
$$
- n is number of trials, 
- p is the probability of success on a single trial, 
- x is the number of success

Based on the central-limit-theorem, when n is sufficiently large, variable z has a standard normal distribution:
$$
z = \frac{x - np}{np(1-p)}, N(0,1)
$$

Chi-squared distribution:
If Z1, Z2, ..., Zk are independent, and have a standard normal distribution, then the sum of their squares
$$
Q = \sum_{k=1}^{n}Z_i, X^2(k)
$$
is distributed according to the chi-squared distribution with k degrees of freedom.

So, the square of the variable z has a chi-squared distribution with a degrees of freedom 1
$$
z^2 = (\frac{x - np}{np(1-p)})^2, X^2(1)
$$ 

$$
z^2 = (\frac{x - np}{np(1-p)})^2 = \frac{(x-np)^2}{np} + \frac{(n - x - n(1-p))^2}{n(1-p)} = \sum \frac{(Observed - Expected)^2}{Expected^2}
$$

## Resources
[Chi-Square](https://www.youtube.com/watch?v=ZjdBM7NO7bY)\
[Chi-Square test for independence](https://www.youtube.com/watch?v=LE3AIyY_cn8)\
[Chi-Square test for independence](https://www.youtube.com/watch?v=NTHA9Qa81R8)\
