# Different Collaborative Filtering Algorithms in Recommendation System

## Dataset 
1. Original Dataset
We chose to use the book recommender data from kaggle. We got a huge data set which contains lots of information. There are 10k books and 53424 active users in total. However, we only have less than one million rating data, which means that our data has a lot of missing and the data matrix is more than 99% sparse.

2. Extract Small Dataset
Because the sparseness of the original matrix is too high, we extracted a matrix of size 48*35 with sparsity of 31.07%. At the same time, we have increased its sparsity by 35% to 80 % each time by 5%. So we have a total of 10 small data sets with different sparsity levels. These 10 small data sets are almost identical to the distribution of the original data set. The extraction process for small data sets can be found in the XXXX folder. The file name of the extraction result is XXXX.

## Memory-based CF
For the original matric, first we built a matrix of user-items and added all the missing data to 0. Then we selected those who read more than 7 books and randomly selected one of them from our books as our predictions and test sets. Next, a memory-based algorithm is used to find the most similar three users who read this book by calculating the similarity between users using a user-based approach. We take the average and round off to get our prediction.
We use two ways to calculate the similarity between predicted users and other users：

1.Pearson coefficient</br>
In this project, we use Pearson correlation \cite{Breese:1998:EAP:2074094.2074100} coefficient to calculate the similarity between user_i and user_j . The correlation is:  
<a href="https://www.codecogs.com/eqnedit.php?latex=w(i,j)&space;=&space;\frac{\sum_n(v_{i,n}&space;-&space;\overline{v}_n)(v_{j,n}&space;-&space;\overline{v}_n)}{\sqrt{\sum_n(v_{i,n}&space;-&space;\overline{v}_i)^2&space;\sum_j(v_{i,j}&space;-&space;\overline{v}_i)^2}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?w(i,j)&space;=&space;\frac{\sum_n(v_{i,n}&space;-&space;\overline{v}_n)(v_{j,n}&space;-&space;\overline{v}_n)}{\sqrt{\sum_n(v_{i,n}&space;-&space;\overline{v}_i)^2&space;\sum_j(v_{i,j}&space;-&space;\overline{v}_i)^2}}" title="w(i,j) = \frac{\sum_n(v_{i,n} - \overline{v}_n)(v_{j,n} - \overline{v}_n)}{\sqrt{\sum_n(v_{i,n} - \overline{v}_i)^2 \sum_j(v_{i,j} - \overline{v}_i)^2}}" /></a></br>  
The realted files are in the `Pearson` folder:
 * `Pearson_all_data.m`: Model trained by the whole dataset.
 * `pearson.m`: A function to evaluate the accuracy of the model using Pearson correlation.
 * `pearson_test_data.m`: Model trained by small part of data of the whole dataset.
 * `smalldata_test.m`: Calculating accuracy of the data matrix which is processed by PMF.
 
2.Cosine Similarity</br>

<a href="https://www.codecogs.com/eqnedit.php?latex=cos(A,B)=\frac{A\cdot&space;B}{\left&space;\|&space;A&space;\right&space;\|&space;*\left&space;\|&space;B&space;\right&space;\|&space;}=\frac{\sum_{i=1}^{n}A_{i}&space;*&space;B_{i}}{\sqrt{\sum_{i=1}^{n}A_{i}^{2}&space;*&space;\sqrt{\sum_{i=1}^{n}B_{i}^{2}}}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?cos(A,B)=\frac{A\cdot&space;B}{\left&space;\|&space;A&space;\right&space;\|&space;*\left&space;\|&space;B&space;\right&space;\|&space;}=\frac{\sum_{i=1}^{n}A_{i}&space;*&space;B_{i}}{\sqrt{\sum_{i=1}^{n}A_{i}^{2}&space;*&space;\sqrt{\sum_{i=1}^{n}B_{i}^{2}}}}" title="cos(A,B)=\frac{A\cdot B}{\left \| A \right \| *\left \| B \right \| }=\frac{\sum_{i=1}^{n}A_{i} * B_{i}}{\sqrt{\sum_{i=1}^{n}A_{i}^{2} * \sqrt{\sum_{i=1}^{n}B_{i}^{2}}}}" /></a></br>
Where A and B represent two users, respectively. Ai and Bi represent the components of the vector A and B, respectively. </br>
When processing small data, the entire data set has only 48 books. When the result is predicted, if the user reads less than two books, then directly select the most similar users. If the user has read more than 4 books, then the two closest users are averaged. </br>
In the folder named "cos smilarity", the file named "large_version.m" is the file that executes all the original data sets. The file named "small_version1.m" execute the 10 extracting small datasets.  "LargecosAns.mat" and "cosAns.mat" correspond to the MAE and MSE results of the two experiments, respectively.
## Model-based CF
1.Naive Bayesian</br>
2.PMF</br>
## Evaluating Metric
1.MAE</br>
<a href="https://www.codecogs.com/eqnedit.php?latex=MAE=\frac{\sum_N{p_{ij}&space;-&space;r_{ij}}}{N}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?MAE=\frac{\sum_N{p_{ij}&space;-&space;r_{ij}}}{N}" title="MAE=\frac{\sum_N{p_{ij} - r_{ij}}}{N}" /></a></br>
2. RMSE/RMSD</br>
<a href="https://www.codecogs.com/eqnedit.php?latex=RMSE=\sqrt{MAE}={\sqrt&space;\frac{\sum_N{p_{ij}&space;-&space;r_{ij}}}{N}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?RMSE=\sqrt{MAE}={\sqrt&space;\frac{\sum_N{p_{ij}&space;-&space;r_{ij}}}{N}}" title="RMSE=\sqrt{MAE}={\sqrt \frac{\sum_N{p_{ij} - r_{ij}}}{N}}" /></a></br>

## Reference
1.P.Spachtholz Book recommender:Collaborative filtering,shiny:https://www.kaggle.com/ph </br>
2.Wikipedia-contributors.Cosine similarity in wikipediahttps://en.wikipedia.org/w/index.php?title=cosinesimilarity&oldid=872928175,2018, December1
