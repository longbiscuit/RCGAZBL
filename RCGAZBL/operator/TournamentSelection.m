function i = TournamentSelection(pop,nPop)
arrayi= randperm(nPop);
i1=arrayi(1);
i2=arrayi(2);
if pop(i1).Cost<pop(i1).Cost
    i=i1;
else
    i=i2;
end
end