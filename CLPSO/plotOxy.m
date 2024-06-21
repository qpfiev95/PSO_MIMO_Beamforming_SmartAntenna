n = numel(BestSol.PositionX/2);
m = numel(BestSol.PositionY/2);
dx = BestSol.PositionX/2;
dy = BestSol.PositionY/2;
dx = dx';
dx = repmat(dx,1,m);
dy = repmat(dy,n,1);
d = [dx dy];
d = reshape(d,[n*m,2]);
dl = d';


figure
plot(dl(1,:),dl(2,:),'b--o','lineStyle','none')
% plot(dl(1,:),dl(2,:),'b--o')
xlabel('Ox') 
ylabel('Oy')