function output = A0168097N_box_filter(matinput,boxwidth)
%Return matrix size and define it as the dimensions(dim) of the matrix
dim = size(matinput);
%define the scale/parameter of the matrix
height = dim(1);
width=dim(2);
%Return error message when matinput is not a matrix
if height==1 || width==1
    disp('error, input is not a matrix')
    %return control to keyboard
    return
    
%Return error message when boxwidth is a negative value
elseif boxwidth<0
    disp('error, boxwidth cannot be a negative value')
    %function continues to run as long as matinput is a positive matrix
    return
%When only 1 input is provided, assume the box width is 21
elseif nargin==1
    boxwidth=21;
    
    %if box width is not a integer, round off value such that it becomes an
    %integer
%elseif boxwidth=round(boxwidth)
    %return
   
    %If box width is an odd integer, change it into an even one
elseif mod(boxwidth,2)==0
    boxwidth=boxwidth+1;
end
    
%side/range of the box filter
side = (boxwidth-1)/2;
%initialize output to be the same size as matinput
output=matinput;
%loop y values
for y=(side+1:height-side)
    %loop x values
    for x=(side+1:width-side)
        %generate a submatrix of values for filtering
        submat = matinput(y-side:y+side, x-side:x+side);
        %arithmetic mean of each column within the submatrix
        arithmean=mean(submat);
        %Mean of row to obtain the total mean so as to replace the
        %particular pixel
        output(y,x)=mean(arithmean,2);
    end
end



    
    
    