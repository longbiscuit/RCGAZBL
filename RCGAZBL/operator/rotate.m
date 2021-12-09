function [Best,fBest,flag] = rotate(CostFunction,oldBest,SE,Range,alpha)
beta = 1;
Pop_Lb = repmat(Range(1,:),SE,1);
Pop_Ub = repmat(Range(2,:),SE,1);

Best = oldBest;
fBest  = CostFunction(Best);%feval(funfcn,Best);

State = op_rotate(Best,SE,alpha); %
%Apply  for State > Pop_Ub or State < Pop_Lb
changeRows = State > Pop_Ub;
State(find(changeRows)) = Pop_Ub(find(changeRows));
changeRows = State < Pop_Lb;
State(find(changeRows)) = Pop_Lb(find(changeRows));
%Apply  for State > Pop_Ub or State < Pop_Lb
[newBest,fGBest] = fitness(CostFunction,State);
if fGBest < fBest
    fBest = fGBest;
    Best = newBest;
    flag = 1;
else
    flag = 0;
end

if flag ==1
    State = op_translate(oldBest,Best,SE,beta);%
    %Apply  for State > Pop_Ub or State < Pop_Lb
    changeRows = State > Pop_Ub;
    State(find(changeRows)) = Pop_Ub(find(changeRows));
    changeRows = State < Pop_Lb;
    State(find(changeRows)) = Pop_Lb(find(changeRows));
    %Apply  for State > Pop_Ub or State < Pop_Lb
    [newBest,fGBest] = fitness(CostFunction,State);
    if fGBest < fBest
        fBest = fGBest;
        Best = newBest;
    end
end
end



