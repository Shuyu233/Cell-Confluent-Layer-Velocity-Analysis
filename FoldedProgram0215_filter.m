% MovName='New_enhance.avi';
% 
% DriveOF(MovName,[],'none');

 NofMov=20;
load('PositionInfo.mat');
[nR tmp]=size(R_Set);
Data=zeros(nR,NofMov);

for i=1:NofMov
    DataFile=sprintf('New_enhance(%d)Results.mat',i);
    load(DataFile);
    [n,t]=size(Vx);
    SampleSize=n*(n-1)/2;
    Datatime=zeros(nR,(t-1));
    V_mask=SubOdd(Vx,Vy);%%%%%!!!!!!!
    for l=2:t
      
        Sample=zeros(SampleSize,1);
        Sample_mask=zeros(SampleSize,1);
        Vx(:,l)=Vx(:,l)-mean(Vx(:,l));
        Vy(:,l)=Vy(:,l)-mean(Vy(:,l));
        AvgV2=sum(Vx(:,l).^2+Vy(:,l).^2)/n;%the question is how to scale the function
        SqrAvgV=(sum(Vx(:,l))/n)^2+(sum(Vy(:,l))/n)^2;
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
            Sample_mask((Count+1):(Count+n-j),1)=(V_mask(j,l)*V_mask((j+1):n,l));
            Count=Count+n-j;
        end
        
        
        Cr=zeros(nR,1);
        for j=1:nR
            P=Map{j};
            %[Np,tmp]=size(P);
            Np=sum(Sample_mask(P));
            Cr(j)=sum(Sample(P))/Np;
        end
        
        
        Cr=(Cr-SqrAvgV)./Scale;
        Datatime(:,(l-1))=Cr;
    
    end
    Data(:,i)=sum(Datatime,2)/(t-1);
    
end
save('Result.mat','Data');
Std=std(Data,0,2);
Avg=sum(Data,2)/23;
errorbar(R_Set*0.23,Avg,Std);

function V_mask=SubOdd(Vx,Vy)
%Find point that with extremely large velocity, which is caused by sudden
%appearance of some kind of pollution out of the monolayer.
V=sqrt(Vx.^2+Vy.^2);
[n m]=size(Vx);
V_mask=ones(n,m);
for i=2:m
    V_mask(:,i)= ~(V(:,i)>(mean(V(:,i))+3*std(V(:,i))));
    
end
end

