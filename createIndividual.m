% This function creates an individual struct with three main fields:
% 
% cost => individual cost
% wins => number of time the individual is the best one in a population
% data => an array with 'time' and 'amplitude' values
%
% In 'data' array, the first aLen values correspond to 'time' values, the
% remaining correspond to 'amplitude' values. The time/amplitude pair is
% then formed by data(n,n+aLen) indexes, where 1 <= n <= aLen. All genes
% have values [0~1]
function y = createIndividual(aLen)

y.cost = Inf;
y.wins = 0;
y.data = zeros(2*aLen,1);

% first peak must be in 0 and must be positive
y.data(2:2*aLen) = rand(2*aLen-1,1);