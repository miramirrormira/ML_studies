## Entropy

Entropy is the expected **surprise** of a probability distribution.

### Probability and Surprise:
There is an **inverse association** between probability and surprise:
The higher the probability, the lower the surprise.
$$
Surprise = log(1/p) = -log(p)
$$
- p is probability
- when calculating surprise for 2 outputs, then it's customary to use the log base 2

Why do we use log(1/p) instead of just 1/p? 

when p = 1, log(1/p) = 0, which means the surprise is 0. This makes sense intuitively, because when the probability of an event happens is 1, then there should be no surprise when it happens. 

### How to calculate Entropy:
$$
Entropy = \sum p(x) * log(1/p(x)) = \sum -p(x)*log(p(x))
$$


## Cross-Entropy (Aka logarithmic loss, log loss, or logistic loss)

$$
Loss~cross entropy~ = - \sum_{i=1}^{n} O~i~ * log(p~i~)
$$

- Oi is the ith observed label
- pi is the softmax probability of the ith data point

**Example**
Consider the classification model that gave the probability of the 4 classes it was trying to predict: {"dog": 0.7, "cat": 0.1, "fish": 0.05, "horse": 0.15}, the observed label for the 4 classes are {"dog": 1, "cat": 0, "fish": 0, "horse": 0}

$$
Loss~cross entropy~ = - (1 * log(0.7) + 0 * log(0.1) + 0 * log(0.05) + 0 * log(0.15)) = -log(0.7)
$$

The slope of Cross-Entropy loss is high when the softmax probability is close to 0, which will signal the SGD algorithm to take larger steps