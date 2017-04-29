function a = objects(number)

if number == 1
    %Sphaere
    a = @(x,y,z) (x+2).^2+(y+7).^2+(z-7).^2 -16;
    %a = @(x,y,z) x.^2+y.^2+z.^2+2*x.*y.*z-1
    %a = @(x,y,z) x.^2 + y.^2 + z.^2 -16;
elseif number == 2
    %Torus
    a = @(x,y,z) (x.^2+y.^2+z.^2+16-4).^2-4.*16.*(y.^2+z.^2);
elseif number == 3
    %Rueckwand
    a = @(x,y,z) x + 12;
elseif number == 4
    %Boden
    a = @(x,y,z) y - 12;
elseif number == 5
    %Decke
    a = @(x,y,z) y + 12;
elseif number == 6
    
elseif number == 7
    
end




end