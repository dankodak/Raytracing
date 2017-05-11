function [bool,N] = Newton(grid, eye, rays, f, iter)
% grid = Gitter
% eye = Auge
% rays = Strahlen
% f Koerperfunktion von R3 nach R
% iter = Anzahl der Iterationen des Newtonverfahrens
% bool = Wahrheitswert ob NS existiert, falls ja, dann 1, sonst 0
% N = Nullstellenmatrix

% x0 Werte berechnen
N= zeros(size(grid,1),size(grid,2));
% schrittweite
h=0.000001;
% Maximaler Abstand zwischen vorletzter und letzter Ieration, dass letzte
% Iteration als Nullstelle anerkannt wird
eps = 0.01;

%Newtonverfahren mit numerischer Ableitung
for k=1:iter
    M=N;
    N = N-comp(f,N,rays,eye,h); 
end

% befuellen der Bool-Matrix 
bool = abs(M-N);
bool(bool<eps) = 0;
bool(bool>=eps) = 1;
bool = ones(size(grid,1),size(grid,2)) - bool;
bool(N<0) = 0;
end