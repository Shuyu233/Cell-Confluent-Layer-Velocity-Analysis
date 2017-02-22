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
