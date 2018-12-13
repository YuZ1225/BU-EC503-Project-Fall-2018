# Different Collaborative Filtering Algorithms in Recommendation System

## Dataset 
1. Original Dataset
We chose to use the book recommender data from kaggle. We got a huge data set which contains lots of information. There are $10k books and $53424$ active users in total. However, we only have less than one million rating data, which means that our data has a lot of missing and the data matrix is more than 99% sparse.

2. Extract Small Dataset
Because the sparseness of the original matrix is too high, we extracted a matrix of size 48*35 with sparsity of 31.07%. At the same time, we have increased its sparsity by 35% to 80 % each time by 5%. So we have a total of 10 small data sets with different sparsity levels. These 10 small data sets are almost identical to the distribution of the original data set. 
## Memory-based CF
1.Pearson coefficient
2.Cosine Similarity
## Model-based CF
1.Naive Bayesian
2.PMF

## Reference
P.Spachtholz Book recommender:Collaborative filtering,shiny:https://www.kaggle.com/ph
