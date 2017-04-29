function r = ray(grid, eye)
%grid = Gitter
%eye = Auge
%r = Matrix mit Richtungsvektoren der Strahlen

r = zeros(size(grid,1),size(grid,2),3);

for i = 1:3
    r(:,:,i) = (grid(:,:,i) - eye(i))./norm(grid(:,:,i) - eye(i));
end

end