%This article is an original article by CSDN blogger "Wang Junjie MSE" 
%Original link: https://blog.csdn.net/dang_wang/article/details/35553953
function [] = closematlabpool
   poolobj = gcp('nocreate');
   delete(poolobj);
end