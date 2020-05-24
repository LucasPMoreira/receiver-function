% This function creates a population of pLen individuals, each one with
% aLen genes, where each gene has a pair of values: time and amplitude.
% Thus, the returned population dimensions will be [2 aLen pLen].
% 
% The values of each gene are randomly generated. For 'time' variable, the
% value will be set between 0 and mT. For 'amplitude' variable, the value
% will be set between -mA and mA. The only exception is the firts gene,
% that will be set to 0 for time and a positive value less than mA.
function y = createPopulation(aLen,pLen)

for n = 1:pLen
    y(n) = createIndividual(aLen);
end