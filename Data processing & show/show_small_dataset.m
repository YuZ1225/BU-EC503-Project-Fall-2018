%% plot small dataset

load('data.mat');
figure
j = 1;

for i = 1:3:10
    [book_num, user_num] = size(cellofmatrix{i});
    subplot(2,2,j)
    spy(cellofmatrix{i})
    tmp = 1 - sum(sum(cellofmatrix{i}>0))/book_num/user_num;
    title(['Sparsity = ', num2str(tmp)])
    xlabel('User ID')
    ylabel('Book ID')
    j = j + 1;
end