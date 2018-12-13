# Different Collaborative Filtering Algorithms in Recommendation System

## Dataset 
1. Original Dataset
We chose to use the book recommender data from kaggle. We got a huge data set which contains lots of information. There are 10k books and 53424 active users in total. However, we only have less than one million rating data, which means that our data has a lot of missing and the data matrix is more than 99% sparse.

2. Extract Small Dataset
Because the sparseness of the original matrix is too high, we extracted a matrix of size 48*35 with sparsity of 31.07%. At the same time, we have increased its sparsity by 35% to 80 % each time by 5%. So we have a total of 10 small data sets with different sparsity levels. These 10 small data sets are almost identical to the distribution of the original data set. 

* `process_entire_dataset.m` will do the processing over the entire dataset and generate the matrix and labels that our models need. The data is also saved in `data_entire.mat`
* `process_small_dataset.m` need to be run after running `process_entire_dataset.m`, which will generate 10 small datasets with sparsity from 35% to 80%, along with the label that need to be predicted. The data is also saved in `data.mat`
* `create_typical_dataset.m` is used to generate 10 by 10 typical dataset wilth 2 latent features, along with the label to be predicted. The data is also saved in `data_typical.mat`
* Other functions are used to show the results with the data gathered from our different algorithms.
* Include lot of result data for the convenience of repeating use.
* Include lot of figures of our result.

## Memory-based CF
For the original matric, first we built a matrix of user-items and added all the missing data to 0. Then we selected those who read more than 7 books and randomly selected one of them from our books as our predictions and test sets. Next, a memory-based algorithm is used to find the most similar three users who read this book by calculating the similarity between users using a user-based approach. We take the average and round off to get our prediction.
We use two ways to calculate the similarity between predicted users and other users：

1.Pearson coefficient</br>

In this project, we use Pearson correlation coefficient to calculate the similarity between user_i and user_j . The correlation is:  

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
The realted files are in the `cos similarity` folder:
 * `large_version.m`: Executing all the original data sets
 * `small_version1.m`: Executing the 10 extracting small datasets.
 * `LargecosAns.mat`: All parameters and result for whole data sets
 * `cosAns.mat`: The Result of 10 small data sets
 

## Model-based CF
1.Naive Bayesian</br>
* `NB_old.m` is abandoned. It is a script to run the entire dataset.
* `NB.m` is a function, whch takes  two inputs. The first input is the rating matrix withous the rating that need to be predicted. The second input is a rating_to_pred matrix with three columns: the first column for user, the scond column for item(book in our dataset) and the third column for true ratings. The output is saved in a struct NB_output.



2.PMF</br>
* `PMF.m` is also a function. Run it as: [PMF_output]= PMF(data_matrix, rating_to_pred, iteration, d, weight_missing, mu, lambda, rm). The data_matrix and the rating_to_pred is the same as `NB.m`: The first input is the rating matrix withous the rating that need to be predicted. The second input is a rating_to_pred matrix with three columns: the first column for user, the scond column for item(book in our dataset) and the third column for true ratings. The output is saved in a struct NB_output. The rest parameters are iteration number, dimension of latent features, weight fot missing data, learning rate \mu, regularization parameter \lambda and the rating offset for missing data. All of them are scalars. Weight fot missing data and the rating offset for missing data have not been verified.
* `pmf_optimize` is used to optimize the parameter in PMF model and helps generate some visualized figures.

## Evaluating Metric
1.MAE</br>
<a href="https://www.codecogs.com/eqnedit.php?latex=MAE=\frac{\sum_N{p_{ij}&space;-&space;r_{ij}}}{N}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?MAE=\frac{\sum_N{p_{ij}&space;-&space;r_{ij}}}{N}" title="MAE=\frac{\sum_N{p_{ij} - r_{ij}}}{N}" /></a></br>
2. RMSE/RMSD</br>
<a href="https://www.codecogs.com/eqnedit.php?latex=RMSE=\sqrt{MAE}={\sqrt&space;\frac{\sum_N{p_{ij}&space;-&space;r_{ij}}}{N}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?RMSE=\sqrt{MAE}={\sqrt&space;\frac{\sum_N{p_{ij}&space;-&space;r_{ij}}}{N}}" title="RMSE=\sqrt{MAE}={\sqrt \frac{\sum_N{p_{ij} - r_{ij}}}{N}}" /></a></br>

## Reference
[1] P. Spachtholz. Book recommender: Collaborative filtering, shiny : https://www.kaggle.com/philippsp/bookrecommender-collaborative-filtering-shiny/data.</br>
[2] Wikipedia-contributors.Cosine similarity in wikipedia: https://en.wikipedia.org/w/index.php?title=cosinesimilarity&oldid=872928175. 2018, December1 </br>
[3] J. S. Breese, D. Heckerman, and C. Kadie. Empirical analysis of predictive algorithms for collaborative filtering. In Proceedings of the Fourteenth Conference on Uncertainty in Artificial Intelligence, UAI’98, pages 43–52, San Francisco, CA, USA, 1998. Morgan Kaufmann Publishers Inc.</br>
[4] L. Cao, Y. Wang, and Y. Zhao. Github link: https://github.com/yuz1225/bu-ec503-project-fall-2018.git.</br>
[5] J. Davidson, B. Liebald, J. Liu, P. Nandy, T. Van Vleet, U. Gargi, S. Gupta, Y. He, M. Lambert, B. Livingston, and D. Sampath. The youtube video recommendation system. In Proceedings of the Fourth ACM Conference on Recommender Systems, RecSys ’10, pages 293–296, New York, NY, USA, 2010. ACM.</br>
[6] R. Salakhutdinov and A. Mnih. Probabilistic matrix factorization. In Proceedings of the 20th International Conference on Neural Information Processing Systems, NIPS’07, pages 1257–1264, USA, 2007. Curran Associates Inc.</br>
[7] B. Sarwar, G. Karypis, J. Konstan, and J. Riedl. Item-based collaborative filtering recommendation algorithms. In Proceedings of the 10th International Conference on World Wide Web, WWW’01, pages 285–295, New York, NY, USA, 2001. ACM.</br>
[8] J. Schafer, D. Frankowski, J. Herlocker, and S. Sen. Collaborative filtering recommender systems. In Brusilovsky P., Kobsa A., Nejdl W. (eds) The Adaptive Web, Lecture Notes in Computer Science, vol 4321, Berlin, Heidelberg, 2007. Springer.</br>
[9] X. Su and T. M. Khoshgoftaar. A survey of collaborative filtering techniques. In Advances in Artificial Intelligence, Vol. 2009, Article ID 421425, 2009.</br>




