function [thetas, f1, f2] = V1(A, B, C, D, psi)

k = pi/3;
theta= pi/4 : pi/180 : pi/2;
 
E = sqrt(A^2 + D^2 - 2*A*D*cos(theta));
alfa = asin(A*sin(theta)./E);
beta = acos((E.^2 + C^2 - B^2)./(2*E*C));

F = sqrt(C^2 + D^2 -2*C*D*cos(alfa + beta));
delta = acos((B^2 + C^2 - E.^2)/(2*B*C));

phi = acos((A^2 + B^2 - F.^2)/(2*A*B));

l=100;

for i = 1:1:46
    if pi - phi(i) <= 0.01
        l = i;
    end
end

phi2 = phi;

if l<100
for i = (l-1):-1:1
    phi2(i) = phi2(i+1) +(phi(i+1) - phi(i));
end
end

theta_f1 = theta;
theta_f2 = (phi + psi - pi);
theta_t2 = (pi - (k + delta));
theta_t1 = (pi-(alfa + beta));

thetas = [theta_f1 ; theta_f2 ; theta_t1 ; theta_t2];

for i = 1:1:45
    
   t1of1(i) = -(A*sin(theta_f2(i) - pi/2))/(D*sin(theta_f1(i) + theta_f2(i) - pi/2) - A*sin(theta_f2(i) - pi/2));
   f1ot1(i) = 1/t1of1(i);

   t2of1(i) = (A*D*sin(theta_f1(i)))/(B*C*sin(delta(i)));
   f1ot2(i) = 1/t2of1(i);

   f2of1(i) = (A*sin(theta_t1(i) - theta_f1(i)))/(A*sin(theta_t1(i) - theta_f1(i)) - D*sin(theta_t1(i))) - 1;
   f1of2(i) = 1/f2of1(i);

   t1of2(i) = t1of1(i)*f1of2(i);

   t2of2(i) = t2of1(i)*f1of2(i);
   
end

k1 = 0.5*A;
k2 = 0.5*A;

for i = 1:1:45
    
   t = [-(theta_t1(i) - theta_t1(45)), -(theta_t2(i) - theta_t2(45))];

   J1 = [1, 0; -sin(theta_f1(i)), k1];
   T1 = [0, t1of1(i); 0, t2of1(i)];
   x = -(J1^(-1))'*T1'*t';
   f1(1, i) = x(1);
   f1(2, i) = x(2);
   
   j22 = f1of2(i)*(A*cos(theta_f2(i)) + k2) + k2;
   J2 = [1, 0; -sin(theta_f1(i) + theta_f2(i)), j22];
   T2 = [0, t1of2(i); 0, t2of2(i)];
   y = -(J2^(-1))'*T2'*t';
   f2(1, i) = y(1);
   f2(2, i) = y(2);
   
end
end
