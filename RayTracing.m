width = 10;
height = 10;
p = [10;-2.5;-2.5];
dist = 0.5;
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
n = @(x,y,z) x + 12;
tic
[grid] = CreateGrid(width, height, p, dist, disteye, r1, r2);
rays = ray(grid,eye);

BoolBig=zeros(height+1,width+1,7);
ABig = zeros(height+1,width+1,3,7);
NBig = BoolBig;

[BoolBig(:,:,1),NBig(:,:,1)] = Newton(grid,eye,rays,t);
ABig(:,:,:,1) = lightingWithChessboard(lamp,amb,dir,t,NBig(:,:,1),eye,rays,BoolBig(:,:,1),rho_torus);

[BoolBig(:,:,2),NBig(:,:,2)] = Newton(grid, eye, rays, f);
ABig(:,:,:,2) = lightingWithChessboard(lamp,amb,dir,f,NBig(:,:,2),eye,rays,BoolBig(:,:,2),rho_sphere);

[BoolBig(:,:,3),NBig(:,:,3)] = Newton(grid,eye,rays,h);
ABig(:,:,:,3) = lightingWithChessboard(lamp,amb,dir,h,NBig(:,:,3),eye,rays,BoolBig(:,:,3),rho_ebene);

[BoolBig(:,:,4),NBig(:,:,4)] = Newton(grid, eye, rays, k);
ABig(:,:,:,4) = lightingWithChessboard(lamp,amb,dir,k,NBig(:,:,4),eye,rays,BoolBig(:,:,4),rho_ebene);

[BoolBig(:,:,5),NBig(:,:,5)] = Newton(grid,eye,rays,l);
ABig(:,:,:,5) = lightingWithChessboard(lamp,amb,dir,l,NBig(:,:,5),eye,rays,BoolBig(:,:,5),rho_ebene);

[BoolBig(:,:,6),NBig(:,:,6)] = Newton(grid, eye, rays, m);
ABig(:,:,:,6) = lightingWithChessboard(lamp,amb,dir,m,NBig(:,:,6),eye,rays,BoolBig(:,:,6),rho_ebene);

[BoolBig(:,:,7),NBig(:,:,7)] = Newton(grid, eye, rays, n);
ABig(:,:,:,7) = lightingWithChessboard(lamp,amb,dir,n,NBig(:,:,7),eye,rays,BoolBig(:,:,7),rho_ebene);


for i =1:height + 1
    for j = 1:width + 1
        if BoolBig(i,j,1) == 1 && BoolBig(i,j,2) == 1 && NBig(i,j,1) > NBig(i,j,2)
            for k=1:3
                lightings(i,j,k) = ABig(i,j,k,2);
            end
        elseif BoolBig(i,j,1) == 1 && BoolBig(i,j,2) == 1 && NBig(i,j,1) < NBig(i,j,2)
            for k = 1:3
                lightings(i,j,k) = ABig(i,j,k,1);
            end
        elseif BoolBig(i,j,1) == 1 && BoolBig(i,j,2) == 0
            for k = 1:3
                lightings(i,j,k) = ABig(i,j,k,1);
            end
        elseif BoolBig(i,j,1) == 0 && BoolBig(i,j,2) == 1
            for k = 1:3
                lightings(i,j,k) = ABig(i,j,k,2);
            end
        elseif BoolBig(i,j,1) == 0 && BoolBig(i,j,2) == 0
            k=7;
            for q = 3:7
                if NBig(i,j,q) < NBig(i,j,k) && BoolBig(i,j,q) == 1
                    k=q;
                end
            end
            for q=1:3
                lightings(i,j,q) = ABig(i,j,q,k);
            end
        end
    end
end
toc

imagesc(lightings)
