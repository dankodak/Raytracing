function y = chessboard2(x,a,b)
%a=0.8;
%b=0.7;
X = reshape(x,[length(x)/3,3]);
y = zeros(length(x)/3,1);
c=3;
for i = 1:length(x)/3
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