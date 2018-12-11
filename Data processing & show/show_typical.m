%% show plot of U and V in typical dataset

load('data_typical')
iteration = 200;
weight_missing = 0;
mu = 0.005;
lambda = 0.01;
rm = 0;
d = 2;

[PMF_output] = PMF(small_data_typical, rating_to_pred, iteration, d, weight_missing, mu, lambda, rm);

figure

tmp_label_U = kmeans(PMF_output.U, 2);
tmp_label_V = kmeans(PMF_output.V, 2);

%     figure
%     subplot(1,2,1)
subplot(1,2,1)
tmp1 = find(tmp_label_U(:, 1) == 1);
tmp2 = find(tmp_label_U(:, 1) == 2);

plot(PMF_output.U(tmp1, 1), PMF_output.U(tmp1, 2),'.', 'MarkerSize', 25)
hold on
plot(PMF_output.U(tmp2, 1), PMF_output.U(tmp2, 2), '.', 'MarkerSize', 25)
hold off
grid on
str = 'U: Item Matrix Data Distribution with Typical Matrix ';
title(str) 

subplot(1,2,2)
tmp1 = find(tmp_label_V(:, 1) == 1);
tmp2 = find(tmp_label_V(:, 1) == 2);

plot(PMF_output.V(tmp1, 1), PMF_output.V(tmp1, 2),'.', 'MarkerSize', 25)
hold on
plot(PMF_output.V(tmp2, 1), PMF_output.V(tmp2, 2),'.', 'MarkerSize', 25)
hold off
grid on
str = 'V: User Matrix Data Distribution with Typical Matrix';
title(str) 



