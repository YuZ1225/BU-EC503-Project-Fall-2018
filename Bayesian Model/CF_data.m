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

Train_part = Train_sparse(:, 1:1000);
figure;
spy(Train_part, 1);
daspect([0.1 1 1])

[ii,~,v] = find(Train_sparse);
avg_rat = accumarray(ii,v,[],@mean);
book_rate_avgnum = full(sum(Train_sparse~=0,2));
user_rate_avgnum = full(sum(Train_sparse~=0,1));















