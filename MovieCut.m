ImageFiles = dir(strcat('*','avi'));
for m = 1:length(ImageFiles)
    MovieName=ImageFiles(m).name;
    Position=strfind(MovieName,'.');
    MovRaw=VideoReader(MovieName);
    NumFrames = MovRaw.NumberOfFrames;
    MovNew=VideoWriter(strcat(MovieName(1:Position-1),'Shrink','.avi'));
    MovNew.FrameRate=5;
    MovNew.Quality=100;
    open(MovNew);
    for i=1:5:  NumFrames
        Framenow=read(MovRaw,i);
        writeVideo(MovNew,Framenow);
    end
    close(MovNew);
end