%% plot result of PMF using entire dataset 
load('PMF_entire_d3.mat')
load('PMF_entire_d10.mat')
% plot PMF_entire_d3.mat and PMF_entire_d10.mat together
i = 1:1:100;
y1 = sin(i) - sin(i) + PMF_output_d3.MAE_baseline;
subplot(1,2,1)
plot(i, PMF_output_d3.MAE_iter_round, 'o')
hold on
plot(i, PMF_output_d10.MAE_iter_round)
hold on
plot (i, y1)
hold off
legend('MAE with d=3', 'MAE with d=10', 'Baseline')
xlabel('Iteration')
ylabel('MAE')
title('MAE VS Iteration using PMF, d=3/10')

y2 = sin(i) - sin(i) + PMF_output_d3.RMSE_baseline;
subplot(1,2,2)
plot(i, PMF_output_d3.RMSE_iter_round, 'o')
hold on
plot(i, PMF_output_d10.RMSE_iter_round)
hold on
plot (i, y2)
hold off
legend('RMSE with d=3', 'RMSE with d=10', 'Baseline')
xlabel('Iteration')
ylabel('RMSE')
title('RMSE VS Iteration using PMF, d=3/10')

%% plot PMF_entire_d10.mat
% y1 = sin(i) - sin(i) + PMF_output_d10.MAE_baseline;
% subplot(2,2,3)
% plot(i, PMF_output_d10.MAE_iter_round)
% hold on
% plot (i, y1)
% hold off
% legend('MAE', 'Baseline')
% xlabel('Iteration')
% ylabel('MAE')
% title('MAE VS Iteration using PMF, d=10')
% 
% y2 = sin(i) - sin(i) + PMF_output_d10.RMSE_baseline;
% subplot(2,2,4)
% plot(i, PMF_output_d10.RMSE_iter_round)
% hold on
% plot (i, y2)
% hold off
% legend('RMSE', 'Baseline')
% xlabel('Iteration')
% ylabel('RMSE')
% title('RMSE VS Iteration using PMF, d=10')

%% Plot entire U and V data in 3d using PMF_entire_d3.mat
d = 3;
mu = 0.005;
j = 1;

subplot(1,2,1)
label_U = kmeans(PMF_output_d3.U, 10);
label_V = kmeans(PMF_output_d3.V, 10);


tmp1 = find(label_U(:, 1) == 1);
tmp2 = find(label_U(:, 1) == 2);
tmp3 = find(label_U(:, 1) == 3);
tmp4 = find(label_U(:, 1) == 4);
tmp5 = find(label_U(:, 1) == 5);
tmp6 = find(label_U(:, 1) == 6);
tmp7 = find(label_U(:, 1) == 7);
tmp8 = find(label_U(:, 1) == 8);
tmp9 = find(label_U(:, 1) == 9);
tmp10 = find(label_U(:, 1) == 10);

plot3(PMF_output_d3.U(tmp1, 1), PMF_output_d3.U(tmp1, 2), PMF_output_d3.U(tmp1, 3), '*', 'MarkerSize', 6)
hold on
plot3(PMF_output_d3.U(tmp2, 1), PMF_output_d3.U(tmp2, 2), PMF_output_d3.U(tmp2, 3), '*', 'MarkerSize', 6)
hold on
plot3(PMF_output_d3.U(tmp3, 1), PMF_output_d3.U(tmp3, 2), PMF_output_d3.U(tmp3, 3), '*', 'MarkerSize', 6)
hold on
plot3(PMF_output_d3.U(tmp4, 1), PMF_output_d3.U(tmp4, 2), PMF_output_d3.U(tmp4, 3), '*', 'MarkerSize', 6)
hold on
plot3(PMF_output_d3.U(tmp5, 1), PMF_output_d3.U(tmp5, 2), PMF_output_d3.U(tmp5, 3), '*', 'MarkerSize', 6)
hold on
plot3(PMF_output_d3.U(tmp6, 1), PMF_output_d3.U(tmp6, 2), PMF_output_d3.U(tmp6, 3), '*', 'MarkerSize', 6)
hold on
plot3(PMF_output_d3.U(tmp7, 1), PMF_output_d3.U(tmp7, 2), PMF_output_d3.U(tmp7, 3), '*', 'MarkerSize', 6)
hold on
plot3(PMF_output_d3.U(tmp8, 1), PMF_output_d3.U(tmp8, 2), PMF_output_d3.U(tmp8, 3), '*', 'MarkerSize', 6)
hold on
plot3(PMF_output_d3.U(tmp9, 1), PMF_output_d3.U(tmp9, 2), PMF_output_d3.U(tmp9, 3), '*', 'MarkerSize', 6)
hold on
plot3(PMF_output_d3.U(tmp10, 1), PMF_output_d3.U(tmp10, 2), PMF_output_d3.U(tmp10, 3), '*', 'MarkerSize', 6)
hold off
grid on
str = 'U: Item Matrix Data Distribution using Entire Dataset';
title(str)

subplot(1,2,2)
tmp1 = find(label_V(:, 1) == 1);
tmp2 = find(label_V(:, 1) == 2);
tmp3 = find(label_V(:, 1) == 3);
tmp4 = find(label_V(:, 1) == 4);
tmp5 = find(label_V(:, 1) == 5);
tmp6 = find(label_V(:, 1) == 6);
tmp7 = find(label_V(:, 1) == 7);
tmp8 = find(label_V(:, 1) == 8);
tmp9 = find(label_V(:, 1) == 9);
tmp10 = find(label_V(:, 1) == 10);

plot3(PMF_output_d3.V(tmp1, 1), PMF_output_d3.V(tmp1, 2), PMF_output_d3.V(tmp1, 3), '*')
hold on
plot3(PMF_output_d3.V(tmp2, 1), PMF_output_d3.V(tmp2, 2), PMF_output_d3.V(tmp2, 3), '*')
hold on
plot3(PMF_output_d3.V(tmp3, 1), PMF_output_d3.V(tmp3, 2), PMF_output_d3.V(tmp3, 3), '*')
hold on
plot3(PMF_output_d3.V(tmp4, 1), PMF_output_d3.V(tmp4, 2), PMF_output_d3.V(tmp4, 3), '*')
hold on
plot3(PMF_output_d3.V(tmp5, 1), PMF_output_d3.V(tmp5, 2), PMF_output_d3.V(tmp5, 3), '*')
hold on
plot3(PMF_output_d3.V(tmp6, 1), PMF_output_d3.V(tmp6, 2), PMF_output_d3.V(tmp6, 3), '*')
hold on
plot3(PMF_output_d3.V(tmp7, 1), PMF_output_d3.V(tmp7, 2), PMF_output_d3.V(tmp7, 3), '*')
hold on
plot3(PMF_output_d3.V(tmp8, 1), PMF_output_d3.V(tmp8, 2), PMF_output_d3.V(tmp8, 3), '*')
hold on
plot3(PMF_output_d3.V(tmp9, 1), PMF_output_d3.V(tmp9, 2), PMF_output_d3.V(tmp9, 3), '*')
hold on
plot3(PMF_output_d3.V(tmp10, 1), PMF_output_d3.V(tmp10, 2), PMF_output_d3.V(tmp10, 3), '*')
hold off
grid on
str = 'V: User Matrix Data Distribution using Entire Dataset';
title(str) 






