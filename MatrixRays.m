function A = MatrixRays(grid,eye)
%A = Matrix mit Funktionen der Strahlengeraden
%absolut unnötig
A = @(x) ray(grid,eye)*x+grid;
end