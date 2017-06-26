a = load('assignment1.mat');
T1 = [];
for i = 1:50
T1 = [T1 ; a.im1(a.xriver(i),a.yriver(i)) a.im2(a.xriver(i),a.yriver(i)) a.im3(a.xriver(i),a.yriver(i)) a.im4(a.xriver(i),a.yriver(i))];
end

T2=[];
for i = 1:100
T2 = [T2 ; a.im1(a.xnonriver(i),a.ynonriver(i)) a.im2(a.xnonriver(i),a.ynonriver(i)) a.im3(a.xnonriver(i),a.ynonriver(i)) a.im4(a.xnonriver(i),a.ynonriver(i))];
end

meanT1 = mean(T1);
meanT2 = mean(T2);

T1 = double(T1);
covT1 = cov(T1);
T2 = double(T2);
covT2 = cov(T2);

data=[];
for i =1:512
    for j = 1:512
        data = [data ; a.im1(i,j) a.im2(i,j) a.im3(i,j) a.im4(i,j)];
    end
end

data = double(data);
river_class = [];
nonriver_class = [];
output_image1 = a.im1;
output_image2 = a.im1;
output_image3 = a.im1;

for x1= 1:512
   for y1 = 1:512
        i = (x1-1)*512 + y1;
        river_class = (data(i,:)-meanT1)*inv(covT1)*(data(i,:)-meanT1)';
        nonriver_class =(data(i,:)-meanT2)*inv(covT2)*(data(i,:)-meanT2)';
        p1 = (-0.5)*1/(sqrt(det(covT1)))*exp(river_class);
        p2 = (-0.5)*1/(sqrt(det(covT2)))*exp(nonriver_class);
        
        P1 = 0.3; P2 = 0.7;
        if (P1*p1 >= P2*p2)
            output_image1(x1,y1)=255;
        else
            output_image1(x1,y1)=0;
        end
        
        P1 = 0.5; P2 = 0.5;
        if (P1*p1 >= P2*p2)
            output_image2(x1,y1)=255;
        else
            output_image2(x1,y1)=0;
        end
        
        P1 = 0.7; P2 = 0.3;
        if (P1*p1 >= P2*p2)
            output_image3(x1,y1)=255;
        else
            output_image3(x1,y1)=0;
        end
    end
end
    
subplot(1,3,1);
imshow(output_image1);
title('P1 = 0.3 and P2 = 0.7');

subplot(1,3,2);
imshow(output_image1);
title('P1 = 0.5 and P2 = 0.5');

subplot(1,3,3);
imshow(output_image1);
title('P1 = 0.7 and P2 = 0.3');
    
    
    
    