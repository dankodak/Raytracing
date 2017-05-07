function [Light]=lighting2(rlight,amb,dir,lamp,f,N,Eye,rays,bool,rho_color,chess,spec)
%lamp= Standort der Lichtquelle
%amb=ambiente Helligkeit der Szene (element(0,1)in R^3)
%dir=gerichtete Lichtquelle 
%f=Koerperfunktion
%N=Matrix mit Nullstellen der Verknuepfung von Koerperfunktion und Strahl
%rays=Matrix mit Richtungvektoren der Strahlen
%bool=Wahrheitsmatrix mit Schnittpunkt oder ohne Schnittpunkt
Normal = normalvector(f,N,Eye,rays);
Light = zeros(size(rays));
I_diff = Light;
I_amb = Light;
I_spec = Light;
Surface = zeros(size(rays));
dots = zeros(size(bool));

Normal1 = Normal(:,:,1);
Normal2 = Normal(:,:,2);
Normal3 = Normal(:,:,3);
I_diff1 = zeros(size(rays,1),size(rays,2));
I_diff2 = zeros(size(rays,1),size(rays,2));
I_diff3 = zeros(size(rays,1),size(rays,2));
I_amb1 = zeros(size(rays,1),size(rays,2));
I_amb2 = zeros(size(rays,1),size(rays,2));
I_amb3 = zeros(size(rays,1),size(rays,2));

%Oberflaechenpunkte
for i = 1:3
  Surface(:,:,i) = rays(:,:,i).*N(:,:) + Eye(i);
end
Surface1 = Surface(:,:,1);
Surface2 = Surface(:,:,2);
Surface3 = Surface(:,:,3);

%befuellen der Matirx mit Beleuchtungswerten
if chess == 1
    indices = bool>0;
    dots(indices) = Normal1(indices).*rlight(1) + Normal2(indices).*rlight(2) + Normal3(indices).*rlight(3);
    newindices = dots < 0;
    I_diff1(newindices) = dir .* rho_color(1) .* chessboard2([Surface1(newindices);Surface2(newindices);Surface3(newindices)],1,0) .* abs(dots(newindices))./(sqrt(Normal1(newindices).^2 + Normal2(newindices).^2 + Normal3(newindices).^2).*norm(rlight));
    I_diff2(newindices) = dir .* rho_color(2) .* chessboard2([Surface1(newindices);Surface2(newindices);Surface3(newindices)],0,1) .* abs(dots(newindices))./(sqrt(Normal1(newindices).^2 + Normal2(newindices).^2 + Normal3(newindices).^2).*norm(rlight));
    I_diff3(newindices) = dir .* rho_color(3) .* chessboard2([Surface1(newindices);Surface2(newindices);Surface3(newindices)],0.5,.5) .* abs(dots(newindices))./(sqrt(Normal1(newindices).^2 + Normal2(newindices).^2 + Normal3(newindices).^2).*norm(rlight));
    
    I_diff(:,:,1) = I_diff1;
    I_diff(:,:,2) = I_diff2;
    I_diff(:,:,3) = I_diff3;
else
    indices = bool>0;
    dots(indices) = Normal1(indices).*rlight(1) + Normal2(indices).*rlight(2) + Normal3(indices).*rlight(3);
    newindices = dots < 0;
    I_diff1(newindices) = dir .* rho_color(1) .* abs(dots(newindices))./(sqrt(Normal1(newindices).^2 + Normal2(newindices).^2 + Normal3(newindices).^2).*norm(rlight));
    I_diff2(newindices) = dir .* rho_color(2) .* abs(dots(newindices))./(sqrt(Normal1(newindices).^2 + Normal2(newindices).^2 + Normal3(newindices).^2).*norm(rlight));
    I_diff3(newindices) = dir .* rho_color(3) .* abs(dots(newindices))./(sqrt(Normal1(newindices).^2 + Normal2(newindices).^2 + Normal3(newindices).^2).*norm(rlight));
    
    I_diff(:,:,1) = I_diff1;
    I_diff(:,:,2) = I_diff2;
    I_diff(:,:,3) = I_diff3;

end
    
I_amb1(indices) = amb(1);
I_amb2(indices) = amb(2);
I_amb3(indices) = amb(3);

I_amb(:,:,1) = I_amb1;
I_amb(:,:,2) = I_amb2;
I_amb(:,:,3) = I_amb3;

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

Light = I_diff +I_amb+I_spec;
end