function [child1,child2] = SBXCrossover(parent1,parent2,upbound,lowbound,etaC)
% Function performs crossover of two individuals-SBX crossover
EPS = 1e-14;
Num_v=numel(parent1);
% the large value of etaC gives a higer probability for creating 'near-parent' solutions  
% Now do if loop
for qq = 1:Num_v
    if (rand <= 0.5)
        if abs(parent1(qq)-parent2(qq)) > EPS
            if parent1(qq) < parent2(qq)
                y1 = parent1(qq); y2 = parent2(qq);
            else
                y1 = parent2(qq); y2 = parent1(qq);%y2大
            end
            yl = lowbound(qq); yu = upbound(qq);
            rnd = rand;
            beta = 1.0 + (2.0*(y1-yl)/(y2-y1));
            alpha = 2.0 - beta^(-(etaC+1.0));
            %
            if (rnd <= (1.0/alpha))
                betaq = (rnd*alpha)^(1.0/(etaC+1.0));
            else
                betaq = (1.0/(2.0 - rnd*alpha))^(1.0/(etaC+1.0));
            end
            %
            c1 = 0.5*((y1+y2)-betaq*(y2-y1));
            beta = 1.0 + (2.0*(yu-y2)/(y2-y1));
            alpha = 2.0 - beta^(-(etaC+1.0));
            %
            if (rnd <= (1.0/alpha))
                betaq = (rnd*alpha)^(1.0/(etaC+1.0));
            else
                betaq = (1.0/(2.0 - rnd*alpha))^(1.0/(etaC+1.0));
            end
            %
            c2 = 0.5*((y1+y2)+betaq*(y2-y1));
            if (c1<yl), c1=yl; end
            if (c2<yl), c2=yl; end
            if (c1>yu), c1=yu; end
            if (c2>yu), c2=yu; end
            %
            if (rand<=0.5)
                child1(qq) = c2; child2(qq) = c1;
            else
                child1(qq) = c1; child2(qq) = c2;
            end
        else
            child1(qq) = parent1(qq); child2(qq) = parent2(qq);
        end
    else
        child1(qq) = parent1(qq); child2(qq) = parent2(qq);
    end
end