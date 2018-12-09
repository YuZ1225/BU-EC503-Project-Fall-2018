ratecsv=csvread('ratings.csv',1,0);
ratecsv=unique(ratecsv,'rows');
book_id=ratecsv(:,1);
user_id=ratecsv(:,2);
rating=ratecsv(:,3);
bigmatrix=zeros(53424,10000);
for i=1:length(ratecsv)
    bigmatrix(user_id(i),book_id(i))=rating(i);
end


pred=[];
test=[];
index=[];
for i=1:size(bigmatrix,1)

user=i;
read_book=find(bigmatrix(user,:)~=0);

book_random_index=randperm(numel(read_book));
book_index=read_book(book_random_index(1));
if (length(read_book)<=7)
    index=[index,user];
else
read_user_index=find(bigmatrix(:,book_index)~=0);

read_user_index(find(user),:)=[];
read_user_index=[user;read_user_index];

user_matrix=bigmatrix(read_user_index,:);

cos=[];

for k=1:size(user_matrix,1)-1
 a=user_matrix(end,:);
 b=user_matrix(k,:);
 
cos(k,:)= dot(a,b)/(norm(a)*norm(b));
end
[~,most1]=max(cos);
user_index1=read_user_index(most1);
cos(most1,:)=[];
[~,most2]=max(cos);
user_index2=read_user_index(most2);
cos(most2,:)=[];
[~,most3]=max(cos);
user_index3=read_user_index(most3);
findrate1=bigmatrix(user_index1,book_index);
findrate2=bigmatrix(user_index2,book_index);
findrate3=bigmatrix(user_index3,book_index);
pred(i)=round((findrate1+findrate2+findrate3)/3);

test(i)=bigmatrix(user,book_index);
end
end

index_noremove=find(test~=0);
new_test=test(index_noremove);
new_pred=pred(index_noremove);
correct=0;
for j=1:length(new_test)
correct= correct+ abs(new_pred(j)-new_test(j));
end
MAE=correct/length(new_test)
RMSE = sqrt(sum((new_pred-new_test).^2)/length(new_test));