function y = comp(f,N, rays, eye,h)
% f = Körperfunktion von R3 nach R1
% N = Stellen, an denen ausgewertet wird
% rays = Strahlengeraden
% eye isch klar
% A = Funktionswerte der Komposition von Funktion f und Strahl von R nach R
% y = Newtonquotient

% Vorbelegung
A = zeros(size(rays,1),size(rays,2));
B = A;
C = zeros(size(rays));
D = C;

% C = Oberflaechenpunkt 
% D = knapp neben Oberflachenpunkt
for i = 1:3
    C(:,:,i) = eye(i) + N(:,:).*rays(:,:,i);
    D(:,:,i) = eye(i) + (N(:,:) + h).*rays(:,:,i);
end
% A = f(x)
% B = f'(x)
A(:,:) = f(C(:,:,1),C(:,:,2),C(:,:,3));
B(:,:) = f(D(:,:,1),D(:,:,2),D(:,:,3));

% Berechnung Quotent mit Newton
y = A./((B - A)./h);
end