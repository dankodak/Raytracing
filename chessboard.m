function y = chessboard(x,a,b)
%a=0.8;
%b=0.7;
c=3;
if mod(floor(x(1)/c),2) == 1 && mod(floor(x(2)/c),2) == 0 && mod(floor(x(3)/c),2) == 0
    y=a;    
elseif mod(floor(x(1)/c),2) == 1 && mod(floor(x(2)/c),2) == 1 && mod(floor(x(3)/c),2) == 0
    y=b;
elseif mod(floor(x(1)/c),2) == 1 && mod(floor(x(2)/c),2) == 0 && mod(floor(x(3)/c),2) == 1
    y=b;
elseif mod(floor(x(1)/c),2) == 1 && mod(floor(x(2)/c),2) == 1 && mod(floor(x(3)/c),2) == 1
    y=a;
elseif mod(floor(x(1)/c),2) == 0 && mod(floor(x(2)/c),2) == 0 && mod(floor(x(3)/c),2) == 0
    y=b;
elseif mod(floor(x(1)/c),2) == 0 && mod(floor(x(2)/c),2) == 1 && mod(floor(x(3)/c),2) == 0
    y=a;
elseif mod(floor(x(1)/c),2) == 0 && mod(floor(x(2)/c),2) == 0 && mod(floor(x(3)/c),2) == 1
    y=a;
elseif mod(floor(x(1)/c),2) == 0 && mod(floor(x(2)/c),2) == 1 && mod(floor(x(3)/c),2) == 1
    y=b;
end
end