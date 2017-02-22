ProData=Data3;
dt=25;
[m tmp]=size(ProData);
p=find(ProData(:,1)==1);
[n tmp]=size(p);
endp=p-1;
endp=[endp(2:end);m];
Nmax=min(ProData(endp,1));
Path=zeros(n,Nmax);
for i=1:n
    Path(i,:)=((ProData(p(i):(p(i)+Nmax-1),2)-ProData(p(i),2)).^2+(ProData(p(i):(p(i)+Nmax-1),3)-ProData(p(i),3)).^2)';
end
Avg3=mean(Path,1);






n=n+tmp-1;
Dis2=zeros(n,1);
Distmp=0;
Origin=0;
ptmp=0;
for i=1:m
  if Data2(i,1)==1
  	Origin=i;
  	if ptmp
  		Dis2(ptmp)=Distmp;
  	end
  	Distmp=0;
  	ptmp=ptmp+1;
  	continue;
  end
  if sqrt((Data2(i,2)-Data2(Origin,2))^2+(Data2(i,3)-Data2(Origin,3))^2)>Distmp
  	Distmp=sqrt((Data2(i,2)-Data2(Origin,2))^2+(Data2(i,3)-Data2(Origin,3))^2);
  end
end
Dis2(ptmp)=Distmp;
