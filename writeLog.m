% Write in the log file the time and amplitude values for all individuals
% in a population for one generation
%
% writeLog(pop,mT,mA,gen,file)
%
% pop = population to be logged
% mT = maximum time value (time range)
% mA = maximum amplitude value (amplitude range)
% gen = population's generation
% file = string with log file's name
function writeLog(pop,mT,mA,gen,file)

pL = length(pop);
gL = length(pop(1).data)/2;

fid = fopen(file,'a');
fprintf(fid,'Generation %d\n\n',gen);

time = zeros(pL,gL);
amp = zeros(pL,gL);
for p = 1:pL
    time(p,:) = mT .* pop(p).data(1:gL);
    amp(p,1) = mA .* pop(p).data(gL+1);
    amp(p,2:gL) = (2*mA) .* pop(p).data(gL+2:2*gL) - mA;
end

for g = 1:gL
    for p = 1:pL
        fprintf(fid,'%.2f\t%.8f\t\t',time(p,g),amp(p,g));
    end
    fprintf(fid,'\n');
end
fprintf(fid,'\n');
for p = 1:pL
    fprintf(fid,'cost: %.6f\t\t\t',pop(p).cost);
end
fprintf(fid,'\n');
for p = 1:pL
    fprintf(fid,'winner: %d\t\t\t',pop(p).wins);
end
fprintf(fid,'\n');

fprintf(fid,'Cost mean:\t%.4f\n',populationCostMean(pop));
fprintf(fid,'Standard Deviation:\t%.4f\n\n',populationCostStd(pop));

fclose(fid);