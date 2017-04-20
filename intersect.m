function bool = intersect(f,rays,eye)
%Erstelle die Funktion, die auf eine NS überprüft werden muss
% gerade = @(rays,eye,t) eye + t*rays;
% ger = @(t) gerade(rays, eye,t);
% composition = @(t)f(ger(t));

gerade = @(t) (eye + t*rays);
composition = @(t) f(gerade(t));


%Berechnen der NS
x = fzero(composition,0);

if x>0
    bool = norm(x*rays);
else
    bool = 0;
end
end