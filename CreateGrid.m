function [A] = CreateGrid(width, height, p, dist, r1, r2)
%width = Gitterbreite
%height = Gitterh�he
%p = Punkt unten links
%dist = Gitterweite
%disteye = Distanz zum Auge
%r1= erster Richtungsvektor
%r2= zweiter Richtungsvektor
%(orthogonal zueinander)

A = zeros(height+1, width+1, 3);

%Richtungsvektoren skalieren
r1 = r1*dist/norm(r1);
r2 = r2*dist/norm(r2);

%Gitter erstellen
for i=0:height
    for j=0:width
        A(i+1,j+1,1:3)= p + (i)*r1 + (j)*r2;
    end
end

%Auge
center = p + 1/2*width*r2 + 1/2*height*r1;
normal = cross(r1,r2);
end