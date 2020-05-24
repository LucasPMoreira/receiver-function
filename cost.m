% This function calculates the cost value of one individual.
%
% y = individualCost(ind,num,den,dt,mT,mA)
%
% data = individual allels (see createIndividual.m file)
% num = numerator vector containing the amplitude values of radial
%   component
% den = denominator vector containing the amplitude values of vertical
%   component
% dt = sampling delta from Sac files
% mT = maximum time value (time range => 0 < t < mT)
% mA = maximum amplitude value (amplitude range => -mA < a < mA, except for
%   first sample, which is 0 < a < mA)
%
% y = the cost value for individual 'ind'
function y = cost(data,num,den,dt,mT,mA)

allel = length(data)./2;
cv = zeros(length(num),1);
bSample = round((mT./dt).*data(1:allel));
bAmp(1) = mA.*data(allel+1);
bAmp(2:allel) = (2*mA).*data(allel+2:allel*2) - mA;

for n = 1:length(bSample)
    sh = circshift(den,bSample(n)) .* bAmp(n);
    cv = cv + sh;
end
y = sqrt(mean((cv - num).^2));