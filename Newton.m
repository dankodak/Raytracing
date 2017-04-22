function bool = Newton(grid, eye, f)
%f Körperfunktion von R3 nach R
%bool = Wahrheitswert ob NS existiert
%Falls ja, dann 1, sonst 0

%x0 Werte
N= zeros(size(grid,1),size(grid,2));
h=0.01;
eps = 0.1;
rays = ray(grid,eye);

tic
%Newtonverfahren mit numerischer Ableitung
for k=1:5
    M=N;
    N = N-comp(f,N,rays,eye)./((comp(f,N+h,rays,eye)-comp(f,N,rays,eye))./h);   
end
toc

%Wir machen Null zuerst weil sonst werden in bool 1 mit 0 überschrieben 
bool = abs(M-N);
bool(bool<eps) = [0];
bool(bool>=eps) = [1];

end