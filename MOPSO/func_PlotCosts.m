function func_PlotCosts(pop,rep)

    pop_costs=[pop.Cost];
    plot(pop_costs(1,:),pop_costs(2,:),'ko');
    hold on;
    
    rep_costs=[rep.Cost];
    plot(rep_costs(1,:),rep_costs(2,:),'r*',...
     'MarkerSize',10,...
     'MarkerEdgeColor','b',...
     'MarkerFaceColor',[0.5,0.5,0.5]);
    
    xlabel('1^{st} Objective');
    ylabel('2^{nd} Objective');
    
    grid on;
    
    hold off;

end