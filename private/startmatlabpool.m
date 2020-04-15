%This article is an original article by CSDN blogger "Wang Junjie MSE" and 
%Original link: https://blog.csdn.net/dang_wang/article/details/35553953
function [] = startmatlabpool(size)
 
p = gcp('nocreate'); 
if isempty(p)
    poolsize = 0;
else
    poolsize = p.NumWorkers
end


if poolsize == 0
    if nargin == 0
        parpool('local');
    else
        try
            parpool('local',size);
        catch ce
            parpool;
            fail_p = gcp('nocreate');
            fail_size = fail_p.NumWorkers;
            display(ce.message);
            display(strcat('Input size is not correct and use the default size=',num2str(fail_size)));
        end
    end
else
    disp('parpool start');
    if poolsize ~= size
        closematlabpool();
        startmatlabpool(size);
    end
end
