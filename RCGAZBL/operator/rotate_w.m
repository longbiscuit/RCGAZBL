function [Best,fBest] = rotate_w(CostFunction,Best,SE,Range,Omega)
[Best,alpha] = update_alpha(CostFunction,Best,SE,Range,Omega);
for i = 1:10
    [Best,fBest] = rotate(CostFunction,Best,SE,Range,alpha);
end
end