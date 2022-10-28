%% Clear Workspace
clc;
clear all; %#ok<CLALL>
close all;

%% Global Parameters
C = zeros(101,101);
P = 0:0.01:1;
Q = 0:0.01:1;
Student_No = 5166160;
a = rem(Student_No, 100);
Target_Q = (200 + a)/1000;
clear a;

%% Calculating Capacity
for i = 1:101
    for j = 1:101
        p = (i-1)/100;
        q = (j-1)/100;
        x_opt = OptimalInput(p, q);
        C(i, j) = MutualInformation(p, q, x_opt);
    end
end
clear p q i j x_opt;

%% Plotting Results
figure(1);
surf(P, Q, abs(C), 'LineStyle','none');
grid on;
colormap jet;
xlabel('P');
ylabel('Q');
zlabel('Capacity');
title('Capacity of Binary Asymmetric Channel');
axis square;
figure(2);
imagesc(P, Q, abs(C));
hold on;
yline(Target_Q - 0.005, 'LineWidth', 2);
yline(Target_Q + 0.005, 'LineWidth', 2);
hold off;
colormap jet;
colorbar;
xlabel('P');
ylabel('Q');
title('Capacity of Binary Asymmetric Channel');
axis square;
figure(3);
closestIndex = find(P == Target_Q);
hold on;
plot(P, C(:, closestIndex), 'r', 'LineWidth', 2); %#ok<FNDSB>
yline(BSCCapacity(Target_Q), 'b', 'LineWidth', 2);
yline(BACCapacity(Target_Q), 'g', 'LineWidth', 2);
hold off;
legend('Binary Asymmetric Channel', 'Binary Symmetric Channel', ...
                                                            'Z Channel');
xlabel('P');
ylabel('Q');
title('Capacity of Channels');
clear closestIndex;
figure(4);
closestIndex = find(P == Target_Q);
hold on;
plot(P, C(:, closestIndex), 'r', 'LineWidth', 2); %#ok<FNDSB>
plot(P, arrayfun(@(x) BSCCapacity(x), P), 'b', 'LineWidth', 2);
plot(P, arrayfun(@(x) BACCapacity(x), P), 'g', 'LineWidth', 2);
hold off;
legend('Binary Asymmetric Channel', 'Binary Symmetric Channel', ...
                                                            'Z Channel');
xlabel('P');
ylabel('Q');
title('Capacity of Channels');
clear closestIndex;

%% Finds the Mutual Information for Binary Distributions
function MI = MutualInformation(p, q, x)
    H_p = (-p*log(p)-(1-p)*log(1-p))/log(2);
    H_q = (-q*log(q)-(1-q)*log(1-q))/log(2);
    term_1 = -(((1-p)*x)+((1-x)*q))*log(((1-p)*x)+((1-x)*q))/log(2);
    term_2 = -((p*x)+((1-x)*(1-q)))*log((p*x)+((1-x)*(1-q)))/log(2);
    term_3 = - x * H_p;
    term_4 = - (1-x) * H_q;
    MI = term_1 + term_2 + term_3 + term_4;
end

%% Finds the Optimal Binary Distribution of Input Variables
function X_opt = OptimalInput(p, q)
    H_p = (-p*log(p)-(1-p)*log(1-p))/log(2);
    H_q = (-q*log(q)-(1-q)*log(1-q))/log(2);
    alpha = 2^((H_p-H_q)/(1-p-q));
    X_opt = (1 - ((1+alpha)*q))/((1+alpha)*(1-p-q));
end

%% Returns the Capacity of Binary Symetric Channel
function Capacity = BSCCapacity(p)
    H_p = (-p*log(p)-(1-p)*log(1-p))/log(2);
    Capacity = 1 - H_p;
end

%% Returns the Capacity of Binary Assymetric Channel
function Capacity = BACCapacity(p)
    Capacity = log(1+((1-p)*p^(p/(1-p))))/log(2);
end