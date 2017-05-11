function RayTracing(width, height, p, r1, r2, dist, eye, newton, rlight, amb, lamp, dir, amount_objects, spec, equations, rho, chess)
% width = Breite der Bildebene in Pixel
% height = Hoehe der Bildebene in Pixel
% p = Position der linken unteren Bildebenenecke
% dist = Abstand Pixel
% r1 = 1. Richtungsvektor der Bildebene
% r2 = 2. Richtungsvektor der Bildebene
% rlight= [-1;-1;0];
% lamp= Position punktfoermiger Lichtquelle
% amb= ambiente Helligkeit
% dir= gerichtete Lichtquelle
% eye = Position Auge/Kamera
% amount_objects = Anzahl der Objekte
% chess = Schachbrett ja/meim für jedes Objekt gespeichert in Vektor
% rho = Farbe für jedes Objekte 

%x = x1 Achse
%y = x3 Achse
%z = x2 Achse


tic
% Gitter und Strahlen erstellen
[grid] = CreateGrid(width, height, p, dist, r1, r2);
rays = ray(grid,eye);

% Vorbelegung 
Bool=zeros(height+1,width+1,amount_objects);
ABig = zeros(height+1,width+1,3,7);
NS = Bool;
lightings = zeros(size(rays));

% Berechnung von Wahrheitswerten, Nullstellen und Beleuchtung fuer jedes
% Objekt
for i = 1:amount_objects
    [Bool(:,:,i),NS(:,:,i)] = Newton(grid,eye,rays,str2func(equations{i}), newton);
    ABig(:,:,:,i) = lighting2(rlight,amb,dir,lamp,str2func(equations{i}),NS(:,:,i),eye,rays,Bool(:,:,i),rho(i,:),chess(i),spec);
end

% Bestimmung des naehesten Objektes
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

% Plot 
image(lightings)
end
