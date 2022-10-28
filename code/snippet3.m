%% Returns the Capacity of BSC
function Capacity = BSCCapacity(p)
    H_p = (-p*log(p)-(1-p)*log(1-p))...
                                /log(2);
    Capacity = 1 - H_p;
end

%% Returns the Capacity of BAC
function Capacity = BACCapacity(p)
    Capacity = log(1+((1-p)*...
                    p^(p/(1-p))))/log(2);
end