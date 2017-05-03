function [Normal]= normalvector(f,N,eye,rays)

Normal = zeros(size(rays));
h=0.000000001;

for i = 1:3
    rays(:,:,i) = eye(i) + N(:,:).*rays(:,:,i); 
end

Normal(:,:,1)=(f(rays(:,:,1)+h,rays(:,:,2),rays(:,:,3))-f(rays(:,:,1),rays(:,:,2),rays(:,:,3)))./h;
Normal(:,:,2)=(f(rays(:,:,1),rays(:,:,2)+h,rays(:,:,3))-f(rays(:,:,1)+h,rays(:,:,2),rays(:,:,3)))./h;
Normal(:,:,3)=(f(rays(:,:,1),rays(:,:,2),rays(:,:,3)+h)-f(rays(:,:,1)+h,rays(:,:,2),rays(:,:,3)))./h;
end