function [Light]=lightingWithGlanz(lamp,amb,dir,f,N,eye,rays,bool,rho_color)
%lamp= Standort der Lichtquelle
%amb=ambiente Helligkeit der Szene
%dir=gerichtete Lichtquelle 
%f=Koerperfunktion
%N=Matrix mit Nullstellen der Verknuepfung von Koerperfunktion und Strahl
%rays=Matrix mit Richtungvektoren der Strahlen
%bool=Wahrheitsmatrix mit Schnittpunkt oder ohne Schnittpunkt

rho = grayscale(f,N,rays);    %Albedograuwert der Oberflaeche
Normal = normalvector(f,N,eye,rays);
Light=zeros(size(rays));
I_diff = Light;
I_amb = Light;
I_spec = Light;

Surface= zeros(size(rays));

%Oberflaechenpunkte
for i = 1:3
  Surface(:,:,i) = rays(:,:,i).*N(:,:) + eye(i);
end

%befuellen der Matirx mit Beleuchtungswerten
for i =1:size(rays,1)
    for j=1:size(rays,2)
        %prueft ob Schnittpunkt positiv ist
        if bool(i,j)>0
            a = dot(squeeze(Normal(i,j,:)),lamp);
            if a> 0
                %diffuse, d.h. blickwinkelunabhaengige Helligkeit
                I_diff(i,j,1) = dir .* rho_color(1) .* norm(a)./(norm(squeeze(Normal(i,j,:))).*norm(lamp));
                I_diff(i,j,2) = dir .* rho_color(2) .* norm(a)./(norm(squeeze(Normal(i,j,:))).*norm(lamp));
                I_diff(i,j,3) = dir .* rho_color(3) .* norm(a)./(norm(squeeze(Normal(i,j,:))).*norm(lamp));
            end
        end
        %ambiente, d.h. richtungsunabhaengige Helligkeit
%        I_amb(i,j)= amb .* rho(i,j);
        %I_spec(i,j)=
    end
end
Light = I_diff +I_amb+I_spec;
end