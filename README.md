# Different Collaborative Filtering Algorithms in Recommendation System

## Dataset 
1. Original Dataset
We chose to use the book recommender data from kaggle. We got a huge data set which contains lots of information. There are 10k books and 53424 active users in total. However, we only have less than one million rating data, which means that our data has a lot of missing and the data matrix is more than 99% sparse.

2. Extract Small Dataset
Because the sparseness of the original matrix is too high, we extracted a matrix of size 48*35 with sparsity of 31.07%. At the same time, we have increased its sparsity by 35% to 80 % each time by 5%. So we have a total of 10 small data sets with different sparsity levels. These 10 small data sets are almost identical to the distribution of the original data set. The extraction process for small data sets can be found in the XXXX folder. The file name of the extraction result is XXXX.

## Memory-based CF
First we built a matrix of user-items and added all the missing data to 0. Then we selected those who read more than 7 books and randomly selected one of them from our books as our predictions and test sets. Next, a memory-based algorithm is used to find the most similar three users by calculating the similarity between users using a user-based approach. We take the average and round off to get our prediction.

1.Pearson coefficient
2.Cosine Similarity

<img src="http://chart.googleapis.com/chart?cht=tx&chl=$$cos(A,B) = \frac{A \cdot B}{\norm{A}*\norm{B}}=\frac{\sum_{i=1}^{n}A_{i} * B_{i}}{\sqrt{\sum_{i=1}^{n}A_{i}^{2} * \sqrt{\sum_{i=1}^{n}B_{i}^{2}}}}$$" style="border:none;">
## Model-based CF
1.Naive Bayesian
2.PMF

## Reference
1.P.Spachtholz Book recommender:Collaborative filtering,shiny:https://www.kaggle.com/ph \n
2.Wikipedia-contributors.Cosine similarity in wikipediahttps://en.wikipedia.org/w/index.php?title=cosinesimilarity&oldid=872928175,2018, December1
