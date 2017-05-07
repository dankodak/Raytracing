width = 100;
height = 100;
p = [10;-2.5;-2.5];
dist = 0.05;
r1 = [0;1;0];
r2 = [0;0;1];
rlight=[-1;-1;0];
lamp=[16;7;7];
amb=[0.2,0.2,0.2];
dir=1;
eye = [13,0,0];
amount_objects = 2;
chess = zeros(amount_objects,1);
chess(1:7)=1;
rho = ones(3,amount_objects);
rho(:,1) = [1;0.1;0.7];
rho(:,2) = [1,1,1];
rho(:,3) = [1;0.5;0.14];
rho(:,4) = [1;0.5;0.14];
rho(:,5) = [1;0.5;0.14];
rho(:,6) = [1;0.5;0.14];
rho(:,7) = [1;0.5;0.14];

%x = x1 Achse
%y = x3 Achse
%z = x2 Achse


tic
[grid] = CreateGrid(width, height, p, dist, r1, r2);
rays = ray(grid,eye);

Bool=zeros(height+1,width+1,amount_objects);
ABig = zeros(height+1,width+1,3,7);
NS = Bool;
lightings = zeros(size(rays));

for i = 1:amount_objects
    [Bool(:,:,i),NS(:,:,i)] = Newton(grid,eye,rays,objects(i));
    ABig(:,:,:,i) = lighting2(rlight,amb,dir,lamp,objects(i),NS(:,:,i),eye,rays,Bool(:,:,i),rho(:,i),chess(i),1);
end

for i = 1:height+1
    for j = 1:width+1
        % Index naehstes Objekt
        k = 0;
        for l = 1:amount_objects
            if (Bool(i,j,l) == 1 && k == 0) || (Bool(i,j,l) == 1 && NS(i,j,l) < NS(i,j,k))
                k = l;
            end
        end
        
        if k == 0
            lightings(i,j,:) = [0;0;0];
        else
            for l = 1:3
                lightings(i,j,l) = ABig(i,j,l,k);
            end
        end
    end
end
toc

image(lightings)
