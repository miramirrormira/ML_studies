# Chapter 16: Recommender Systems

## What is recommender systems?
The **major goal** of recommender systems is to help users discover relevant items such as movies to watch, text to reach or products to buy, os as to create a delightful user experience.
Recommender systems are replacements of search engines by reducing the efforts in proactive searches and surprising users with offers they never searched for.

**Applications:**
- online shopping
- music/movie services
- mobile application stores
- online advertising

**Common model objectives:**
- predict the rating a user might give to a prospective item
- generate a recommendation list of items
- predict the click-through rate from abundant features
- cold-start recommendation, recommending for new users and recommending new items to existing users

## fundamental concepts
### Collaborative Filtering (CF)
"people collaborate to help one another perform the filtering process in order to handle the large amounts of email and messages posted to newsgroups." -- Goldberg et al., 1992

In a broad sense, it is the process of filtering for information or patterns using techniques involving collaboration among multiple users, agents, and data sources.

CF techniques:
- memory-based CF
  - nearest neighbor-based CF: user-based CF and item-based CF
  - limitations: sparse and large-scale data
- model-base CF
  - latent factor models: matrix factorization
  - more popular with its better capability in dealing with sparsity and scalability
  - can be extended with neural networks, leading to more flexible and scalable models
- hybird

In general, CF only uses the **user-item interaction data** to make predictions and recommendations. 
Besides CF, **content-based** and **context-based** recommender systems are also useful in incorporating the content descriptions of items/users and contextual signals such as timestamps and locations. 

### Explicit Feedback and Implicit Feedback
Explicit Feedback
- less noise
- not always available, e.g. some users are reluctant to rate a movie
  
Implicit Feedback
- noisy, e.g. a user watched a movie does not necessarily indicate a positive view of that movie
- more available, e.g. user clicks, mouse movement, etc..

## classic models

### Matrix Factorization Model
**Input data:** 
- a user-item interaction matrix of dimension *m* X *n*. 
- m is the number of users
- n is the number of items
- the values of the matrix could be ratings given by the user for an item

for example:
|        | movie A | movie B | ... | 
| ------ | ------- | ------- | - |
| user 1 | 3       |4        ||
| user 2 | 5       |2        ||
| ...    | ...     |...      ||


**Model Description**
We factor this **m** X **n** interaction matrix into two matrices, called **P** and **Q**. Matrix **P** (user latent matrix) is of dimension **m** X **k**, and Matrix **Q** (item latent matrix) is of dimension **k** X **n**. **k** is the latent factor size.

The **i**-th column (**k** X 1) in matrix **Q** represents a list of characteristics the **i**-th movie possesses, e.g. drama, violence, etc. There are **k** such characteristics. The value measures the degree of the characteristics possessed by the **i**-th movie.

The **i**-th row (1 X **k**) in matrix **P** represents a user's preference towards the **k** characteristics.

The **k** latent factors can be obvious characterisitcs like drama or action, or it can be completely uninterpretable.

So the predicted interaction matrix is modeled as:
**R**~predicted~ = **P** * **Q^T^** 


**Regularization**
User/Item biase: users rate movies differently, some user tend to give high ratings and others give low rating. Some movies tend to get high ratings due to a famous star, etc.

So we add two biase terms to the model:
**R~ui~** ~predicted~ = **P~u~** * **Q~i~^T^** + **b~u~** + **b~i~**

**Loss function**
(**R**~observed~ - **R**~predicted~)^2^ + lamda * (**||P||^2^** + **||Q||^2^** + **b~u~^2^** + **b~i~^2^**)
Lamda is the regularization rate.
We are penalizating the maginitude of the parameters


**Model flaw**
Matrix Factorization is essentially a linear model. It has its limitations for describing nonlinear relationships, and will fail at capturing intricate features.

### [AutoRec](https://www2015.thewebconf.org/documents/proceedings/companion/p111.pdf)

[Autoencoder](https://towardsdatascience.com/auto-encoder-what-is-it-and-what-is-it-used-for-part-1-3e5c6f017726) 

## recent advances with deep learning in the field of recommender systems


## Datasets
[The MovieLens Dataset ](https://grouplens.org/datasets/movielens/)


## Further Readings
[First version of matrix factorization](https://sifter.org/~simon/journal/20061211.html)
[Netflix 1million USD Contest winner](https://www.asc.ohio-state.edu/statistics/statgen/joul_aut2009/BigChaos.pdf)
  - BellKor
  - Pragmatic Theory
  - BigChaos