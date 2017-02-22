
load('PositionInfo.mat');
[nR tmp]=size(R_Set);
Data=zeros(nR,26);
for i=1:26
    DataFile=sprintf('J_memonly-02(%d)Results.mat',i);
    load(DataFile);
    [n,t]=size(Vx);
    SampleSize=n*(n-1)/2;
    Datatime=zeros(nR,(t-1));
    
   tic
    for l=2:t
      
        Sample=zeros(SampleSize,1);
        AvgV2=sum(Vx(:,l).^2+Vy(:,l).^2)/n;%the question is how to scale the function
        SqrAvgV=(sum(Vx(:,1))/n)^2+(sum(Vy(:,1))/n)^2;
        Scale=AvgV2-SqrAvgV;
        Count=0;
%                 for j=1:n
%                     for k=(j+1):n
%                         Count=Count+1;
%                         Sample(Count,1)=sqrt((X(j)-X(k)).^2+(Y(j)-Y(k)).^2);
%                         Sample(Count,2)=(Vx(j,l)*Vx(k,l)+Vy(j,l)*Vy(k,l));
%                     end
%                 end
        for j=1:n
            Sample((Count+1):(Count+n-j),1)=(Vx(j,l)*Vx((j+1):n,l)+Vy(j,l)*Vy((j+1):n,l));
            Count=Count+n-j;
        end
        
        Cr=zeros(nR,1);
        for j=1:nR
            P=Map{j};
            [Np,tmp]=size(P);
            Cr(j)=sum(Sample(P))/Np;
        end
        
        
        Cr=(Cr-SqrAvgV)./Scale;
        Datatime(:,(l-1))=Cr;
    
    end
    Data(:,i)=sum(Datatime,2)/(t-1);
    toc
end



