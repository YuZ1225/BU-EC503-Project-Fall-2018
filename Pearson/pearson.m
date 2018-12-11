function [MAE, RMSE] = pearson(data)
iter = 1;
[books, users] = size(data);
for j = 1:users
    user1 = data(:,j);
    i = randi(books);
    while data(i,j) == 0
        i = randi(books);
    end
    book = data(i,:);
    if data(i,j) ~= 0
        top_5_user = zeros(5,2);
        rated_user = find(data(i,:) ~= 0);
        for n = 1:length(rated_user)
            if length(find(data(:,n) ~= 0)) < 7 || rated_user(n) == j
                continue
            end
            user2 = data(:,rated_user(n));
            r1 = sum(user1 .* user2) - (sum(user1) * sum(user2))/length(user1);
            r2 = sqrt((sum(user1 .^2) - sum(user1)^2 / length(user1)) * (sum(user2 .^2) - sum(user2)^2 / length(user2)));
            user_similar = r1 / r2;
            if user_similar >= max(top_5_user(:,2))
                min_index = find(top_5_user(:,2) == min(top_5_user(:,2)));
                top_5_user(min_index(1),:) = [rated_user(n), user_similar];
            end
        end
        valid_users = find(top_5_user(:,1) ~= 0);
        total_rate = sum(data(i,top_5_user(valid_users,1)));
        predict_rate = ceil(total_rate / length(valid_users));
        %predict_rate = mode(ratings_train_sparse(i,top_20_user(valid_users,1)));
        result(iter,:) = [j,i,predict_rate];
        iter = iter + 1;
    end
end

abs_value = 0;
for i = 1:length(result)
    user = result(i,1);
    book = result(i,2);
    predict = result(i,3);
    true_value = data(book, user);
    abs_value = abs_value + abs(predict - true_value);
end
MAE = abs_value / length(result);

square_value = 0;
for i = 1:length(result)
    user = result(i,1);
    book = result(i,2);
    predict = result(i,3);
    true_value = data(book, user);
    square_value = square_value + (predict - true_value)^2;
end
RMSE = sqrt(square_value / length(result));