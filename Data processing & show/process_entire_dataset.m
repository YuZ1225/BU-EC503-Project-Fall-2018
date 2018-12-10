%% CF Data Processing

fid = fopen('ratings_copy.csv');
Train = textscan(fid, '%d%d%d', 'Delimiter', ',');
fclose(fid);
Train = cell2mat(Train);
Train = double(Train);

fid = fopen('to_read_copy.csv');
toread = textscan(fid, '%d%d', 'Delimiter', ',');
fclose(fid);
toread = cell2mat(toread);

book_num = max(Train(:,1));
user_num = max(Train(:,2));
Train_sparse = sparse(Train(:,1), Train(:,2), Train(:,3), book_num, user_num);
spar = 1 - numel(find(Train_sparse))/numel(Train_sparse);

figure;
scatter(Train(:, 1), Train(:, 2), 1, 'o', 'r', 'filled');
title('All Data Distribution')
xlabel('User ID')
ylabel('Book ID')

Train_part = Train_sparse(:, 1:1000);
figure;
spy(Train_part, 1);
daspect([0.1 1 1])
title('Part of the Data Distribution')
xlabel('User ID')
ylabel('Book ID')

[ii,~,v] = find(Train_sparse);
avg_rat = accumarray(ii,v,[],@mean);
book_rate_avgnum = full(sum(Train_sparse~=0,2));
user_rate_avgnum = full(sum(Train_sparse~=0,1));
book_rate_num_std = std(book_rate_avgnum);
user_rate_num_mean = mean(user_rate_avgnum);
user_rate_num_std = std(user_rate_avgnum);

%% construct data matrix and label to pred
k = randperm(user_num);
a = int32(user_num * 0.8);
b = user_num - a;
train_list = Train_sparse(:, k(1: a));
test_list = Train_sparse(:, k(a+1: end));

rating_to_pred_entire = zeros(b, 3);

tmp = Train;
for i = 1:b
    tmp1 = sum(Train(:, 2) == k(a+i));
    tmp2 = unidrnd(tmp1);
    tmp3 = find(Train(:, 2) == k(a+i), 1);
    rating_to_pred_entire(i, 1) = Train(tmp3-1 + tmp2, 2);
    rating_to_pred_entire(i, 2) = Train(tmp3-1 + tmp2, 1);
    rating_to_pred_entire(i, 3) = Train(tmp3-1 + tmp2, 3);

    tmp(tmp3-1 + tmp2, 3) = 0;
end
data_matrix_entire = sparse(tmp(:,1),tmp(:,2),tmp(:,3),book_num,user_num);

% save data_entire.mat data_matrix_entire rating_to_pred_entire
% learning rate should be 0.001, 0.005 too large
% iter = 100
% running time around 800s







