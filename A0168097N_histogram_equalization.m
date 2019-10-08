%2.2
%Input as imageInput, output as histoeqn
function [Gij]=A0168097N_histogram_equalization(imageInput)
%density of pixels with intensity ? in image denoted as pr 
pr=imhist(imageInput)/numel(imageInput);
%cumulative distribution function which is the summation of pr as shown in
%question
cdf=cumsum(pr);
%L is assumed as 256
%Gij = |(L-1)cdf|, doubling of precision 
Gij=(256-1)*cdf(double(imageInput)+1);
%save as an 8bit as demanded by question
Gij=uint8(Gij);

figure
imshow(imageInput)
title('Histogram equalization');

end



