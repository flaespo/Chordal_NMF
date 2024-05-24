function myPlot(Fini,  F0,T0,o0,  F1,T1,o1,  F2,T2,o2,  F3,T3,o3,  F4,T4,o4)

if nargin == 7
    
    Fmin = min([min(F0) min(F1)]);
    
    F0 = [Fini; F0-Fmin] ./Fini; 
    F1 = [Fini; F1-Fmin] ./Fini;
  
    T0 = [0; T0];
    T1 = [0; T1];

    figure('units','normalized','outerposition',[0 0 0.85 0.5])
    subplot(121)
    semilogy(F0,'k','linewidth',3),hold on
    semilogy(F1,'b--','linewidth',4)
    grid on,
    xlabel('Iteration $k$','Interpreter','latex','FontSize',16);
    ylabel('$F(x_k)-F*$','Interpreter','latex','FontSize',16);
    lgd=legend(o0.algoname,o1.algoname); 
    lgd.FontSize = 16;
    set(gca,'fontsize',16)
    
    subplot(122)
    semilogy(T0,F0,'k','linewidth',3),hold on
    semilogy(T1,F1,'b--','linewidth',4)
    grid on,
    xlabel('Time (sec.)','Interpreter','latex','FontSize',16);
    ylabel('$F(x_k)-F*$','Interpreter','latex','FontSize',16);
    set(gca,'fontsize',16)


elseif nargin == 10
    
    Fmin = min([min(F0) min(F1) min(F2)]);
    
    F0 = [Fini; F0-Fmin] ./Fini; 
    F1 = [Fini; F1-Fmin] ./Fini;
    F2 = [Fini; F2-Fmin] ./Fini;
  
    T0 = [0; T0];
    T1 = [0; T1];
    T2 = [0; T2];

    figure('units','normalized','outerposition',[0 0 0.85 0.5])
    subplot(121)
    semilogy(F0,'k','linewidth',3),hold on
    semilogy(F1,'b--','linewidth',4)
    semilogy(F2,'r:','linewidth',4)
    grid on,
    xlabel('Iteration $k$','Interpreter','latex','FontSize',16);
    ylabel('$F(x_k)-F*$','Interpreter','latex','FontSize',16);
    lgd=legend(o0.algoname,o1.algoname,o2.algoname); 
    lgd.FontSize = 16;
    set(gca,'fontsize',16)
    
    subplot(122)
    semilogy(T0,F0,'k','linewidth',3),hold on
    semilogy(T1,F1,'b--','linewidth',4)
    semilogy(T2,F2,'r:','linewidth',4)
    grid on,
    xlabel('Time (sec.)','Interpreter','latex','FontSize',16);
    ylabel('$F(x_k)-F*$','Interpreter','latex','FontSize',16);
    set(gca,'fontsize',16)



%%
elseif nargin == 13
    
    Fmin = min([min(F0) min(F1) min(F2) min(F3)]);
    
    F0 = [Fini; F0-Fmin] ./Fini; 
    F1 = [Fini; F1-Fmin] ./Fini;
    F2 = [Fini; F2-Fmin] ./Fini;
    F3 = [Fini; F3-Fmin] ./Fini;
    
    T0 = [0; T0];
    T1 = [0; T1];
    T2 = [0; T2];
    T3 = [0; T3];
    
    figure('units','normalized','outerposition',[0 0 0.85 0.5])
    subplot(211)
    semilogy(F0,'k:','linewidth',3),hold on
    semilogy(F1,'b:','linewidth',2)
    semilogy(F2,'r:','linewidth',2)
    semilogy(F3,'m--','linewidth',2),
    grid on,
    xlabel('Iteration $k$','Interpreter','latex','FontSize',16);
    ylabel('$F(x_k)-F*$','Interpreter','latex','FontSize',16);
    lgd=legend(o0.algoname,o1.algoname,o2.algoname,o3.algoname); 
    lgd.FontSize = 16;
    set(gca,'fontsize',16)
    
    subplot(212)
    semilogy(T0,F0,'k:','linewidth',3),hold on
    semilogy(T1,F1,'b:','linewidth',2)
    semilogy(T2,F2,'r:','linewidth',2)
    semilogy(T3,F3,'m--','linewidth',2),
    grid on,
    xlabel('Time (sec.)','Interpreter','latex','FontSize',16);
    ylabel('$F(x_k)-F*$','Interpreter','latex','FontSize',16);
    set(gca,'fontsize',16)


%%
elseif nargin == 16
    
    Fmin = min([min(F0) min(F1) min(F2) min(F3) min(F4)]);
    
    F0 = [Fini; F0-Fmin] ./Fini; 
    F1 = [Fini; F1-Fmin] ./Fini;
    F2 = [Fini; F2-Fmin] ./Fini;
    F3 = [Fini; F3-Fmin] ./Fini;
    F4 = [Fini; F4-Fmin] ./Fini;
    
    T0 = [0; T0];
    T1 = [0; T1];
    T2 = [0; T2];
    T3 = [0; T3];
    T4 = [0; T4];
    
    figure('units','normalized','outerposition',[0 0 0.85 0.5])
    subplot(211)
    semilogy(F0,'k:','linewidth',3),hold on
    semilogy(F1,'b:','linewidth',2)
    semilogy(F2,'r:','linewidth',2)
    semilogy(F3,'m--','linewidth',2),
    semilogy(F4,'c--','linewidth',2),
    grid on,
    xlabel('Iteration $k$','Interpreter','latex','FontSize',16);
    ylabel('$F(x_k)-F*$','Interpreter','latex','FontSize',16);
    lgd=legend(o0.algoname,o1.algoname,o2.algoname,o3.algoname,o4.algoname); 
    lgd.FontSize = 16;
    set(gca,'fontsize',16)
    
    subplot(212)
    semilogy(T0,F0,'k:','linewidth',3),hold on
    semilogy(T1,F1,'b:','linewidth',2)
    semilogy(T2,F2,'r:','linewidth',2)
    semilogy(T3,F3,'m--','linewidth',2),
    semilogy(T4,F4,'c--','linewidth',2),
    grid on,
    xlabel('Time (sec.)','Interpreter','latex','FontSize',16);
    ylabel('$F(x_k)-F*$','Interpreter','latex','FontSize',16);
    set(gca,'fontsize',16)
end

end%EOF