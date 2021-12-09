function i = RouletteWheelSelection(p)

    r = rand*sum(p);
    c = cumsum(p);
    i = find(r <= c, 1, 'first');
    if isempty(i)
        i=1;
    end
end