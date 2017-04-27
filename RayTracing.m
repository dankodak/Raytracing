width = 100;
height = 100;
p = [8;-2.5;-2.5];
dist = 0.05;
disteye = 5;
r1 = [0;1;0];
r2 = [0;0;1];
lamp=[1;0;-0.5];
amb=0.5;
dir=0.5;

gradient = [-1,-1,-1];
%f = @(x) x(1).^2 + x(2).^2 + x(3).^2 - 16;
f = @(x,y,z) x.^2+y.^2+z.^2 -16;
t = @(x,y,z) (x.^2+y.^2+z.^2+16-4).^2-4.*16.*(y.^2+z.^2);
g = @(x,y,z) y -6;
h = @(x) x(3) - 6;
k = @(x) x(3) + 6;
l = @(x) x(2) - 6;
m = @(x) x(2) + 6;
q=4;
 
tic
[grid,eye] = CreateGrid(width, height, p, dist, disteye, r1, r2);
rays = ray(grid,eye);
[B,N] = Newton(grid,eye,rays,f);
normalen=normalvector(f,N,eye,rays);
A = lighting(lamp,amb,dir,f,N,eye,rays,B,width,height,q);

G= grayscale(height,width,q);

toc

imagesc(A)
