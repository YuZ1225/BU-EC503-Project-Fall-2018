% smalldata test

%% test
load('data.mat');
MAE_list = zeros(1,10);
RMSE_list = zeros(1,10);

for m = 1:10
    data = cell2mat(cellofmatrix(m));
    [MAE, RMSE] = pearson(data);
    MAE_list(:,m) = MAE;
    RMSE_list(:,m) = RMSE;
end
    