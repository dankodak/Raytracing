width = 100;
height = 100;
p = [10;-2.5;-2.5];
dist = 0.05;
disteye = 5;
r1 = [0;1;0];
r2 = [0;0;1];
lamp=[13;0;0];
amb=[0,0,0];
dir=1;
eye = [13,0,0];
lightings = zeros(height + 1,width + 1,3);
rho_torus = [1,1,1];
rho_sphere = [1,0.1,0.7];
rho_ebene = [1,1,1];

%x = x1 Achse
%y = x3 Achse
%z = x2 Achse
%f = @(x) x(1).^2 + x(2).^2 + x(3).^2 - 16;
f = @(x,y,z) (x+2).^2+(y+7).^2+(z-7).^2 -16;
t = @(x,y,z) (x.^2+y.^2+z.^2+16-4).^2-4.*16.*(y.^2+z.^2);
g = @(x,y,z) x +6;
h = @(x,y,z) y - 12;
k = @(x,y,z) y + 12;
l = @(x,y,z) z - 12;
m = @(x,y,z) z + 12;
n = @(x,y,z) x - 12;
tic
[grid] = CreateGrid(width, height, p, dist, disteye, r1, r2);
rays = ray(grid,eye);

BoolBig=zeros(height+1,width+1,7);
ABig = zeros(height+1,width+1,3,7);

[BoolBig(:,:,1),N1] = Newton(grid,eye,rays,t);
ABig(:,:,:,1) = lightingWithChessboard(lamp,amb,dir,t,N1,eye,rays,BoolBig(:,:,1),rho_torus);

[BoolBig(:,:,2),N2] = Newton(grid, eye, rays, f);
ABig(:,:,:,2) = lightingWithChessboard(lamp,amb,dir,f,N2,eye,rays,BoolBig(:,:,2),rho_sphere);

[BoolBig(:,:,3),N3] = Newton(grid,eye,rays,h);
ABig(:,:,:,3) = lightingWithChessboard(lamp,amb,dir,h,N1,eye,rays,BoolBig(:,:,3),rho_ebene);

[BoolBig(:,:,4),N4] = Newton(grid, eye, rays, k);
ABig(:,:,:,4) = lightingWithChessboard(lamp,amb,dir,k,N2,eye,rays,BoolBig(:,:,4),rho_ebene);

[BoolBig(:,:,5),N5] = Newton(grid,eye,rays,l);
ABig(:,:,:,5) = lightingWithChessboard(lamp,amb,dir,l,N1,eye,rays,BoolBig(:,:,5),rho_ebene);

[BoolBig(:,:,6),N6] = Newton(grid, eye, rays, m);
ABig(:,:,:,6) = lightingWithChessboard(lamp,amb,dir,m,N2,eye,rays,BoolBig(:,:,6),rho_ebene);

[BoolBig(:,:,7),N7] = Newton(grid, eye, rays, n);
ABig(:,:,:,7) = lightingWithChessboard(lamp,amb,dir,n,N2,eye,rays,BoolBig(:,:,7),rho_ebene);






for i =1:height
    for j = 1:width
        if BoolBig(i,j,1) == 1 && BoolBig(i,j,2) == 1 && N1(i,j) > N2(i,j)
            for k=1:3
                lightings(i,j,k) = A2(i,j,k);
            end
        elseif BoolBig(i,j,1) == 1 && BoolBig(i,j,2) == 1 && N1(i,j) < N2(i,j)
            for k = 1:3
                lightings(i,j,k) = A1(i,j,k);
            end
        elseif BoolBig(i,j,1) == 1 && BoolBig(i,j,2) == 0
            for k = 1:3
                lightings(i,j,k) = A1(i,j,k);
            end
        elseif BoolBig(i,j,1) == 0 && BoolBig(i,j,2) == 1
            for k = 1:3
                lightings(i,j,k) = A2(i,j,k);
            end
        elseif BoolBig(i,j,1) == 0 && BoolBig(i,j,2) == 0
            k=7;
            for q = 3:7
                if NBig(i,j,q) < NBig(i,j,k)
                    k=q;
                end
            end
            for q=1:3
                lightings(i,j,q) = ABig(i,j,:,k);
            end
        end
    end
end
toc

imagesc(lightings)
