clear
close all
Vx_Total=[];
Vy_Total=[];

for i=1:25
    s=sprintf('J_memonly-02(%d)Results.mat',i);
    load(s); 
    Vx_Total=[Vx_Total;Vx];
    Vy_Total=[Vy_Total;Vy];
end
[tmp n]=size(Vx_Total);
V=sqrt(Vx_Total(:,2:end).^2+Vy_Total(:,2:end).^2);
Direction=angle(Vx_Total(:,2:end)+1i*Vy_Total(:,2:end));
splitnumber=100;
%%
sigmatimeset=zeros(2,n-1);
mutimeset=zeros(2,n-1);
directiontimeset=zeros(4,n-1);
for i=1:(n-1)
    VV=[Vx_Total(:,i+1),Vy_Total(:,i+1)];
    NormFitting=fitgmdist(VV,1);
    [Vec Dia]=eig(NormFitting.Sigma);
    sigmatimeset(:,i)=diag(Dia);
    directiontimeset(:,i)=reshape(Vec,4,1);
    mutimeset(:,i)=Vec*NormFitting.mu';
    
end
save('AnalyzeSet.mat', '*timeset')
for i=10:(n-1)
    Ellipse(mutimeset(1,i),mutimeset(2,i),sigmatimeset(1,i),sigmatimeset(2,i),atan(directiontimeset(2,i)/directiontimeset(1,i)),'Arrow')
    axis([-0.05 0.05 -0.05 0.05])
    pause()
end
sigma1type=fitdist(sigmatimeset(1,:)','normal');
sigma2type=fitdist(sigmatimeset(2,:)','normal');
angletype=fitdist(-atan(directiontimeset(1,:)'./directiontimeset(2,:)'),'normal');
figure()
subplot(2,2,1)
histogram(sigmatimeset(1,:),'Normalization','pdf');
title('\sigma_1')
subplot(2,2,2)
histogram(sigmatimeset(2,:),'Normalization','pdf');
title('\sigma_2')
subplot(2,2,3)
histogram(-atan(directiontimeset(1,:)'./directiontimeset(2,:)'),'Normalization','pdf');
title('Angle')
sigma1=sigma1type.mu;
sigma2=sigma2type.mu;
angle=angletype.mu;
velocitydirection=atan(mutimeset(2,:)./mutimeset(1,:));
polarization=atan(-directiontimeset(1,:)./directiontimeset(2,:));
subplot(2,2,4)
plot(velocitydirection,polarization,'b.')
xlabel('DirectionAvgVelocity')
ylabel('DirectionMaximumSigma')

% for i=1:(n-1)
%     V_now=V(:,i);
%     Dir_now=Direction(:,i);
%     Mag_type=fitdist((V_now),'gamma');
%     a(i)=Mag_type.a;
%     b(i)=Mag_type.b;
%     Dir_type=fitdist(Dir_now,'normal');
%     x_V=linspace(min(V_now),max(V_now),splitnumber);
%     x_Dir=linspace(min(Dir_now),max(Dir_now),splitnumber);
%     y_V=pdf(Mag_type,x_V);
%     y_Dir=pdf(Dir_type,x_Dir);
%     clf
%     subplot(1,2,1)
%     plot(x_V,y_V)
%     hold on
%     Density_V=histogram(V_now,'Normalization','pdf');
%     subplot(1,2,2)
%     plot(x_Dir,y_Dir)
%     hold on
%     Density_Dir=histogram(Dir_now,'Normalization','pdf');
%     pause()
% end


