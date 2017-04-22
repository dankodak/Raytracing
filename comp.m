function A = comp(f,N, rays, eye)
%f = Körperfunktion von R3 nach R1
%N = Stellen, an denen ausgewertet wird
%rays = Strahlengeraden
%eye isch klar
%A = Funktionswerte der Komposition von Funktion f und Strahl von R nach R

%Gerade von R nach R3
gerade = @(t,k,l) (eye + t.*squeeze(rays(k,l,:)));
A = zeros(size(rays,1),size(rays,2));

for i=1 : size(rays,1)
    for j = 1 : size(rays,2)
        %Funktionswerte einspeichern
        A(i,j) = f(gerade(N(i,j),i,j));
    end
end
end
