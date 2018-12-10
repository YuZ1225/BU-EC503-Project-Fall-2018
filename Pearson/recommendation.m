%Pearson correlation
function [MAE, RMSE] = 

%% Load data
% ratings: book_id, user_id, rating
% to_read: user_id, book_id
ratings = csvread('ratings.csv',1,0);
ratings = unique(ratings,'rows'); % delete duplicated rows
to_read = csvread('to_read.csv',1 ,0);

%% Sparse Matrix
ratings_train = ratings;
ratings_train_sparse = sparse(ratings_train(:,1), ratings_train(:,2), ratings_train(:,3));
ratings_train_full = full(ratings_train_sparse);
duplicated = find(ratings_train_sparse > 5);
ratings_train_sparse(duplicated) = ceil(ratings_train_sparse(duplicated) / 2);
ratings_train_full(duplicated) = ceil(ratings_train_full(duplicated) / 2);

%% split data
valid = ceil(length(ratings_train_sparse) * 0.8);
data_train = ratings_train_sparse(:,1:valid);
data_test = ratings_train_sparse(:,valid+1:length(ratings_train_sparse));
result = [];

%% test
iter = 1;
for j = 1:length(ratings_train_sparse)
    user1 = ratings_train_sparse(:,j);
    i = randi(10000);
    while ratings_train_sparse(i,j) == 0
        i = randi(10000);
    end
    book = ratings_train_sparse(i,:);
    if ratings_train_sparse(i,j) ~= 0
        top_10_user = zeros(10,2);
        rated_user = find(ratings_train_sparse(i,:) ~= 0);
        for n = 1:length(rated_user)
            if length(find(ratings_train_sparse(:,n) ~= 0)) < 7 || rated_user(n) == j
                continue
            end
            user2 = ratings_train_sparse(:,rated_user(n));
            r1 = sum(user1 .* user2) - (sum(user1) * sum(user2))/length(user1);
            r2 = sqrt((sum(user1 .^2) - sum(user1)^2 / length(user1)) * (sum(user2 .^2) - sum(user2)^2 / length(user2)));
            user_similar = r1 / r2;
            if user_similar >= max(top_10_user(:,2))
                min_index = find(top_10_user(:,2) == min(top_10_user(:,2)));
                top_10_user(min_index(1),:) = [rated_user(n), user_similar];
            end
        end
        valid_users = find(top_10_user(:,1) ~= 0);
        total_rate = sum(ratings_train_sparse(i,top_10_user(valid_users,1)));
        predict_rate = ceil(total_rate / length(valid_users));
        %predict_rate = mode(ratings_train_sparse(i,top_20_user(valid_users,1)));
        result(iter,:) = [j,i,predict_rate];
        iter = iter + 1;
    end
end

%% MAE 
abs_value = 0;
for i = 1:length(result)
    user = result(i,1);
    book = result(i,2);
    predict = result(i,3);
    true_value = ratings_train_sparse(book, user);
    abs_value = abs_value + abs(predict - true_value);
end
MAE = abs_value / length(result);

%% RMSE
square_value = 0;
for i = 1:length(result)
    user = result(i,1);
    book = result(i,2);
    predict = result(i,3);
    true_value = ratings_train_sparse(book, user);
    square_value = square_value + (predict - true_value)^2;
end
RMSE = sqrt(square_value / length(result));



    

