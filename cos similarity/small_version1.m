
load('data.mat')
pred_index=rating_to_pred(:,2);
result=rating_to_pred(:,3);
pred=[];
for j=1:10
a=cellofmatrix(j);
A=cell2mat(a);
matrix=full(A).';
for i=1:size(matrix,1)
user=i;
%找到读过这本书的人
read_user_index=find(matrix(:,pred_index(i))~=0);
%移除该用户
read_user_index(find(user),:)=[];
%把该用户添加到最后一行
read_user_index=[user;read_user_index];
%相似用户的矩阵
user_matrix=matrix(read_user_index,:);
%%

cos=[];
%计算相似度矩阵
for k=1:size(user_matrix,1)-1
 a=user_matrix(end,:);
 b=user_matrix(k,:);
 
cos(k,:)= dot(a,b)/(norm(a)*norm(b));
end

[~,most1]=max(cos);
user_index1=read_user_index(most1);
findrate1=matrix(user_index1,pred_index(i));
findrate=findrate1;
if size(cos,1)>3
cos(most1,:)=[];
[~,most2]=max(cos);
user_index2=read_user_index(most2);
findrate2=matrix(user_index2,pred_index(i));
findrate=(findrate1+findrate2)/2;
end
pred(i,j)=round(findrate);
end

end


for n =1:10
    correct=0;
    avg=pred(:,n);
    for m=1:length(result)
        correct= correct+ abs(avg(m)-result(m));
    end
    MAE(n)=correct/length(result);
    RMSE(n)= sqrt(sum((avg-result).^2)/35);
 end