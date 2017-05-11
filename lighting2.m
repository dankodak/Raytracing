function [Light]=lighting2(rlight,amb,dir,lamp,f,N,Eye,rays,bool,rho_color,chess,spec)
% rlight = Richtung der parallelen Lichtstrahlen
% lamp= Standort der Lichtquelle
% amb=ambiente Helligkeit der Szene (element(0,1)in R^3)
% dir=gerichtete Lichtquelle 
% f=Koerperfunktion
% N=Matrix mit Nullstellen der Verknuepfung von Koerperfunktion und Strahl
% rays=Matrix mit Richtungvektoren der Strahlen
% bool=Wahrheitsmatrix mit Schnittpunkt oder ohne Schnittpunkt
% Eye = Auge
% rho_color= Objektfarbe
% chess= Schachbrett ja/nein
% spec= Glanzpunkte ja/nein
% Light = Matrix mit Lichtwerten

% Berechnung Normalenvektoren an Schnittstelle Strahl und Objekt
Normal = normalvector(f,N,Eye,rays);

% Vorbelegung
Light = zeros(size(rays));
I_diff = Light;
I_amb = Light;
I_spec = Light;
Surface = zeros(size(rays));
dots = zeros(size(bool));

% Zerlegen der 3-dim. Matrizen in 2-dim.
Normal1 = Normal(:,:,1);
Normal2 = Normal(:,:,2);
Normal3 = Normal(:,:,3);
I_diff1 = zeros(size(rays,1),size(rays,2));
I_diff2 = zeros(size(rays,1),size(rays,2));
I_diff3 = zeros(size(rays,1),size(rays,2));
I_amb1 = zeros(size(rays,1),size(rays,2));
I_amb2 = zeros(size(rays,1),size(rays,2));
I_amb3 = zeros(size(rays,1),size(rays,2));

%Oberflaechenpunkte bestimmen
for i = 1:3
  Surface(:,:,i) = rays(:,:,i).*N(:,:) + Eye(i);
end

% Zerlegen der Oberflaechenpunkte
Surface1 = Surface(:,:,1);
Surface2 = Surface(:,:,2);
Surface3 = Surface(:,:,3);

% befuellen der Matirx mit Beleuchtungswerten
if chess == 1 % Schachbrett an
    % Indices wo Objekt ist
    indices = bool>0;
    % Skalarprodukte an diesen Stellen mit Normalenvektor und Lichtrichtung
    dots(indices) = Normal1(indices).*rlight(1) + Normal2(indices).*rlight(2) + Normal3(indices).*rlight(3);
    % Indices da wo Skalarprodukte kleiner 0
    newindices = dots < 0;
    % Befuellen dieser Matrixindices
    I_diff1(newindices) = dir .* rho_color(1) .* chessboard2([Surface1(newindices);Surface2(newindices);Surface3(newindices)],1,0) .* abs(dots(newindices))./(sqrt(Normal1(newindices).^2 + Normal2(newindices).^2 + Normal3(newindices).^2).*norm(rlight));
    I_diff2(newindices) = dir .* rho_color(2) .* chessboard2([Surface1(newindices);Surface2(newindices);Surface3(newindices)],0,1) .* abs(dots(newindices))./(sqrt(Normal1(newindices).^2 + Normal2(newindices).^2 + Normal3(newindices).^2).*norm(rlight));
    I_diff3(newindices) = dir .* rho_color(3) .* chessboard2([Surface1(newindices);Surface2(newindices);Surface3(newindices)],0.5,.5) .* abs(dots(newindices))./(sqrt(Normal1(newindices).^2 + Normal2(newindices).^2 + Normal3(newindices).^2).*norm(rlight));
    % Zusammensetzen der Matrix
    I_diff(:,:,1) = I_diff1;
    I_diff(:,:,2) = I_diff2;
    I_diff(:,:,3) = I_diff3;
    else % Schachbrett aus
        % Indices wo Objekt ist
        indices = bool>0;
        % Skalarprodukte an diesen Stellen mit Normalenvektor und Lichtrichtung
        dots(indices) = Normal1(indices).*rlight(1) + Normal2(indices).*rlight(2) + Normal3(indices).*rlight(3);
        % Indices da wo Skalarprodukte kleiner 0
        newindices = dots < 0;
        % Befuellen dieser Matrixindices
        I_diff1(newindices) = dir .* rho_color(1) .* abs(dots(newindices))./(sqrt(Normal1(newindices).^2 + Normal2(newindices).^2 + Normal3(newindices).^2).*norm(rlight));
        I_diff2(newindices) = dir .* rho_color(2) .* abs(dots(newindices))./(sqrt(Normal1(newindices).^2 + Normal2(newindices).^2 + Normal3(newindices).^2).*norm(rlight));
        I_diff3(newindices) = dir .* rho_color(3) .* abs(dots(newindices))./(sqrt(Normal1(newindices).^2 + Normal2(newindices).^2 + Normal3(newindices).^2).*norm(rlight));
        % Zusammensetzen der Matrix
        I_diff(:,:,1) = I_diff1;
        I_diff(:,:,2) = I_diff2;
        I_diff(:,:,3) = I_diff3;
end

% Befuellen der Matrix
I_amb1(indices) = amb(1);
I_amb2(indices) = amb(2);
I_amb3(indices) = amb(3);

% Zusammensetzen der Matrix
I_amb(:,:,1) = I_amb1;
I_amb(:,:,2) = I_amb2;
I_amb(:,:,3) = I_amb3;

% Glanzpunkte
if spec == 1 % Glanzpunkt ja
    % Vorbelegung
    mirror = zeros(size(rays));
    % Schleife ueber Gitterpunkte zum Befuellen
    for i = 1:size(rays,1)
        for j = 1:size(rays,2)
            % Prueft ob Schnittpunkt mit Objekt vorhanden
            if bool(i,j)>0
                % berechnen Householder-Matrix
                H = eye(3) - 2* (squeeze(Normal(i,j,:)) * squeeze(Normal(i,j,:))')./(norm(squeeze(Normal(i,j,:)))^2);
                % berechnen der gespiegelten Lichtstrahlvektoren
                mirror(i,j,:) = H*(squeeze(Surface(i,j,:)) - lamp);
                % Skalarprodukt Blickstrahl und gespiegelter Lichtstrahl
                a = dot(-squeeze(rays(i,j,:)),squeeze(mirror(i,j,:)));
                if a > 0
                    % Winkelberechnung mit Verkettung mit cos^(10)
                    I_spec(i,j,:) = [1;1;1] .* (a./(norm(squeeze(rays(i,j,:)))*norm(squeeze(mirror(i,j,:))))).^10;
                end
            end
        end
    end
    
end
% Berechnung Beleuchtungsmodell
Light = I_diff +I_amb+I_spec;
end