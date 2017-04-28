function y = chessboard(x)

if mod(floor(x(1)),2) == 1 && mod(floor(x(2)),2) == 0 && mod(floor(x(2)),2) == 0
    
elseif mod(floor(x(1)),2) == 1 && mod(floor(x(2)),2) == 1 && mod(floor(x(2)),2) == 0
    
elseif mod(floor(x(1)),2) == 1 && mod(floor(x(2)),2) == 0 && mod(floor(x(2)),2) == 1
    
elseif mod(floor(x(1)),2) == 1 && mod(floor(x(2)),2) == 1 && mod(floor(x(2)),2) == 1
    
elseif mod(floor(x(1)),2) == 0 && mod(floor(x(2)),2) == 0 && mod(floor(x(2)),2) == 0
    
elseif mod(floor(x(1)),2) == 0 && mod(floor(x(2)),2) == 1 && mod(floor(x(2)),2) == 0
    
elseif mod(floor(x(1)),2) == 0 && mod(floor(x(2)),2) == 0 && mod(floor(x(2)),2) == 1
    
elseif mod(floor(x(1)),2) == 0 && mod(floor(x(2)),2) == 1 && mod(floor(x(2)),2) == 1
    
end


end