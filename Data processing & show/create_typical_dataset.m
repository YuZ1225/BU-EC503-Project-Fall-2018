%% create typical dataset with two deatures

small_dataset = zeros(10, 10);
for i = 1:5
    small_dataset(i, 1:5) = 1;
    small_dataset(i, 6:10) = 5;
end
for i = 6:10
    small_dataset(i, 1:5) = 5;
    small_dataset(i, 6:10) = 1;
end


[small_num_book, small_num_user] = size(small_dataset);
small_num_rating = sum(sum(small_dataset > 0));
small_dataset_matrix = zeros(small_num_rating, 3);

user_numofbook = zeros(small_num_user, 1);
rating_to_pred = zeros(small_num_user, 3);
rating_reserved = zeros(3*small_num_user, 3);
rating_to_eliminate = zeros(small_num_rating-4*small_num_user, 3);

k = 1;
k2 = 1;
for i = 1:small_num_user
    tmp = k;
    for j = 1:small_num_book
        if (small_dataset(j, i)>0)
            small_dataset_matrix(k, :) = [i, j, small_dataset(j, i)];
            k = k + 1;
        end
    end
    tmp1 =  k - tmp;
    user_numofbook(i, 1) =tmp1;
    tmp2 = randperm(tmp1);
    rating_to_pred(i, :) = small_dataset_matrix(tmp-1 + tmp2(1), :);
    tmp3 = 3*i-2;
    rating_reserved(tmp3:(tmp3 + 2), :) = small_dataset_matrix(tmp-1 + tmp2(2:4), :);
    rating_to_eliminate(k2:(k2+tmp1-5), :) = small_dataset_matrix(tmp-1 + tmp2(5:end), :);
    k2 = k2+tmp1-4;
end

tmp_eliminate = rating_to_eliminate;
tmp = [tmp_eliminate; rating_reserved];
small_data_typical = sparse(tmp(:,2),tmp(:,1),tmp(:,3),small_num_book,small_num_user);

















