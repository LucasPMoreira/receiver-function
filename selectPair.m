% Select pairs of individuals for pairing.
%
% y = selecPair(pop,nk,type)
%
% pop = population
% nk = number of possible parents (nKeep)
% type = rank/cost
%
% y = is a [M,N] matrix where M = (length(pop)-nk)/2, and N = 2. The total
% number of cells in y is the number of offsprings to be created.
function y = selectPair(pop,nk,type)

y = zeros((length(pop)-nk)/2,2);

P = zeros(nk,1);

if(strcmp(type,'rank'))
    % calculate the denominator
    den = 0;
    for n = 1:nk
        den = den + n;
    end

    % calculate the probabilies based on rank
    prob = 0;
    for n = 1:nk
        prob = prob + (nk - n + 1)/den;
        P(n) = prob;
    end
elseif(strcmp(type,'cost'))
    den = 0;
    for n = 1:nk
        den = den + (pop(n).cost - pop(nk+1).cost);
    end
    prob = 0;
    for n = 1:nk
        prob = prob + (pop(n).cost - pop(nk+1).cost)/den;
        P(n) = prob;
    end
end

% generate a random number [0~1] and find the index of the next higher
% probality
for n = 1:((length(pop)-nk)/2)
    y(n,1) = find(P > rand(),1);
    y(n,2) = find(P > rand(),1);
    while(y(n,1) == y(n,2))
        y(n,2) = find(P > rand(),1);
    end
end