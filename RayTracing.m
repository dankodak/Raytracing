width = 100;
height = 100;
p = [10;-2.5;-2.5];
dist = 0.05;
disteye = 5;
r1 = [0;1;0];
r2 = [0;0;1];
lamp=[13;0;0];
amb=0.5;
dir=1;
eye = [13,0,0];
lightings = zeros(height + 1,width + 1,3);
rho_torus = [1,1,0];
rho_sphere = [1,1,1];

%x = x1 Achse
%y = x3 Achse
%z = x2 Achse
%f = @(x) x(1).^2 + x(2).^2 + x(3).^2 - 16;
f = @(x,y,z) (x+2).^2+(y+7).^2+(z-7).^2 -16;
t = @(x,y,z) (x.^2+y.^2+z.^2+16-4).^2-4.*16.*(y.^2+z.^2);
g = @(x,y,z) x +6;
h = @(x) x(3) - 6;
k = @(x) x(3) + 6;
l = @(x) x(2) - 6;
m = @(x) x(2) + 6;

tic
[grid] = CreateGrid(width, height, p, dist, disteye, r1, r2);
rays = ray(grid,eye);

[B1,N1] = Newton(grid,eye,rays,t);
A1 = lighting(lamp,amb,dir,t,N1,eye,rays,B1,rho_torus);

[B2,N2] = Newton(grid, eye, rays, f);
A2 = lighting(lamp,amb,dir,f,N2,eye,rays,B2,rho_sphere);

for i =1:height
    for j = 1:width
        if B1(i,j) == 1 && B2(i,j) == 1 && N1(i,j) > N2(i,j)
            for k=1:3
                lightings(i,j,k) = A2(i,j,k);
            end
        elseif B1(i,j) == 1 && B2(i,j) == 1 && N1(i,j) < N2(i,j)
            for k = 1:3
                lightings(i,j,k) = A1(i,j,k);
            end
        elseif B1(i,j) == 1 && B2(i,j) == 0
            for k = 1:3
                lightings(i,j,k) = A1(i,j,k);
            end
        elseif B1(i,j) == 0 && B2(i,j) == 1
            for k = 1:3
                lightings(i,j,k) = A2(i,j,k);
            end
        end
    end
end
toc

imagesc(lightings)
