function [mov] =  DIC_ROI


warning off

Thresh = 1;
disksize = 6;
MinCellSize = 2000;

FileName = 'J_memonly-02(1)';

Mov = VideoReader([FileName '.avi']);

Frame = read(Mov,1);
NumFrames = Mov.NumberOfFrames;
    
Frame = double(Frame(:,:,1));

[Height,Width] = size(Frame);

[X,Y] = meshgrid((1:Width),(1:Height));

    Xsum = sum(X(:));
    Ysum = sum(Y(:));
    X2 = sum(X(:).^2);
    XY = sum(X(:).*Y(:));
    Y2 = sum(Y(:).^2);
    X3 = sum(X(:).^3);
    X2Y = sum(X(:).^2.*Y(:));
    XY2 = sum(X(:).*Y(:).^2);
    Y3 = sum(Y(:).^3);
    X4 = sum(X(:).^4);
    X3Y = sum(X(:).^3.*Y(:));
    X2Y2 = sum(X(:).^2.*Y(:).^2);
    XY3 = sum(X(:).*Y(:).^3);
    Y4 = sum(Y(:).^4);
    X5 = sum(X(:).^5);
    X4Y = sum(X(:).^4.*Y(:));
    X3Y2 = sum(X(:).^3.*Y(:).^2);
    X2Y3 = sum(X(:).^2.*Y(:).^3);
    XY4 = sum(X(:).*Y(:).^4);
    Y5 = sum(Y(:).^5);
    X6 = sum(X(:).^6);
    X5Y = sum(X(:).^5.*Y(:));
    X4Y2 = sum(X(:).^4.*Y(:).^2);
    X3Y3 = sum(X(:).^3.*Y(:).^3);
    X2Y4 = sum(X(:).^2.*Y(:).^4);
    XY5 = sum(X(:).*Y(:).^5);
    Y6 = sum(Y(:).^6);
    X7 = sum(X(:).^7);
    X4Y3 = sum(X(:).^4.*Y(:).^3);
    X6Y = sum(X(:).^6.*Y(:));
    X5Y2 = sum(X(:).^5.*Y(:).^2);
    X3Y4 = sum(X(:).^3.*Y(:).^4);
    X2Y5 = sum(X(:).^2.*Y(:).^5);
    XY6 = sum(X(:).*Y(:).^6);
    Y7 = sum(Y(:).^7);
    X8 = sum(X(:).^8);
    X5Y3 = sum(X(:).^5.*Y(:).^3);
    X7Y = sum(X(:).^7.*Y(:));
    X6Y2 = sum(X(:).^6.*Y(:).^2);
    X4Y4 = sum(X(:).^4.*Y(:).^4);
    X2Y6 = sum(X(:).^2.*Y(:).^6);
    X3Y5 = sum(X(:).^3.*Y(:).^5);
    XY7 = sum(X(:).*Y(:).^7);
    Y8 = sum(Y(:).^8);

    BM = [ Height.*Width  Xsum   Ysum   X2      XY     Y2     X3      X2Y     XY2      Y3     X4     XY3    X3Y    X2Y2     Y4;
            Xsum           X2     XY     X3      X2Y    XY2    X4      X3Y     X2Y2    XY3     X5    X2Y3    X4Y    X3Y2    XY4;                          
            Ysum           XY     Y2     X2Y     XY2    Y3     X3Y     X2Y2    XY3      Y4    X4Y     XY4   X3Y2    X2Y3     Y5;
            X2             X3     X2Y    X4      X3Y    X2Y2   X5      X4Y     X3Y2   X2Y3     X6    X3Y3    X5Y    X4Y2   X2Y4;
            XY             X2Y    XY2    X3Y     X2Y2   XY3    X4Y     X3Y2    X2Y3    XY4    X5Y    X2Y4   X4Y2    X3Y3    XY5;
            Y2             XY2    Y3     X2Y2    XY3    Y4     X3Y2    X2Y3    XY4      Y5   X4Y2     XY5   X3Y3    X2Y4     Y6;
            X3             X4     X3Y    X5      X4Y    X3Y2   X6      X5Y     X4Y2   X3Y3     X7    X4Y3    X6Y    X5Y2   X3Y4;
            X2Y            X3Y    X2Y2   X4Y     X3Y2   X2Y3   X5Y     X4Y2    X3Y3   X2Y4    X6Y    X3Y4   X5Y2    X4Y3   X2Y5;
            XY2            X2Y2   XY3    X3Y2    X2Y3   XY4    X4Y2    X3Y3    X2Y4    XY5   X5Y2    X2Y5   X4Y3    X3Y4    XY6;
            Y3             XY3    Y4     X2Y3    XY4    Y5     X3Y3    X2Y4    XY5      Y6   X4Y3     XY6   X3Y4    X2Y5     Y7;
            X4             X5     X4Y    X6      X5Y    X4Y2   X7      X6Y     X5Y2   X4Y3     X8    X5Y3    X7Y    X6Y2   X4Y4;
            XY3            X2Y3   XY4    X3Y3    X2Y4   XY5    X4Y3    X3Y4    X2Y5    XY6   X5Y3    X2Y6   X4Y4    X3Y5    XY7;
            X3Y            X4Y    X3Y2   X5Y     X4Y2   X3Y3   X6Y     X5Y2    X4Y3   X3Y4    X7Y    X4Y4   X6Y2    X5Y3   X3Y5;
            X2Y2           X3Y2   X2Y3   X4Y2    X3Y3   X2Y4   X5Y2    X4Y3    X3Y4   X2Y5   X6Y2    X3Y5   X5Y3    X4Y4   X2Y6;
            Y4             XY4     Y5    X2Y4     XY5   Y6     X3Y4    X2Y5    XY6      Y7   X4Y4     XY7   X3Y5    X2Y6     Y8
            ];
    
%compute background

    SourceBG = [ sum(Frame(:));
                 sum(X(:).*Frame(:));
                 sum(Y(:).*Frame(:));
                 sum(X(:).^2.*Frame(:));
                 sum(X(:).*Y(:).*Frame(:));
                 sum(Y(:).^2.*Frame(:));
                 sum(X(:).^3.*Frame(:));
                 sum(X(:).^2.*Y(:).*Frame(:));
                 sum(X(:).*Y(:).^2.*Frame(:));
                 sum(Y(:).^3.*Frame(:));           
                 sum(X(:).^4.*Frame(:));
                 sum(X(:).*Y(:).^3.*Frame(:));
                 sum(X(:).^3.*Y(:).*Frame(:));
                 sum(X(:).^2.*Y(:).^2.*Frame(:));
                 sum(Y(:).^4.*Frame(:))
               ];
         
    Answer = BM\SourceBG;

    BG =   Answer(1) + Answer(2).*X + Answer(3).*Y + Answer(4).*X.^2 ...
          + Answer(5).*X.*Y + Answer(6).*Y.^2 + Answer(7).*X.^3 ...
          + Answer(8).*X.^2.*Y + Answer(9).*X.*Y.^2 + Answer(10).*Y.^3 ...
          + Answer(11).*X.^4 + Answer(12).*X.*Y.^3 + Answer(13).*X.^3.*Y ...
          + Answer(14).*X.^2.*Y.^2 + Answer(15).*Y.^4;

  Frame = Frame - BG;

    Fstd = std(Frame(:));

    Mask = false(Height,Width);

    Mask(abs(Frame)>Thresh.*Fstd) = true;
    Mask = imclose(Mask,strel('disk',disksize));
    Mask = imfill(Mask,'holes');    
    Mask = imopen(Mask,strel('disk',3));
    
    Mask = bwareaopen(Mask,MinCellSize);

%Plot the boundaries around the cell

    B = bwboundaries(Mask);  
    
    imshow(Frame,[]);
    hold on;
       
   for n = 1:length(B)   
        
        boundary = B{n};
        plot(boundary(:,2),boundary(:,1),'b','Linewidth',2);
        
   end
   
imwrite(Mask,[FileName '_mask.tif'],'WriteMode','append','Compression','none');
   
tic

for i = 2:NumFrames
   i
    Frame = read(Mov,i);
  
    Frame = double(Frame(:,:,1));
    
    
% compute background

    SourceBG = [ sum(Frame(:));
                 sum(X(:).*Frame(:));
                 sum(Y(:).*Frame(:));
                 sum(X(:).^2.*Frame(:));
                 sum(X(:).*Y(:).*Frame(:));
                 sum(Y(:).^2.*Frame(:));
                 sum(X(:).^3.*Frame(:));
                 sum(X(:).^2.*Y(:).*Frame(:));
                 sum(X(:).*Y(:).^2.*Frame(:));
                 sum(Y(:).^3.*Frame(:));           
                 sum(X(:).^4.*Frame(:));
                 sum(X(:).*Y(:).^3.*Frame(:));
                 sum(X(:).^3.*Y(:).*Frame(:));
                 sum(X(:).^2.*Y(:).^2.*Frame(:));
                 sum(Y(:).^4.*Frame(:))
               ];
         
    Answer = BM\SourceBG;

    BG =   Answer(1) + Answer(2).*X + Answer(3).*Y + Answer(4).*X.^2 ...
          + Answer(5).*X.*Y + Answer(6).*Y.^2 + Answer(7).*X.^3 ...
          + Answer(8).*X.^2.*Y + Answer(9).*X.*Y.^2 + Answer(10).*Y.^3 ...
          + Answer(11).*X.^4 + Answer(12).*X.*Y.^3 + Answer(13).*X.^3.*Y ...
          + Answer(14).*X.^2.*Y.^2 + Answer(15).*Y.^4;

    Frame = Frame - BG;

    Fstd = std(Frame(:));

    Mask = false(Height,Width);
    
    Mask(abs(Frame)>Thresh.*Fstd) = true;
    Mask = imclose(Mask,strel('disk',disksize));
    Mask = imfill(Mask,'holes');    
    Mask = imopen(Mask,strel('disk',3));
    
    Mask = bwareaopen(Mask,MinCellSize);
    
    %Plot the boundaries around the cell

    B = bwboundaries(Mask);  
    
    imwrite(Mask,[FileName '_mask.tif'],'WriteMode','append','Compression','none');
    figure(1)    

    imshow(Frame,[]);
    hold on;
       
   for n = 1:length(B)   
        boundary = B{n};
        plot(boundary(:,2),boundary(:,1),'b','Linewidth',2);
        pause(0.5)
        
   end
   
   mov(:,i) = getframe;
%    close all

toc
end
