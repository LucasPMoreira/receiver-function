clear;clc;

rng('shuffle');                 % random number generator seed (must be changed after debugging stage)
% parpool(4);			% uncomment this line if parallel for is used

dataPath = '/data/folder/path/comes/here';
resultPath = '/result/path/comes/here';

% open and read files necessary to deconvolution
radFile = 'radial.file.sac';   % radial file
verFile = 'vertical.file.sac'; % vertical file

g_window = 2.5
maxTime = 30;           % maximum time allowed for all RF bumps
maxAmp = 1.0;           % maximum amplitude allowed for all RF bumps

radSac = rsac(fullfile(dataPath,radFile));	% SACLAB function
verSac = rsac(fullfile(dataPath,verFile));	% SACLAB function
delta = lh(verSac,'DELTA');			% SACLAB function
w = gausswin(round(1./delta),g_window);
rad = filter(w,1,radSac(:,2));
ver = filter(w,1,verSac(:,2));

% convergence criteria
maxGen = 1000;           % maximum number of generations
% maxMean = 50;           % maximum number of generations with same cost mean (not implemented)
% maxStd = 50;            % maximum number of generations with same cost standard deviation (not implemented)
% maxWin = 500;            % maximum number of generations with same winner individual (not implemented)

% create log file
log = fullfile(resultPath,'garf.log');
f = fopen(log,'w');
fprintf(f,'Log file\n\n');
fclose(f);

% define GA parameters
allelLength = 45;       % number of RF's bumps
popLength = 100;         % number of individuals in the population
matingRate = 0.3;       % population rate for natural selection [0~1)
mutationRate = 0.01;    % mutation rate [0~1)

% creates a new population
pop = createPopulation(allelLength,popLength);
winner = createPopulation(allelLength,maxGen);

% calculate the cost for each individual
for n = 1:popLength
    pop(n).cost = cost(pop(n).data,rad,ver,delta,maxTime,maxAmp);
end

% sort population
pop = sortPopulation(pop);
writeLog(pop,maxTime,maxAmp,0,log);

% ensure that the number of future offsprings is always even
nKeep = round(matingRate*popLength);
if(mod((popLength - nKeep),2) == 1)
    nKeep = nKeep - 1;
end

h = waitbar(0,'Processing');
for gen = 1:maxGen
    waitbar(gen/maxGen,h,sprintf('Generation %d',gen));
    pair = selectPair(pop,nKeep,'rank');

    pop = createOffspring(pop,pair,'simple');

    pop = mutatePopulation(pop,mutationRate);

    % calculate the cost for each individual
    for n = 1:popLength
    % parfor n = 1:popLength	%uncomment this line if parallel for is used
        pop(n).cost = cost(pop(n).data,rad,ver,delta,maxTime,maxAmp);
    end

    pop = sortPopulation(pop);
    winner(gen) = pop(1);

    writeLog(pop,maxTime,maxAmp,gen,log);
end
close(h);

fid = fopen(log,'a');
fprintf(fid,'\n\nConvergence reached at generation %d\n\n',gen);

save(fullfile(resultPath,'results.mat'),'winner','matingRate','mutationRate');
