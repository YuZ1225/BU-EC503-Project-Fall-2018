%% script running NB using data.mat

load('data.mat');
iter = numel(cellofmatrix);
MAE_NB = zeros(iter, 1);
RMSE_NB = zeros(iter, 1);
for i = 1:1:10
    [NB_output] = NB(cellofmatrix{i}, rating_to_pred);
    MAE_NB(i, 1) = NB_output.MAE;
    RMSE_NB(i, 1) = NB_output.RMSE;
    
end

MAE_baseline = mean(abs(rating_to_pred(:, 3) - 4));
RMSE_baseline = sqrt(mean((rating_to_pred(:, 3) - 4).^2));

i = 1:1:10;
y = sin(i) - sin(i) + MAE_baseline;
figure;
plot(i, MAE_NB)
hold on
plot(i, y)
hold off

y = sin(i) - sin(i) + RMSE_baseline;
figure;
plot(i, RMSE_NB)
hold on
plot(i, y)
hold off