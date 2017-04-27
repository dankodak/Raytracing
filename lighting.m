function [Light]=lighting(lamp,amb,dir,f,N,eye,rays,bool)
rho=1;
Normal = normalvector(f,N,eye,rays);
Light=zeros(size(N));
I_diff = Light;
for i =1:size(rays,1)
    for j=1:size(rays,2)
        if bool(i,j)>0
            a = dot(squeeze(Normal(i,j,:)),lamp);
            if a> 0
                I_diff(i,j) = dir .* rho .* norm(a)./(norm(squeeze(Normal(i,j,:))).*norm(lamp));
            end
        end
    end
end
Light = I_diff;
end