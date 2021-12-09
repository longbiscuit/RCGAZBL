function y = SPXCrossover(x1, x2, VarMax,VarMin,f1,f2)
Num_v=numel(x1);
n=2.0;
if f1>f2 % the little the error value of fi, the better of xi
%     ftemp=f2;f2=f1;f1=ftemp;
    xtemp=x1;x2=x1;x1=xtemp;
end
for qq = 1:Num_v
    m=1/n*x1(qq);
    c1=(1 + rand) * m - rand * x2(qq);
end
y=c1;
% Check for Variable Bounds
y = max(y, VarMin);
y = min(y, VarMax);
end