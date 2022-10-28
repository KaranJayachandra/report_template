%% Finds the Mutual Information
function MI = MutualInformation(p, q, x)
    H_p = (-p*log(p)-(1-p)*log(1-p))/log(2);
    H_q = (-q*log(q)-(1-q)*log(1-q))/log(2);
    term_1 = -(((1-p)*x)+((1-x)*q))...
            *log(((1-p)*x)+((1-x)*q))/...
                                log(2);
    term_2 = -((p*x)+((1-x)*(1-q)))...
            *log((p*x)+((1-x)*(1-q)))/...
                                log(2);
    term_3 = - x * H_p;
    term_4 = - (1-x) * H_q;
    MI = term_1 + term_2 + term_3 + term_4;
end