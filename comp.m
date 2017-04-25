function A = comp(f,N, rays, eye)
%f = Körperfunktion von R3 nach R1
%N = Stellen, an denen ausgewertet wird
%rays = Strahlengeraden
%eye isch klar
%A = Funktionswerte der Komposition von Funktion f und Strahl von R nach R


A = zeros(size(rays,1),size(rays,2));
for i = 1:3
    rays(:,:,i) = eye(i) + N(:,:).*rays(:,:,i);
end
A(:,:) = f(rays(:,:,1),rays(:,:,2),rays(:,:,3));

end