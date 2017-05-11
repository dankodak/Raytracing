width = 100;
height = 100;
p = [10;-2.5;-2.5];
dist = 0.05;
r1 = [0;1;0];
r2 = [0;0;1];
rlight= [-1;-1;0];
lamp= [16;7;7];
amb= [0.2;0.2;0.2];
dir= 1;
eye = [13;0;0]
amount_objects = 4;
chess = [1,0,0,0];
rho =  

RayTracing(width, height, p, r1, r2, dist, eye, newton, rlight, amb, lamp, dir, amount_objects, spec, equations, rho, chess)