function y = mutatePopulation(pop,mr)

% data size
dataL = length(pop(1).data);

% total number of values to be mutated
mTotal = round(mr * length(pop) * dataL);

% lines = individual index
% column = gene index
index = ones(mTotal,2);

index(:,1) = randi(length(pop),mTotal,1);
index(:,2) = randi(dataL,mTotal,1);
for n = 1:mTotal
    % avoid mutating the best individual
    while(index(n,1) == 1)
        index(n,1) = randi(length(pop));
    end
    % avoid mutating the first time sample
    while(index(n,2) == 1)
        index(n,2) = randi(dataL);
    end
end

% mutate value
for m = 1:mTotal
    pop(index(m,1)).data(index(m,2)) = rand;
end

y = pop;