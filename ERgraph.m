dim=100%512;
SW=sparse(dim,dim);
  kmedio=(dim-1)/4;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:kmedio*dim
    a1=ceil(rand*dim);
    a2=ceil(rand*dim);
    while a1==a2 | SW(a1,a2)==1
    a1=ceil(rand*dim);
    a2=ceil(rand*dim);
end
SW(a1,a2)=1;
SW(a2,a1)=1;
end