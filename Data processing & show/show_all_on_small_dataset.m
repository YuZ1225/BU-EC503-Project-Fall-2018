%% plot all result of small dataset

load('small_output_baseline.mat')
load('small_output_cos.mat')
load('small_output_pearson.mat')
load('small_output_NB.mat')
load('small_output_PMF.mat')


i=0.35:0.05:0.80;
y1 = sin(i) - sin(i) + MAE_baseline;
y2 = sin(i) - sin(i) + RMSE_baseline;
figure
subplot(1,2,1)
plot(i, y1)
hold on
plot(i, MAE_cos, 'o-')
hold on
plot(i, MAE_pearson, '.-')
hold on
plot(i, MAE_NB, '+-')
hold on
plot(i, MAE_PMF, '*-')
hold off
legend('baseline', 'cosine', 'Pearson', 'NB', 'PMF')
str = 'MAE of Different Algorithms VS Sparsity';
title(str)
xlabel('Sparsity')
ylabel('MAE')
axis([0.35,0.80,0.5,1.5])

subplot(1,2,2)
plot(i, y2)
hold on
plot(i, RMSE_cos, 'o-')
hold on
plot(i, RMSE_pearson, '.-')
hold on
plot(i, RMSE_NB, '+-')
hold on
plot(i, RMSE_PMF, '*-')
hold off
legend('baseline', 'cosine', 'Pearson', 'NB', 'PMF')
str = 'RMSE of Different Algorithms VS Sparsity';
title(str)
xlabel('Sparsity')
ylabel('RMSE')
axis([0.35,0.80,0.5,2.0])










