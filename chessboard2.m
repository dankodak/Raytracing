function y = chessboard2(x,a,b)
% a= Farbwert des einen Karos
% b= Farbwert des anderen Karos
% x= die zu ueberpruefenden Punkte in Vektor
% y= Vektor mit a,b als Chessfarbe

% x wird zu Matrix mit Vektoren als Zeilen
X = reshape(x,[length(x)/3,3]);
% Vorbelegung
y = zeros(length(x)/3,1);
% quadergroesse
c=3;

% Iteration ueber jeden einzelnen Zeilenvektor in X
for i = 1:length(x)/3
    % Abfrage welcher Quadrant
    if mod(floor(X(i,1)/c),2) == 1 && mod(floor(X(i,2)/c),2) == 0 && mod(floor(X(i,3)/c),2) == 0
        y(i)=a;    
    elseif mod(floor(X(i,1)/c),2) == 1 && mod(floor(X(i,2)/c),2) == 1 && mod(floor(X(i,3)/c),2) == 0
        y(i)=b;
    elseif mod(floor(X(i,1)/c),2) == 1 && mod(floor(X(i,2)/c),2) == 0 && mod(floor(X(i,3)/c),2) == 1
        y(i)=b;
    elseif mod(floor(X(i,1)/c),2) == 1 && mod(floor(X(i,2)/c),2) == 1 && mod(floor(X(i,3)/c),2) == 1
        y(i)=a;
    elseif mod(floor(X(i,1)/c),2) == 0 && mod(floor(X(i,2)/c),2) == 0 && mod(floor(X(i,3)/c),2) == 0
        y(i)=b;
    elseif mod(floor(X(i,1)/c),2) == 0 && mod(floor(X(i,2)/c),2) == 1 && mod(floor(X(i,3)/c),2) == 0
        y(i)=a;
    elseif mod(floor(X(i,1)/c),2) == 0 && mod(floor(X(i,2)/c),2) == 0 && mod(floor(X(i,3)/c),2) == 1
        y(i)=a;
    elseif mod(floor(X(i,1)/c),2) == 0 && mod(floor(X(i,2)/c),2) == 1 && mod(floor(X(i,3)/c),2) == 1
        y(i)=b;
    end
end
end