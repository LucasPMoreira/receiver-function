% This function sorts a population of individual in a ascendent order by
% their cost value
function y = sortPopulation(pop)

[tmp,ind] = sort([pop.cost]);

y = pop(ind);

y(1).wins = y(1).wins + 1;
for n = 2:length(pop)
    y(n).wins = 0;
end