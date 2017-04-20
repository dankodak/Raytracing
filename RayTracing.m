width = 100;
height = 100;
p = [8;-2.5;-2.5];
dist = 0.05;
disteye = 5;
r1 = [0;1;0];
r2 = [0;0;1];
f = @(x) x(1)^2 + x(2)^2 + x(3)^2 - 16;
g = @(x) x(1) + 6;
h = @(x) x(3) - 6;
k = @(x) x(3) + 6;
l = @(x) x(2) - 6;
m = @(x) x(2) + 6;

[A,eye] = grid(width, height, p, dist, disteye, r1, r2);
B = zeros(height +1, width +1);
%c = A(1,2,:)
%squeeze(c)

for i=0:height
    for j=0:width
        B(i+1,j+1) = intersect(f,ray(squeeze(A(i+1,j+1,:)),eye),eye);
    end
end

for i=0:height
    for j=0:width
        a = intersect(h,ray(squeeze(A(i+1,j+1,:)),eye),eye);
        if (a < B(i+1,j+1) || B(i+1,j+1) == 0) && a ~= 0
            B(i+1,j+1) = a;
        end
    end
end
for i=0:height
    for j=0:width
        a = intersect(g,ray(squeeze(A(i+1,j+1,:)),eye),eye);
        if (a < B(i+1,j+1) || B(i+1,j+1) == 0) && a ~= 0
            B(i+1,j+1) = a;
        end
    end
end
for i=0:height
    for j=0:width
        a = intersect(k,ray(squeeze(A(i+1,j+1,:)),eye),eye);
        if (a < B(i+1,j+1) || B(i+1,j+1) == 0) && a ~= 0
            B(i+1,j+1) = a;
        end
    end
end
for i=0:height
    for j=0:width
        a = intersect(l,ray(squeeze(A(i+1,j+1,:)),eye),eye);
        if (a < B(i+1,j+1) || B(i+1,j+1) == 0) && a ~= 0
            B(i+1,j+1) = a;
        end
    end
end
for i=0:height
    for j=0:width
        a = intersect(m,ray(squeeze(A(i+1,j+1,:)),eye),eye);
        if (a < B(i+1,j+1) || B(i+1,j+1) == 0) && a ~= 0
            B(i+1,j+1) = a;
        end
    end
end
imagesc(B)
%spy(B)