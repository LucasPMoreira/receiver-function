% Blends two individuals (parents) to generate two other individuas
% (offsprings)
%
% y = createOffspring(pop,pair)
%
% pop = is the population
% pair = [N,2] matrix with indexes of parents pairs
% y = new population
%
% The new population will have 2*N new offsprings. An heuristic or simple 
% cross-over method is applied to blend two parents (see "Practical Genetic
% Algorithms", Haupt and Haupt, 2004, for details)
%
function y = createOffspring(pop,pair,type)

% get number of genes (pair)
dataL = length(pop(1).data);
% allel = dataL/2;

% index before next offspring
fIndex = length(pop) - numel(pair);

for n = 1:size(pair,1)
    % find cross-over point
    p = 1;
    while((p <= 1)||(p >= dataL))
        p = round(rand * dataL);
    end
    % find the blending value
    b = rand;
    % create offsprings
    off1 = pop(pair(n,1));
    off2 = pop(pair(n,2));
    % determine if blending values are before or after cross-over point
    first = 0;
    last = 0;
    if(randi(2) == 1)   % before cross-over point
        first = 2;
        last = p;
    else                % after cross-over point
        first = p + 1;
        last = dataL;
    end
    for m = first:last
        if(strcmp(type,'heuris'))
            value1 = b.*(pop(pair(n,1)).data(m) - pop(pair(n,2)).data(m)) + ...
                pop(pair(n,1)).data(m);
            value2 = (1-b).*(pop(pair(n,1)).data(m) - pop(pair(n,2)).data(m)) + ...
                pop(pair(n,1)).data(m);
        elseif(strcmp(type,'simple'))
            value1 = b.*pop(pair(n,1)).data(m) + (1-b).*pop(pair(n,2)).data(m);
            value2 = (1-b).*pop(pair(n,1)).data(m) + b.*pop(pair(n,2)).data(m);
        end
        % truncate value if it gets out of bounds
        if(value1 <= 0)
            fprintf('parent 1 value out of bounds (less than zero): data(%d) = %f\tfirst = %d and last = %d\tp = %d\n',m,value1,first,last,p);
            value1 = 1e-6;
        elseif(value1 > 1)
            fprintf('parent 1 value out of bounds (higher than one): data(%d) = %f\n',m,value1);
            value1 = 1;
        end
        if(value2 <= 0)
            fprintf('parent 2 value out of bounds (less than zero): data(%d) = %f\tfirst = %d and last = %d\tp = %d\n',m,value2,first,last,p);
            value2 = 1e-6;
        elseif(value2 > 1)
            fprintf('parent 2 value out of bounds (higher than one): data(%d) = %f\n',m,value2);
            value2 = 1;
        end
        off1.data(m) = value1;
        off2.data(m) = value2;
    end
    pop(fIndex+1) = off1;
    pop(fIndex+2) = off2;
    fIndex = fIndex + 2;
end
y = pop;