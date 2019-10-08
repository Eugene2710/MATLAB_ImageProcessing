%1.1
%Load the image into MATLAB
I=imread('A0168097N_source.jpg');
disp('This photo was taken by me in a famous Tsukiji ramen bar. It is a 561x360 pixels picture')

%1.2
%Calculate the total number of pixels,N
[m,n,o] = size(I);
N=m*n;
%Convert number to a string
Nstring=num2str(N);
%disp string 
disp(['My image has a total "', Nstring ,'" pixels.'])

%1.3
%imshow(I);
figure,imshow(I);
%Give title
title('A0168097NSourceImage');
%Save it with the file name
imwrite(I,'A0168097N_testimage.jpg');

%1.4
%convert coloured image,I, to grayscale
newI=rgb2gray(I);
%repeat the same steps as above for newI, the grayscale image
figure,imshow(newI);
title('A0168097N Grayscale Image');
imwrite(I,'A0168097N_grayscale.jpg');

%1.5
if n>m
    n=m;
elseif m>n
        m=n;
end
%Since dimension n is smaller, square matrix,IMG, has dimensions n x n 
IMG=newI(1:m,1:n);
figure,imshow(IMG);
title('A0168097N Squared Grayscale Image');
imwrite(IMG,'A0168097N_IMG.jpg');



%2.1
%Plot histogram of the intensity distribution of your squared grayscale image from
%section 1.5 with 1000 bins with title and axes labelled
figure
imhist(IMG,1000);
%Give titles and labels
title('Intensity of IMG');
xlabel('grayscale range');
ylabel('Intensity');
saveas(gcf,'A0168097N_histogram_b4HE.png');

%2.3
%Display equalized image 
imshow(A0168097N_histogram_equalization(IMG))
%Give title
title('A0168097N Histogram Equalized Image');
%Save with file name
imwrite(A0168097N_histogram_equalization(IMG), 'A0168097N_histeq.jpg');

%2.4
%Plot histogram of the intensity distribution of your equalized image with 1000 bins
imhist(A0168097N_histogram_equalization(IMG),1000);
%Give title and labels
title('Intensity of Equalized IMG');
xlabel('grayscale range');
ylabel('Intensity');
%save plot
saveas(gcf,'A0168097N_histogram_afHE.png');

%2.5
disp('The image after histogram equalization looks slightly better. From both images(IMG & Histogram equalized image attached as pdf for quick reference) , the picture after histogram equalization was done has an improved contrast.')
disp('By comparing the histograms of the intensity distribution plotted in 2.1, squared grayscale image, and 2.4, equalized image(both attached), it can be seen that there is a more even distribution of intensity levels in the equalized image')
disp('This is due to the better cumulative distribution of the pixel values which is the purpose and process of a histogram equalization itself.')


%3.2
%let o be the smallest term of 2^s + 1, o = 2^1 + 1 = 3
o=3;
i=1;
%set testwidth=[] so that it will be able to run for while loop
testwidth=[];
%while loop function so that i(denoted as s in question) increases by 1
%until 2^i + 1 is less than m
while o<length(IMG)
    testwidth(i)=o;
    i=i+1;
    o=2^(i) + 1;
end
 

%3.3
%random matrix indices which span 5% of total pixels in IMG
%change greyscale level of these points to 0 (black).
%row indices
s=randi([1,length(IMG)],round(length(IMG)*length(IMG)*0.05),1);
%column indices
ss=randi([1,length(IMG)],round(length(IMG)*length(IMG)*0.05),1);
%Display the number of unique matrix indices obtained
fprintf('Unique Indices = %d\n',length(s));
%changing the greyscale level of these points to 0 (black)
noisyIMG=IMG;
for i=1:length(s)
    noisyIMG(s(i),ss(i))=0;
end
figure
%Display image
imshow(noisyIMG,'Colormap',gray);
%Display title
title('A0168097N Noisy grayscale Image'); 
%Save file
imwrite(noisyIMG,'A0168097N_noisIMG.png');

%3.4
%generate a vector from 1 to test width
for i=1:length(testwidth)
    figure;
    %Apply box_filter function to smooth noisyIMG with each single element
    %to test box width(i)
    F=A0168097N_box_filter(noisyIMG,testwidth(i));
    %saves F as an 8bit unsigned integer array
    F=uint8(F);
    imshow(F)
    %disable text interpreter to allow _(underscore) to be used in title
    set(0, 'DefaultTextInterpreter', 'none');
    %Give title
    title(sprintf('A0168097N_boxfilter_width =%.f',testwidth(i)));
    imwrite(F,sprintf('A0168097N_Filteredimage_%.f.png', testwidth(i)));
    end

%3.5

disp('In all honesty, I am not thoroughly satisfied by my denoised images.')
disp('The minimum box width which i noticed the existence of random noises among the denoised images is 5.')
disp('From box width 3(refer to attached image file as PDF ), it can be observed that image grains, a possible reason for result of erros in noise, are getting obvious. This is especially as seen from the sides of the bowl of ramen in the image.')
disp('From box width 5(refer to attached image file as PDF), it can be observed that although the grain of the image is getting a bit too much, it still can be told fairly well what is in the picture from the noodles in the bowl of ramen')
disp('However, when the box width goes to box width 9(refer to attached image file as PDF), the image has lost its essence and the content of the image could be hardly seen, i.e the noodles. Hence, this and box widths beyond 5 are rejected as the structure of interest is no longer preserved')
disp('As for box widths of way larger value like, i.e >17, a blurred image box forms and becomes smaller which shows that the structures of interest are no longer preserved. Hence, they are rejected.')
