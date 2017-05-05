function [Light]=lighting(rlight,amb,dir,lamp,f,N,Eye,rays,bool,rho_color,chess,spec)
%lamp= Standort der Lichtquelle
%amb=ambiente Helligkeit der Szene (element(0,1)in R^3)
%dir=gerichtete Lichtquelle 
%f=Koerperfunktion
%N=Matrix mit Nullstellen der Verknuepfung von Koerperfunktion und Strahl
%rays=Matrix mit Richtungvektoren der Strahlen
%bool=Wahrheitsmatrix mit Schnittpunkt oder ohne Schnittpunkt
tic
Normal = normalvector(f,N,Eye,rays);
Light = zeros(size(rays));
I_diff = Light;
I_amb = Light;
I_spec = Light;
Surface = zeros(size(rays));

%Oberflaechenpunkte
for i = 1:3
  Surface(:,:,i) = rays(:,:,i).*N(:,:) + Eye(i);
end

%befuellen der Matirx mit Beleuchtungswerten
if chess == 1
    for i =1:size(rays,1)
        for j=1:size(rays,2)
            %prueft ob Schnittpunkt positiv ist
            if bool(i,j)>0
                a = dot(squeeze(Normal(i,j,:)),rlight);
                if a< 0
                    %diffuse, d.h. blickwinkelunabhaengige Helligkeit
                    I_diff(i,j,1) = dir .* rho_color(1) .* chessboard(squeeze(Surface(i,j,:)),1,0) .* norm(a)./(norm(squeeze(Normal(i,j,:))).*norm(rlight));
                    I_diff(i,j,2) = dir .* rho_color(2) .* chessboard(squeeze(Surface(i,j,:)),0,1) .* norm(a)./(norm(squeeze(Normal(i,j,:))).*norm(rlight));
                    I_diff(i,j,3) = dir .* rho_color(3) .* chessboard(squeeze(Surface(i,j,:)),0.5,0.5) .* norm(a)./(norm(squeeze(Normal(i,j,:))).*norm(rlight));
                end
            end
            %ambiente, d.h. richtungsunabhaengige Helligkeit
            if bool(i,j)==1
                I_amb(i,j,1)= amb(1);
                I_amb(i,j,2)= amb(2);
                I_amb(i,j,3)= amb(3);
            end
        end
    end
else
    for i =1:size(rays,1)
        for j=1:size(rays,2)
            %prueft ob Schnittpunkt positiv ist
            if bool(i,j)>0
                a = dot(squeeze(Normal(i,j,:)),rlight);
                if a< 0
                    %diffuse, d.h. blickwinkelunabhaengige Helligkeit
                    I_diff(i,j,1) = dir .* rho_color(1) .* norm(a)./(norm(squeeze(Normal(i,j,:))).*norm(rlight));
                    I_diff(i,j,2) = dir .* rho_color(2) .* norm(a)./(norm(squeeze(Normal(i,j,:))).*norm(rlight));
                    I_diff(i,j,3) = dir .* rho_color(3) .* norm(a)./(norm(squeeze(Normal(i,j,:))).*norm(rlight));
                end
            end
            %ambiente, d.h. richtungsunabhaengige Helligkeit
            if bool(i,j)==1
                I_amb(i,j,1)= amb(1);
                I_amb(i,j,2)= amb(2);
                I_amb(i,j,3)= amb(3);
            end
        end
    end
end

if spec == 1
    mirror = zeros(size(rays));
    for i = 1:size(rays,1)
        for j = 1:size(rays,2)
            if bool(i,j)>0
                H = eye(3) - 2* (squeeze(Normal(i,j,:)) * squeeze(Normal(i,j,:))')./(norm(squeeze(Normal(i,j,:)))^2);
                mirror(i,j,:) = H*(squeeze(Surface(i,j,:)) - lamp);
                a = dot(-squeeze(rays(i,j,:)),squeeze(mirror(i,j,:)));
                if a > 0
                    I_spec(i,j,:) = [1;1;1] .* (a./(norm(squeeze(rays(i,j,:)))*norm(squeeze(mirror(i,j,:))))).^10;
                end
            end
        end
    end
    
end

toc
Light = I_diff +I_amb+I_spec;
end