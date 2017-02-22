function  Ellipse( cx,cy,a,b,angle,option )
%Ellipse Draw an ellipse on figure
%  The center of the ellipse is (cx,cy)
%  The two axis are a and b
%  The ellipse is rotated with an angle to the x-axis
%  To show direction of main axis, input 'Arrow' to option 
t = linspace(0,2*pi);
x = a*cos(t);
y = b*sin(t);
Rot = [cos(angle),-sin(angle);sin(angle),cos(angle)]*[x;y];
x = Rot(1,:)+cx;
y = Rot(2,:)+cy;
plot(x,y)
hold on
if strcmpi(option,'Arrow')
    center = [cx,cy];
    end1 = [(cx+a*cos(angle)),(cy+a*sin(angle))];
    end2 = [(cx-b*sin(angle)),(cy+b*cos(angle))];
    quiverset=[[center;center],[(end1-center);(end2-center)]];
    quiver(quiverset(:,1),quiverset(:,2),quiverset(:,3),quiverset(:,4),0);
end
hold off
end

