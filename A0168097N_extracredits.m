%Bonus Question
%%Instead of using arithmetic mean, median will be used instead; most of
%%the script are similar to that of the box filter script, hence unnecessary
%%comments are omitted 
function output = A0168097N_extrafilter(matinput2,boxwidth)
%Return matrix size and define it as the dimensions(dim) of the matrix
%Obtain height and width of the matrix
dim = size(matinput2);
height = dim(1);
width = dim(2);

  if height == 1 || width == 1
    %display error if input is not a matrix
    disp('error, input is not a matrix')
    return

elseif boxwidth<0
    %display error if boxwidth is a negative value
    disp('error, boxwidth cannot be a negative value')
    return

%if there is only 1 input, boxwidth=21 as suggested in question 3.1
elseif nargin == 1
        boxwidth = 21;
        
    
  elseif mod(boxwidth,2) == 0
   %if box width is an even number, make it odd
        boxwidth = boxwidth+1;
        
  end
   %range/side of filter
    side = (boxwidth-1)/2;
    %initialize output to be the same size as matinput2
    output = matinput2;

    %loop y values
    for y = side+1:height-side
        
        %loop all x values in range/side
        for x = side+1:width-side
            %create a submatrix of values for filtering
            submat = matinput2(y-side:y+side,x-side:x+side);
            %obtain the median of each column in the submatrix
            mid = median(submat);
            %take median of each row to obtain and replace that pixel
            output(y,x) = median(mid,2);
            
        end
    end
end
