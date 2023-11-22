dim=100;
SW=[0 1 1; 1 0 1; 1 1 0];
SW=sparse(SW);

kmedio=(dim-1)/4;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=(length(SW)+1):dim
    z=full(sum(SW));
    zc=cumsum(z/sum(z));
    for jj=1:kmedio
    a1=find((zc-rand)>0);
    SW(j,a1(1))=1;
    SW(a1(1),j)=1;
    end
end
z=full(sum(SW));
edges=dim*kmedio;
grmin=min(z);
grmax=max(z);

for i=grmin:grmax
    pf(i)=sum(z==i);
    if pf(i)>0
        grad(i)=i;
    end
end


set(figure)
plot(log(grad(pf>0)),log(pf(pf>0)),'k*')

