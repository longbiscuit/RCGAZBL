function y = op_translate(oldBest,newBest,SE,beta)
%原始代码
n = length(oldBest);
y = repmat(newBest',1,SE) + beta/(norm(newBest-oldBest)+eps)*reshape(kron(rand(SE,1),(newBest-oldBest)'),n,SE);
y = y';

% A=[1 2;3 4]
% B=[4 3 ;2 1]
% C=kron(A,B)
%分解
% n = length(oldBest);
% A=repmat(newBest',1,SE);%n*SE
% B=norm(newBest-oldBest)+eps;
% C=kron(rand(SE,1),(newBest-oldBest)');
% y = A + beta/B*reshape(C,n,SE);


%改写上面为循环形式，用于改编为有些不支持矩阵操作的语言
n = length(oldBest);
State=zeros(SE,n);
    F2=0.0;
    for dd=1:n
        F2=F2+ (newBest(dd)- oldBest(dd))^2;
    end
    F2=sqrt(F2)+eps;
    B=F2;
for ii=1:SE
    R1=rand;
    for dd=1:n
        State(ii,dd)=newBest(dd)+beta/B*R1*(newBest(dd)-oldBest(dd));%注意这儿一行是一组
    end
end
y=State;





end