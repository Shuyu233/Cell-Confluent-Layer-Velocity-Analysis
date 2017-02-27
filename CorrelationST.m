function [CrSet,CrAvg]=CorrelationST(Framenumber,FileName)
load('PositionInfo2D.mat')
% Set time interval

dT_adjust=2;
Tnumbermax=21;
CrSet=cell(Framenumber,1);
CrAvg=zeros(size(Map));
for k=1:Framenumber
    tic
	load(strcat(FileName,'(',int2str(k),')','Results.mat'));
	Vx=Vx(:,1:dT_adjust:Tnumbermax);
	Vy=Vy(:,1:dT_adjust:Tnumbermax);
	[n,nt]=size(Vx);
	% Substrate average velocity (drift)
	Vx=Vx-ones(n,1)*mean(Vx);
	Vy=Vy-ones(n,1)*mean(Vx);
	Vx=reshape(Vx(:,2:end),[n*(nt-1),1]);
	Vy=reshape(Vy(:,2:end),[n*(nt-1),1]);
	len=n*(nt-1)*(n*(nt-1)+1)/2;
	Count=0;
	VSample=zeros(len,1);
	for i=1:n*(nt-1)
		VSample((Count+1):(Count+n*(nt-1)-i+1))=Vx(i)*Vx(i:n*(nt-1))+Vy(i)*Vy(i:n*(nt-1));
		Count=Count+n*(nt-1)-i+1;
	end
	[nR tmp]=size(Map);
	Cr=zeros(nR,nt-1);
	for i=1:nR
		for j=1:(nt-1)
			p=Map{i,j};
			Np=length(p);
			Cr(i,j)=sum(VSample(p))/Np;
		end
	end
	Cr=(Cr)./Cr(1,1);
    CrSet{k}=Cr;
    CrAvg=CrAvg+Cr;
    toc
end
    CrAvg=CrAvg./Framenumber;
end
