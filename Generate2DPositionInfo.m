% R_all=zeros(Nc^2*(Nc^2-1)/2,1);
% Count=0;
% for i=1:(Nc^2-1)
%     R_all((Count+1):(Count+Nc^2-i))=sqrt((X_Line(i)-X_Line((i+1):Nc^2)).^2+(Y_Line(i)-Y_Line((i+1):Nc^2)).^2);
%     Count=Count+Nc^2-i;
% end
% R_all_sort=sort(R_all);
% Count=0;
% R_set=[];
% Map=[];
% while Count<Nc^2*(Nc^2-1)/2
%     R_new=R_all_sort(Count+1);
%     R_set=[R_set;R_new];
%     p=find(R_all==R_new);
%     [Np tmp]=size(p);
%     Count=Count+Np;
%     Map=[Map;{p}];
% end
load('Result_Sample.mat')
dT_adjust=2;
Tnumbermax=41;
[n,nt]=size(Vx(:,1:dT_adjust:Tnumbermax));
%%find how many different distance 
R_all=zeros(n*(n-1)/2,1);
Count=0;
for i=1:(n-1)
    R_all((Count+1):(Count+n-i))=sqrt((X(i)-X((i+1):n)).^2+(Y(i)-Y((i+1):n)).^2);
    Count=Count+n-i;
end
R_all_sort=sort(R_all);
Count=0;
R_set=0;
while Count<n*(n-1)/2
    R_new=R_all_sort(Count+1);
    R_set=[R_set;R_new];
    p=find(R_all==R_new);
    [Np tmp]=size(p);
    Count=Count+Np;
    
end
[nR,tmp]=size(R_set);
% VxTotal=reshape(Vx(:,2:end),[n*(nt-1),1]);
% VyTotal=reshape(Vy(:,2:end),[n*(nt-1),1]);
X_Line=reshape(X*ones(1,(nt-1)),[n*(nt-1),1]);
Y_Line=reshape(Y*ones(1,(nt-1)),[n*(nt-1),1]);
T_Line=reshape(ones(n,1)*5*dT_adjust*(1:(nt-1)),[n*(nt-1),1]);
len=n*(nt-1)*(n*(nt-1)+1)/2;
R_all=zeros(len,1);
T_all=zeros(len,1);
Count=0;
for i=1:(n*(nt-1))
	R_all((Count+1):(Count+n*(nt-1)-i+1))=sqrt((X_Line(i)-X_Line((i):n*(nt-1))).^2+(Y_Line(i)-Y_Line((i):n*(nt-1))).^2);
	T_all((Count+1):(Count+n*(nt-1)-i+1))=abs(T_Line(i)-T_Line((i):n*(nt-1)));
	Count=Count+n*(nt-1)-i+1;
end
T_set=5*dT_adjust*(0:(nt-2));
Map=cell(nR,(nt-1));
Map_R=cell(nR,1);
Map_T=cell((nt-1),1);

for i=1:nR
	Map_R(i)={find(R_all==R_set(i))};
end

for j=1:(nt-1)
	Map_T(j)={find(T_all==T_set(j))};
end

for i=1:nR
	for j=1:(nt-1)
		Map(i,j)={intersect(Map_T{j},Map_R{i})};
	end
end

[Xt,Xr]=meshgrid(T_set,R_set);
save(strcat('D2PositionInfo_',int2str(n),'_',int2str(Tnumbermax),'.mat'),'Xt','Xr','Map');