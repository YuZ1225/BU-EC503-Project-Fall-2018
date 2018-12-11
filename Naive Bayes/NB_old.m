%% Naive Bayes Collborative Filter
fprintf('The total running time is about 720s. \n\n');

%%
rng(5);
k = randperm(user_num);
a = int32(user_num * 0.8);
b = user_num - a;
train_list = Train_sparse(:, k(1: a));
test_list = Train_sparse(:, k(a+1: end));

i = 1;
test_label = zeros(b, 3);
pred_label = zeros(b, 3);
tmp_prob = zeros(b,5);
while i <= b
    tmp1 = find(test_list(:, i) ~=0);
    tmp_rate = full(test_list(tmp1, i));
    tmp = unidrnd(numel(tmp1));
    tmp_pred_line = train_list(tmp1(tmp), :);
    pred_norzero_num = numel(find(tmp_pred_line ~= 0));
    test_label(i, 1:3) = [k(a+i), tmp1(tmp), tmp_rate(tmp)];
    pred_label(i, 1:2) = [k(a+i), tmp1(tmp)];
    tmp1(tmp) = [];
    tmp_rate(tmp) = [];
    for j = 1:5
        tmp_prior_num = sum(tmp_rate == j);
        if(tmp_prior_num == 0)
            tmp_prob(i, j) = -Inf;
        else
            tmp_index = find(tmp_rate == j);
            tmp_book = tmp1(tmp_index);
            tmp_test = train_list(tmp_book, :);
            tmp_posterior = sum((tmp_test ~= 0 & tmp_test == tmp_pred_line), 1);
            tmp_notzero = find(tmp_posterior ~= 0);
            tmp_same = full(tmp_posterior(tmp_notzero));
            tmp_result = (tmp_same + 1)/(tmp_prior_num + 5);
            tmp_result = sum(log(tmp_result)) + log(1/(tmp_prior_num + 5))*(pred_norzero_num - numel(tmp_notzero)) + log(tmp_prior_num/numel(tmp1));
            tmp_prob(i, j) = tmp_result;       
        end
    end
    i = i+1;
end

%%
[Y, I_pred] = max(tmp_prob, [], 2);
I_true = test_label(:, 3);
CCR = numel(find(I_pred == I_true))/numel(I_true);
MAE = mean(abs(I_pred - I_true));






















