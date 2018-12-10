%% Extarct small dataset from original dataset

tmp1 = sum(Train_sparse>0, 1);
[tmp2, tmp_id] = max(tmp1);                        % tmp2=200, tmp_id=12874
tmp_bookid = find(Train_sparse(:, tmp_id) > 0);
tmp_dataset = Train_sparse(tmp_bookid, :);
tmp3 = sum(tmp_dataset>0);
tmp_userid = find(tmp3>50);
tmp_dataset = tmp_dataset(:, tmp_userid);
tmp4 = sum(tmp_dataset>0, 2);
tmp_bookid2 = find(tmp4 > 40);
tmp_dataset = tmp_dataset(tmp_bookid2, :);
tmp5 = sum(tmp_dataset>0);
tmp_userid2 = find(tmp5 > 30);      %originally 27, but 50*50 is difficult to...
                                    %check book and user, so change it to
                                    %30 and users become 35.
tmp_dataset = tmp_dataset(:, tmp_userid2);
% % 1,4,6,11,12,38,40
% tmp6 = (sum(tmp_dataset>0)>27);     %user read at least 27 books
% tmp6(1) = 0;
% tmp6(4) = 0;
% tmp6(6) = 0;
% tmp6(11) = 0;
% tmp6(12) = 0;
% tmp6(38) = 0;
% tmp6(40) = 0;
% tmp_userid3 = find(tmp6);
% tmp_dataset = tmp_dataset(:, tmp_userid3);
%6,31,44
tmp7 = (sum(tmp_dataset>0, 2)>18);      %book read by at least 25 users %change to 18
% tmp7(6) = 0;
% tmp7(31) = 0;
% tmp7(44) = 0;
tmp_bookid3 = find(tmp7);

%% original ID
small_dataset = tmp_dataset(tmp_bookid3, :);
small_userid = tmp_userid(tmp_userid2)';
small_bookid = tmp_bookid(tmp_bookid2(tmp_bookid3));

small_sparsity = sum(sum(small_dataset == 0))/2500;
figure;
spy(small_dataset)
daspect([1 1 1])
title('Data Distribution of Small Dataset')
xlabel('User ID')
ylabel('Book ID')
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

%% make 10 dataset with different sparsity
[num_of_eliminate, ~] = size(rating_to_eliminate);
random_of_eliminate = randperm(num_of_eliminate)';

cellofmatrix = cell(10,1);

tmp_eliminate = rating_to_eliminate;
tmp = [tmp_eliminate; rating_reserved];
cellofmatrix{1} = sparse(tmp(:,2),tmp(:,1),tmp(:,3),small_num_book,small_num_user);
[tmp1, ~] = size(tmp);
tmp1 = tmp1 - 35*48*0.6;
tmp_eliminate(random_of_eliminate(1:tmp1), 3) = 0;
tmp = [tmp_eliminate; rating_reserved];
cellofmatrix{2} = sparse(tmp(:,2),tmp(:,1),tmp(:,3),small_num_book,small_num_user);

for i=3:1:10
    tmp2 = 35*48*0.05;
    
    tmp_eliminate(random_of_eliminate(tmp1+1:tmp1+tmp2), 3) = 0;
    tmp = [tmp_eliminate; rating_reserved];
    cellofmatrix{i} = sparse(tmp(:,2),tmp(:,1),tmp(:,3),small_num_book,small_num_user);
    tmp1 = tmp1 + tmp2;
end

% save data.mat cellofmatrix rating_to_pred small_dataset small_userid small_bookid










