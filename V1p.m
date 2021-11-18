function [thetas, f1, f2, f3] = V1p(A, B, C, a, b, psi)

k = pi/3;
theta = pi/4 : pi/180 : pi/2;
D = sqrt(a^2 + b^2);
gamma = atan(b/a);

E = sqrt(A^2 + D^2 - 2*A*D*cos(theta - gamma));
alfa = asin(A*sin(theta - gamma)./E);
beta = acos((E.^2 + C^2 - B^2)./(2*E.*C));
phi = acos((B^2 + C^2 - E.^2)./(2*B*C));

F = sqrt(C^2 + D^2 -2*C*D*cos(alfa + beta));
delta = acos((B^2 + A^2 - F.^2)./(2*A*B));

theta_f1 = theta;
theta_f2 = pi - delta;
%theta_f3 =  phi - pi/2;
theta_f3 = (phi + psi - pi);
theta_t = pi - (pi/2 - gamma + alfa + beta + k);

thetas = [theta_f1 ; theta_f2 ; theta_f3; theta_t];

for i = 1:1:45
    
   f1ott(i) = -(C*(D*sin(theta_t(i) + pi/2 - gamma + k) - A*sin(theta_t(i) + pi/2 - gamma + k - theta_f1(i) + gamma)))/(A*(D*sin(theta_f1(i) - gamma) - C*sin(theta_t(i) + pi/2 - gamma + k - theta_f1(i) + gamma)));
   ttof1(i) = (1/f1ott(i)) ;

   f2of1(i) = A*sin(theta_t(i) + pi/2 - gamma + k - theta_f1(i) + gamma)/(A*sin(theta_t(i) + pi/2 - gamma + k - theta_f1(i) + gamma) - D*sin(theta_t(i) + pi/2 - gamma + k)) - 1;
   f1of2(i) = 1/f2of1(i); 

   f1of3(i) = (B*C*sin(phi(i)))/(A*D*sin(theta_f1(i) - gamma));
   f3of1(i) = 1/f1of3(i);

   ttof2(i) = ttof1(i)*f1of2(i);

   ttof3(i) = ttof1(i)*f1of3(i);

   f2of3(i) = f2of1(i)*f1of3(i);
   
end

k1 = 0.5*A;
k2 = 0.5*B;
k3 = 0.5*B;


for i = 1:1:45
    
   t = -(theta_t(i) - theta_t(45)) ;

    
   J1 = [1 0; -sin(theta_f1(i)) k1];
   T1 = [0 ttof1(i)];  
   x = -(J1^(-1))'*T1'*t;
   f1(1, i) = x(1);
   f1(2, i) = x(2);

   j222 = f1of2(i)*(A*cos(theta_f2(i)) + k2) + k2;
   J2 = [1, 0; (-sin(theta_f1(i) + theta_f2(i))), j222];
   T2 = [0, ttof2(i)];
   y = -(J2^(-1))'*T2'*t;
   f2(1, i) = y(1);
   f2(2, i) = y(2);
   
   j322 = f1of3(i)*(A*cos(theta_f2(i) + theta_f3(i)) + B*cos(theta_f3(i)) +k3) + f2of3(i)*(B*cos(theta_f3(i)) + k3) +k3;
   J3 = [1, 0; (-sin(theta_f1(i) + theta_f2(i) + theta_f3(i))), j322];
   T3 = [0 ttof3(i)];
   z = -(J3^(-1))'*T3'*t;
   f3(1, i) = z(1);
   f3(2, i) = z(2);
end
end