%% run PMF over entire dataset

load('data_entire.mat')

iteration = 100;
weight_missing = 0;
mu = 0.003;
lambda = 0.01;
rm = 0;
d = 3;
[PMF_output_d3] = PMF(data_matrix_entire, rating_to_pred_entire, iteration, d, weight_missing, mu, lambda, rm);
d = 10;
[PMF_output_d10] = PMF(data_matrix_entire, rating_to_pred_entire, iteration, d, weight_missing, mu, lambda, rm);


% save PMF_entire_d3.mat PMF_output_d3
% save PMF_entire_d10.mat PMF_output_d10