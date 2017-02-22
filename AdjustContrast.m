%%This script is used to enhance experimental movie contrast
MovieName='New';
MovieType='.avi';
numberofmovie=20;
minpoint=20;

for i=1:numberofmovie
    Name=strcat(MovieName,'(',int2str(i),')',MovieType);
    Mov=VideoReader(Name);
    FrameNumber=Mov.NumberofFrames;
    low=zeros(FrameNumber,1);
    high=zeros(FrameNumber,1);
    movN=struct([]);
    for j=1:FrameNumber
        img=read(Mov,j);
        h=imhist(img,255);
        p=find(h);
        low(j)=min(p(2:end));
        high(j)=max(p);
    end
    mlow=max(low);
    mhigh=max(high);
    FixMoive=strcat(MovieName,'_enhance','(',int2str(i),')',MovieType);
    Videooutput=VideoWriter(FixMoive,'unCompressed AVI');
    Videooutput.FrameRate=5;
    open(Videooutput);
    for j=1:FrameNumber
        img=read(Mov,j);
        J=imadjust(img,[mlow/255, mhigh/255],[0,1]);
        writeVideo(Videooutput,J);
        
    end
    close(Videooutput);
    
end
    