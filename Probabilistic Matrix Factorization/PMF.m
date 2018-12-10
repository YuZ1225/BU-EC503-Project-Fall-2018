%% Probabolistic Matrix Factorization

function [PMF_output]= PMF(data_matrix, rating_to_pred, iteration, d, weight_missing, mu, lambda, rm)
% Input: sparse data matrix that need to be factorized, with size m x n
%        matrix of rating to pred with user_id, item_id and rating
% Output: PMF_out include all the output of PMF
%         PMF.MAE; PMF.RMSE
%         PMF.U: item martix with m x d
%         PMF.V: user matrix with n x d
%         PMF_output.U = U;
%         PMF_output.V = V;
%         PMF_output.MAE_iter = MAE_iter;
%         PMF_output.RMSE_iter = RMSE_iter;
%         PMF_output.MAE_iter_round = MAE_iter_round;
%         PMF_output.RMSE_iter_round = RMSE_iter_round;
%         PMF_output.label_pred = label_pred;
%         PMF_output.label_pred_round = label_pred_round;
%         PMF_output.MAE_baseline = MAE_baseline;
%         PMF_output.RMSE_baseline = RMSE_baseline;
  

    [itm_num, usr_num] = size(data_matrix);
%     iter = 100;          % iteraton number
%     
%     para_d = 10;    % dimension of latent feature
%     para_weight = 0.05;    % parameter of weight
%     para_mu = 0.005;    % leaning rate
%     para_lambda = 0.2;  % regularization parameter
%     para_rm = mean(data_matrix(data_matrix>0)); % offset of missing rating
%     para_rm = 0;
    iter = iteration;
    para_d = d;
    para_weight = weight_missing;
    para_mu = mu;
    para_lambda = lambda;
    para_rm = rm;
    
    baseline = round(mean(data_matrix(data_matrix>0)));
    MAE_baseline = mean(abs(rating_to_pred(:,3) - baseline));
    RMSE_baseline = sqrt(mean((rating_to_pred(:,3) - baseline).^2));
    
    
    U = ones(itm_num, para_d); % item matrix
    V = ones(usr_num, para_d); % user matrix
    U = U / sqrt(para_d/5);
    V = V / sqrt(para_d/5);
    W = double(full(data_matrix>0));
    
    W = sparse(W);  % for the entire data set
%     tmp_W(W == 0) = para_weight;    % weight matrix
%     W_m = double(W == 0);
    MAE_iter = zeros(iter, 1);
    RMSE_iter = zeros(iter, 1);
    MAE_iter_round = zeros(iter, 1);
    RMSE_iter_round = zeros(iter, 1);
    
    [label_num, ~] = size(rating_to_pred);
    label_pred = zeros(label_num, iter);
    label_pred_round = zeros(label_num, iter);
    
    tmp_index = (rating_to_pred(:,1)-1) * itm_num + rating_to_pred(:,2);
    
    for i = 1:1:iter
        tic;
%         for entire data set this is too slow
%         U = U - para_mu * (-(tmp_W .* (data_matrix - (para_rm + U*V'))) * V + para_lambda * U);
%         V = V - para_mu * (-(tmp_W .* (data_matrix - (para_rm + U*V')))' * U + para_lambda * V);

        U = U - para_mu * (-(W .* (data_matrix - U*V')) * V + para_lambda * U);
        V = V - para_mu * (-(W .* (data_matrix - U*V'))' * U + para_lambda * V);

%         incorrect method. these parameter cannot be optimized by this way
%         para_lambda = para_lambda - para_mu/100*(sum(sum(U.^2)) + sum(sum(V.^2)))/2;
%         para_weight = para_weight - para_mu/10000* sum(sum(((W_m .* (data_matrix - (para_rm + U*V'))).^2)))/2;
%         para_rm = para_rm - para_mu/100*sum(sum(-(tmp_W .* (data_matrix - (para_rm + U*V')))));
        
        tmp_result = (U*V');
        label_pred(:, i) = tmp_result(tmp_index);
        MAE_iter(i, 1) = mean(abs(label_pred(:, i) - rating_to_pred(:,3)));
        RMSE_iter(i, 1) = sqrt(immse(label_pred(:, i), rating_to_pred(:,3)));
        
%         tmp_result = round(U*V');
        label_pred_round(:, i) = round(label_pred(:, i));
        MAE_iter_round(i, 1) = mean(abs(label_pred_round(:, i) - rating_to_pred(:,3)));
        RMSE_iter_round(i, 1) = sqrt(immse(label_pred_round(:, i), rating_to_pred(:,3)));
        tmp_result = [];    % clear memory
        toc;
    end
    
    % save tmp.mat U V label_pred MAE_iter RMSE_iter label_pred_round
    % MAE_iter_round RMSE_iter_round i para_d para_weight para_mu
    % para_lambda data_matrix rating_to_pred W tmp_index MAE_baseline RMSE_baseline
    
    % PMF_output_d10 = PMF_output
    % save PMF_entire_d10.mat PMF_output_d10
    % PMF_output_d3 = PMF_output
    % save PMF_entire_d3.mat PMF_output_d3
    
    PMF_output.U = U;
    PMF_output.V = V;
    PMF_output.MAE_iter = MAE_iter;
    PMF_output.RMSE_iter = RMSE_iter;
    PMF_output.MAE_iter_round = MAE_iter_round;
    PMF_output.RMSE_iter_round = RMSE_iter_round;
    PMF_output.label_pred = label_pred;
    PMF_output.label_pred_round = label_pred_round;
    PMF_output.MAE_baseline = MAE_baseline;
    PMF_output.RMSE_baseline = RMSE_baseline;
end
