function y = op_rotate(Best,SE,alpha)
%
% n = length(Best);
% R1 = 2*rand(SE,n)-1;
% R2 = 2*rand(SE,1)-1;
% y = repmat(Best,SE,1) + alpha*repmat(R2,1,n).*R1./repmat(sqrt(sum(R1.*R1,2)),1,n);

%分解
% n = length(Best);
% R1 = 2*rand(SE,n)-1;%SE行n列的矩阵
% R2 = 2*rand(SE,1)-1;
% A=repmat(Best,SE,1);%形状和R1相同
% B=repmat(R2,1,n);%形状和R1也相同
% C=sqrt(sum(R1.*R1,2));%R1和R1每个元素之积，形状和R1相同，然后对行元素求和。最后形状和R2相同； sum(A,2) is a column vector containing the sum of each row.
% y= A+ alpha*B.*R1./repmat(C,1,n);%

%改写上面的超球体代码为循环形式，用于改编为有些不支持矩阵操作的语言
n = length(Best);
State=zeros(SE,n);
for ii=1:SE
    F2=0.0;
    for dd=1:n
        R1(dd)=2*rand-1;
        F2=F2+ R1(dd)^2;
    end
    F2=sqrt(F2)+eps;
    C=F2;
     R2=2*rand-1;
    for dd=1:n
        State(ii,dd)=Best(dd)+alpha*R2*R1(dd)/C;%注意这儿一行是一组
    end
end
y=State;

% %论文中公式 超立方体
% n = length(Best);
% State=zeros(SE,n);
% F2=0.0;
% for dd=1:n
%     F2=F2+ Best(dd)^2;
% end
% F2=sqrt(F2)+eps;
% for ii=1:SE
%     for dd=1:n
%         R1=2*rand-1;
%         State(ii,dd)=Best(dd)+alpha*R1*Best(dd)/(n*F2);%注意这儿一行是一组
%     end
% end
% y=State;

