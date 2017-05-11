function [Normal]= normalvector(f,N,eye,rays)
% f = Koerperfunktion
% N = Nullstellenmatrix
% eye = Auge
% rays = Strahlen
% Normal = Matrix der Normalenvektoren

% Vorbelegung
Normal = zeros(size(rays));
% Schrittweite
h=0.0000001;

% Schleife zur Berechnung der Oberflaechenpunke
for i = 1:3
    rays(:,:,i) = eye(i) + N(:,:).*rays(:,:,i); 
end

% Berechnung der Normalenvektoren mit numerischer Ableitung
Normal(:,:,1)=(f(rays(:,:,1)+h,rays(:,:,2),rays(:,:,3))-f(rays(:,:,1)-h,rays(:,:,2),rays(:,:,3)))./(2*h);
Normal(:,:,2)=(f(rays(:,:,1),rays(:,:,2)+h,rays(:,:,3))-f(rays(:,:,1),rays(:,:,2)-h,rays(:,:,3)))./(2*h);
Normal(:,:,3)=(f(rays(:,:,1),rays(:,:,2),rays(:,:,3)+h)-f(rays(:,:,1),rays(:,:,2),rays(:,:,3)-h))./(2*h);
end