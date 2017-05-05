function [bool,N] = Newton(grid, eye, rays, f)
%f Koerperfunktion von R3 nach R
%bool = Wahrheitswert ob NS existiert
%Falls ja, dann 1, sonst 0

%x0 Werte
N= zeros(size(grid,1),size(grid,2));
h=0.000001;
eps = 0.01;
%rays = ray(grid,eye);

%Newtonverfahren mit numerischer Ableitung
for k=1:50
    M=N;
    N = N-comp(f,N,rays,eye)./((comp(f,N+h,rays,eye)-comp(f,N,rays,eye))./h); 
end

%Wir machen Null zuerst weil sonst werden in bool 1 mit 0 überschrieben 

bool = abs(M-N);
bool(bool<eps) = 0;
bool(bool>=eps) = 1;
bool = ones(size(grid,1),size(grid,2)) - bool;
bool(N<0) = 0;
end