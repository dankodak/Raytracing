function[Rho]= grayscale(width,height,k)
  h=height/k;
  w=width/k;
  z=zeros(h,w);
  o=ones(h,w);
  zo=[z,o;o,z];
  Rho=repmat(zo,k/2,k/2);
  nullspalte=zeros(height,1);
  nullzeile=zeros(width+1,1)';
  Rho=[Rho,nullspalte;nullzeile];
end