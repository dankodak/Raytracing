function[Rho]= grayscale(f,N,rays)
    Rho= zeros(size(N));
    for k=1:5:size(rays,1)/5
        for  i =1:size(rays,1)
            for j=1:size(rays,2)
                if(k<i<5+k && k<j<5+k)
                    if(mod(k,2)== 0)
                        Rho(i,j)=1;
                    end
                end
            end
        end
    end
    
end