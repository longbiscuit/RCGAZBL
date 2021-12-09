function [Best,alpha] = update_alpha(CostFunction,Best,SE,Range,Omega)
Pop_Lb = repmat(Range(1,:),SE,1);
Pop_Ub = repmat(Range(2,:),SE,1);
m  = length(Omega);
fBest = CostFunction(Best);
alpha = 1;
Best0 = Best;
for i = 1:m
    State = op_rotate(Best0,SE,Omega(i)); %
    %Apply  for State > Pop_Ub or State < Pop_Lb
    changeRows = State > Pop_Ub;
    State(find(changeRows)) = Pop_Ub(find(changeRows));
    changeRows = State < Pop_Lb;
    State(find(changeRows)) = Pop_Lb(find(changeRows));
    %Apply  for State > Pop_Ub or State < Pop_Lb
    [tempBest,tempfBest] = fitness(CostFunction,State);
    if tempfBest < fBest
        Best = tempBest;
        fBest = tempfBest;
        alpha = Omega(i);
    end
end
end
