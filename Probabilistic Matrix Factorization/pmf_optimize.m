%% test and optimize parameter of PMF
% [PMF_output]= PMF(data_matrix, rating_to_pred, iteration, d, weight_missing, mu, lambda, rm)
%         PMF_output.U = U;
%         PMF_output.V = V;
%         PMF_output.MAE_iter = MAE_iter;
%         PMF_output.RMSE_iter = RMSE_iter;
%         PMF_output.MAE_iter_round = MAE_iter_round;
%         PMF_output.RMSE_iter_round = RMSE_iter_round;
%         PMF_output.label_pred = label_pred;
%         PMF_output.label_pred_round = label_pred_round;
%         PMF_output.MAE_baseline = MAE_baseline;
%         PMF_output.RMSE_baseline = RMSE_baseline;
%% optimize d;
load('data.mat')
data_matrix = cellofmatrix{5};
[itm_num, usr_num] = size(data_matrix);

iteration = 100;
weight_missing = 0;
mu = 0.005;
lambda = 0.01;
rm = 0;
d = 20;

tmp_rmse = zeros(d,1);
tmp_rmse_round = zeros(d,1);
tmp_mae = zeros(d,1);
tmp_mae_round = zeros(d,1);
for i = 1:1:d
    [PMF_output] = PMF(data_matrix, rating_to_pred, iteration, i, weight_missing, mu, lambda, rm);
    tmp_rmse(i, 1) = PMF_output.RMSE_iter(iteration);
    tmp_rmse_round(i, 1) = PMF_output.RMSE_iter_round(iteration);
    tmp_mae(i, 1) = PMF_output.MAE_iter(iteration);
    tmp_mae_round(i, 1) = PMF_output.MAE_iter_round(iteration);
end
j = 1:1:d;
y = sin(j) - sin(j) + PMF_output.RMSE_baseline;
figure;
subplot(1,2,1)
% plot(j, tmp_rmse, '*-');
% hold on
plot(j, tmp_rmse_round, '*-');
hold on
% line([1,d], [PMF_output.RMSE_baseline, PMF_output.RMSE_baseline])
plot(j, y)
hold off
legend('pmf', 'baseline')
title('RMSE VS Different d')
xlabel('d')
ylabel('RMSE')

y = sin(j) - sin(j) + PMF_output.MAE_baseline;
subplot(1,2,2)
% plot(j, tmp_mae, '*-');
% hold on
plot(j, tmp_mae_round, '*-');
hold on
% line([1,d], [PMF_output.RMSE_baseline, PMF_output.RMSE_baseline])
plot(j, y)
hold off
legend('pmf', 'baseline')
title('MAE VS Different d')
xlabel('d')
ylabel('MAE')

% no difference...
% choose d = 3, d = 5;

%% optimize mu
d = 3;
figure
j = 1;
for mu = 0.001:0.004:0.013
    subplot(2,2,j);
    j = j + 1;
    data_matrix = cellofmatrix{2};
    [PMF_output] = PMF(data_matrix, rating_to_pred, iteration, d, weight_missing, mu, lambda, rm);
    i = 1:1:iteration;
    plot(i, PMF_output.MAE_iter_round);
    hold on
    plot(i, PMF_output.RMSE_iter_round);
    hold off
    legend('MAE', 'RMSE')
    str=['MAE & RMSE VS Iteration with Learning Rate ',num2str(mu)];
    title(str)
    xlabel('Iteration')
    ylabel('MAE & RMSE')
    
end
% choose mu = 0.005
mu = 0.005;
%% optimize lambda
figure
subplot(1,2,1);
i = 1:1:iteration;
data_matrix = cellofmatrix{5};
for lambda = -0.04:0.01:0.05
    [PMF_output] = PMF(data_matrix, rating_to_pred, iteration, d, weight_missing, mu, lambda, rm);
%     figure
%     plot(i, PMF_output.RMSE_iter);
%     hold on
    plot(i, PMF_output.MAE_iter_round);
    hold on
end
hold off
lambda = -0.04:0.01:0.05;
legend('-0.04','-0.03','-0.02','-0.01','0','0.01','0.02','0.03','0.04','0.05')
str='MAE VS Iteration with Lambda from -0.04 to 0.05';
title(str)
xlabel('Iteration')
ylabel('MAE')

subplot(1,2,2);
for lambda = -0.04:0.01:0.05
    [PMF_output] = PMF(data_matrix, rating_to_pred, iteration, d, weight_missing, mu, lambda, rm);
%     figure
%     plot(i, PMF_output.RMSE_iter);
%     hold on
    plot(i, PMF_output.RMSE_iter_round);
    hold on
end
hold off
lambda = -0.5:0.1:0.5;
legend('-0.04','-0.03','-0.02','-0.01','0','0.01','0.02','0.03','0.04','0.05')
str='RMSE VS Iteration with Lambda from -0.04 to 0.05';
title(str)
xlabel('Iteration')
ylabel('RMSE')


% don't understand how lambda works
% choose lambda = 0.01
lambda = 0.01;
%% cluster using kmeans with k=2 and k=3
d = 3;
mu = 0.005;
j = 1;
for i = 1:9:10  % 3
    tmp = 0.3 + 0.05 * i;
    data_matrix = cellofmatrix{i};
    [PMF_output] = PMF(data_matrix, rating_to_pred, iteration, d, weight_missing, mu, lambda, rm);
    tmp_label_U = kmeans(PMF_output.U, 5);
    tmp_label_V = kmeans(PMF_output.V, 5);
    
%     figure
%     subplot(1,2,1)
    subplot(2,2,j)
    j = j + 1;
    tmp1 = find(tmp_label_U(:, 1) == 1);
    tmp2 = find(tmp_label_U(:, 1) == 2);
    tmp3 = find(tmp_label_U(:, 1) == 3);
    tmp4 = find(tmp_label_U(:, 1) == 4);
    tmp5 = find(tmp_label_U(:, 1) == 5);
    
    plot3(PMF_output.U(tmp1, 1), PMF_output.U(tmp1, 2), PMF_output.U(tmp1, 3),'*')
    hold on
    plot3(PMF_output.U(tmp2, 1), PMF_output.U(tmp2, 2), PMF_output.U(tmp2, 3),'*')
    hold on
    plot3(PMF_output.U(tmp3, 1), PMF_output.U(tmp3, 2), PMF_output.U(tmp3, 3),'*')
    hold on
    plot3(PMF_output.U(tmp4, 1), PMF_output.U(tmp4, 2), PMF_output.U(tmp4, 3),'*')
    hold on
    plot3(PMF_output.U(tmp5, 1), PMF_output.U(tmp5, 2), PMF_output.U(tmp5, 3),'*')
    hold off
    grid on
    str = ['U: Item Matrix Data Distribution with Sparsity ', num2str(tmp)];
    title(str)
    
%     subplot(1,2,2)
    subplot(2,2,j)
    j = j + 1;
    tmp1 = find(tmp_label_V(:, 1) == 1);
    tmp2 = find(tmp_label_V(:, 1) == 2);
    tmp3 = find(tmp_label_V(:, 1) == 3);
    tmp4 = find(tmp_label_V(:, 1) == 4);
    tmp5 = find(tmp_label_V(:, 1) == 5);
    
    plot3(PMF_output.V(tmp1, 1), PMF_output.V(tmp1, 2), PMF_output.V(tmp1, 3),'*')
    hold on
    plot3(PMF_output.V(tmp2, 1), PMF_output.V(tmp2, 2), PMF_output.V(tmp2, 3),'*')
    hold on
    plot3(PMF_output.V(tmp3, 1), PMF_output.V(tmp3, 2), PMF_output.V(tmp3, 3),'*')
    hold on
    plot3(PMF_output.V(tmp4, 1), PMF_output.V(tmp4, 2), PMF_output.V(tmp4, 3),'*')
    hold on
    plot3(PMF_output.V(tmp5, 1), PMF_output.V(tmp5, 2), PMF_output.V(tmp5, 3),'*')
    hold off
    grid on
    str = ['V: User Matrix Data Distribution with Sparsity ', num2str(tmp)];
    title(str) 
    
end

d = 2;
figure
j = 1;
for i = 1:9:10  % 3
    tmp = 0.3 + 0.05 * i;
    data_matrix = cellofmatrix{i};
    [PMF_output] = PMF(data_matrix, rating_to_pred, iteration, d, weight_missing, mu, lambda, rm);
    tmp_label_U = kmeans(PMF_output.U, 5);
    tmp_label_V = kmeans(PMF_output.V, 5);
    
%     figure
%     subplot(1,2,1)
    subplot(2,2,j)
    j = j + 1;
    tmp1 = find(tmp_label_U(:, 1) == 1);
    tmp2 = find(tmp_label_U(:, 1) == 2);
    tmp3 = find(tmp_label_U(:, 1) == 3);
    tmp4 = find(tmp_label_U(:, 1) == 4);
    tmp5 = find(tmp_label_U(:, 1) == 5);

    plot(PMF_output.U(tmp1, 1), PMF_output.U(tmp1, 2),'*')
    hold on
    plot(PMF_output.U(tmp2, 1), PMF_output.U(tmp2, 2),'*')
    hold on
    plot(PMF_output.U(tmp3, 1), PMF_output.U(tmp3, 2),'*')
    hold on
    plot(PMF_output.U(tmp4, 1), PMF_output.U(tmp4, 2),'*')
    hold on
    plot(PMF_output.U(tmp5, 1), PMF_output.U(tmp5, 2),'*')
    hold off
    grid on
    str = ['U: Item Matrix Data Distribution with Sparsity ', num2str(tmp)];
    title(str) 
    
    subplot(2,2,j)
    j = j + 1;
    tmp1 = find(tmp_label_V(:, 1) == 1);
    tmp2 = find(tmp_label_V(:, 1) == 2);
    tmp3 = find(tmp_label_V(:, 1) == 3);
    tmp4 = find(tmp_label_V(:, 1) == 4);
    tmp5 = find(tmp_label_V(:, 1) == 5);

    plot(PMF_output.V(tmp1, 1), PMF_output.V(tmp1, 2),'*')
    hold on
    plot(PMF_output.V(tmp2, 1), PMF_output.V(tmp2, 2),'*')
    hold on
    plot(PMF_output.V(tmp3, 1), PMF_output.V(tmp3, 2),'*')
    hold on
    plot(PMF_output.V(tmp4, 1), PMF_output.V(tmp4, 2),'*')
    hold on
    plot(PMF_output.V(tmp5, 1), PMF_output.V(tmp5, 2),'*')
    hold off
    grid on
    str = ['V: User Matrix Data Distribution with Sparsity ', num2str(tmp)];
    title(str) 
end

%% using optimized parameter to get the output over 10 smalldataset
load('data.mat')

iteration = 200;
weight_missing = 0;
mu = 0.005;
lambda = 0.01;
rm = 0;
d = 3;
MAE_PMF = zeros(numel(cellofmatrix), 1);
RMSE_PMF = zeros(numel(cellofmatrix), 1);


for i = 1:1:numel(cellofmatrix)
    data_matrix = cellofmatrix{i};
    [PMF_output] = PMF(data_matrix, rating_to_pred, iteration, d, weight_missing, mu, lambda, rm);
    MAE_PMF(i ,1) = PMF_output.MAE_iter_round(iteration, 1);
    RMSE_PMF(i ,1) = PMF_output.RMSE_iter_round(iteration, 1);
end
i = 1:1:10;
figure
plot(i, MAE_PMF)
hold on
plot(i, RMSE_PMF)
hold off

% save small_output_PMF.mat MAE_PMF RMSE_PMF












