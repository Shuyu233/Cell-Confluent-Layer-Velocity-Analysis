[N_2,tmp]=size(X);
Nc=sqrt(N_2);
R_all=zeros(Nc^2*(Nc^2-1)/2,1);
Count=0;
for i=1:(Nc^2-1)
    R_all((Count+1):(Count+Nc^2-i))=sqrt((X(i)-X((i+1):Nc^2)).^2+(Y(i)-Y((i+1):Nc^2)).^2);
    Count=Count+Nc^2-i;
end
R_all_sort=sort(R_all);
Count=0;
R_set=[];
Map=[];
while Count<Nc^2*(Nc^2-1)/2
    R_new=R_all_sort(Count+1);
    R_set=[R_set;R_new];
    p=find(R_all==R_new);
    [Np tmp]=size(p);
    Count=Count+Np;
    Map=[Map;{p}];
end
save('PositionInfo.mat','Map','R_set');
