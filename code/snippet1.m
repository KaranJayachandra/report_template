%% Finds the Optimal Binary Distribution
function X_opt = OptimalInput(p, q)
    H_p = (-p*log(p)-(1-p)...
            * log(1-p))/log(2);
    H_q = (-q*log(q)-(1-q)...
            * log(1-q))/log(2);
    alpha = 2^((H_p-H_q)/(1-p-q));
    X_opt = (1 - ((1+alpha)*q))...
            /((1+alpha)*(1-p-q));
end