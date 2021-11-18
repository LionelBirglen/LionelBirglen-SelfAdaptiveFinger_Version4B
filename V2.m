function [thetas, f1, f2] = V2(A, B, C, gamma, psi)

theta = pi/4 : pi/180 : pi/2;

E = sqrt(A^2 + C^2 - 2*A*C*cos(theta));

alfa = asin(A*sin(theta)./E);
beta = asin(B*sin(gamma)./E);
delta = pi - beta - gamma;
phi = pi - alfa - theta;

X = B*sin(delta)./sin(beta);

theta_f1 = theta;
theta_f2 = phi + delta + psi - pi ;
theta_t = pi - (alfa + beta);
x_t = X;

thetas = [theta_f1 ; theta_f2 ; theta_t ; x_t];

for i = 1:1:45

    x = (2*x_t(i) + 2*C*cos(theta_t(i)) - 2*A*cos(theta_t(i) - theta_f1(i)));
    y = 2*A*x_t(i)*sin(theta_t(i) - theta_f1(i)) - 2*C*x_t(i)*sin(theta_t(i));
    z = (2*C*A*sin(theta_f1(i)) - 2*A*x_t(i)*sin(theta_t(i) - theta_f1(i)));
    
    t = (2*x_t(i) + 2*C*cos(theta_t(i)));
    h = (-2*C*x_t(i)*sin(theta_t(i)));
    u = (2*B*C*sin(theta_f1(i) + theta_f2(i) - pi/2));
    j = (2*B*C*sin(theta_f1(i) + theta_f2(i) - pi/2));
    
    f2oxt(i) = (x*(h + u) - t*(y + z))/((h + j)*(y + z) - y*(h + u));
    
    f1oxt(i) = -(f2oxt(i)*y + x)/(y + z);
    
    ttoxt(i) = f1oxt(i) + f2oxt(i);
    
    xtof1(i) = (1/f1oxt(i));
    xtof2(i) = (1/f2oxt(i));

    f1of2(i) = f1oxt(i)/f2oxt(i);

    f1ott(i) = f1oxt(i)/ttoxt(i);
    ttof1(i) = (1/f1ott(i));

    f2ott(i) = f2oxt(i)/ttoxt(i);
    ttof2(i) = (1/f2ott(i));
    
end

 k1 = 0.5*A;
 k2 = 0.5*A;
 
 for i = 1:1:45
     
  t = [-(theta_t(i) - theta_t(45)), -(x_t(i) - x_t(45))];

  J1 = [1 0; -sin(theta_f1(i)) k1];
  T1 = [0 xtof1(i); 0 ttof1(i)];
  x = -(J1^(-1))'*T1'*t';
  f1(1, i) = x(1);
  f1(2, i) = x(2);

  J2 = [1 0; -sin(theta_f1(i) + theta_f2(i)) f1of2(i)*(A*cos(theta_f2(i))+k2)+k2];
  T2 = [0 xtof2(i); 0 ttof2(i)];
  y = -(J2^(-1))'*T2'*t';
  f2(1, i) = y(1);
  f2(2, i) = y(2);
  
 end
  
end