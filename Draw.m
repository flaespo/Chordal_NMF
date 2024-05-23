clear;close all;clc
[X,Y,Z] = sphere;
plot3([0; 1],[0; 0],[0; 0],'k','linewidth',5),hold on,grid on
surf(X,Y,Z)

view(275,135)

v = [1;3;4];
plot3([0; v(1)],[0; v(2)],[0; v(3)],'k','linewidth',4)
plot3(v(1),v(2),v(3),'k.','markersize',50)

u = [1;3;2.5]/2.5;
plot3([0; u(1)],[0; u(2)],[0; u(3)],'m','linewidth',2)
plot3(u(1),u(2),u(3),'m.','markersize',50)

w = [1;3;1.5]*1.1;
plot3([0; w(1)],[0; w(2)],[0; w(3)],'b:','linewidth',2)
plot3(w(1),w(2),w(3),'b.','markersize',50)

axis equal
xlabel('$x$','FontSize',16,'Interpreter','latex')
ylabel('$y$','FontSize',16,'Interpreter','latex')
zlabel('$z$','FontSize',16,'Interpreter','latex')
xlim([0 1.5])
ylim([0,3.5])
zlim([0 4])
fontsize(gcf,18,"points")