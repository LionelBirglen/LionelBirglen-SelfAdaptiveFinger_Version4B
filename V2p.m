function [thetas, f1, f2, f3] = V2p(A, B, C, D, alfa, beta, psi)

theta_f1 = pi/4 : pi/180 : pi/2;

theta = theta_f1 - (beta - pi/2);
e = D*cos(beta - pi/2);

theta2 = acos((e - A*cos(theta) - C*cos(pi/2 - alfa))/B);

theta_f2 = theta2 - theta;

phi = pi - theta_f2 - theta;

theta_f3 = phi - alfa + psi - pi/2;

x1 = A*sin(theta) + B*sin(theta2) + C*sin(pi/2 - alfa);
x2 = D*cos(pi - beta);

x_t = x1 + x2;

thetas = [theta_f1 ; theta_f2 ; theta_f3 ; x_t];

for i = 1:1:45
    
    f2of1(i) = (-A*sin(theta(i)))/(B*sin(theta2(i))) - 1 ;
    f1of2(i) = 1/f2of1(i);

    v = (-A*sin(theta(i)))/(B*sin(theta2(i)));
    xtof1(i) = A*cos(theta(i)) + B*cos(theta2(i))*v;
    f1oxt(i) = 1/xtof1(i);

    f3of1(i) = - f2of1(i) - 1;
    f1of3(i) = 1/f3of1(i);

    xtof2(i) = xtof1(i)*f1of2(i);
    f2oxt(i) = 1/xtof2(i);

    xtof3(i) = xtof1(i)*f1of3(i);
    f3oxt(i) = 1/xtof3(i);

    f2of3(i) = f2of1(i)*f1of3(i);
    f3of2(i) = 1/f2of3(i);
    
end

k1 = 0.5*A;
k2 = 0.5*B;
k3 = 0.5*A;

for i = 1:1:45

    fs = (x_t(i) - x_t(45));

    J1 = [1 0; -sin(theta_f1(i)) k1];
    T1 = [0 xtof1(i)];
    x = -(J1^(-1))'*T1'*fs;
    f1(1 ,i) = x(1);
    f1(2, i) = x(2);

    j222 = f1of2(i)*(A*cos(theta_f2(i)) + k2) + k2;
    J2 = [1 0; -sin(theta_f1(i) + theta_f2(i)) j222];
    T2 = [0 xtof2(i)];
    y = -(J2^(-1))'*T2'*fs;
    f2(1 ,i) = y(1);
    f2(2, i) = y(2);
    
    j322 = f1of3(i)*(A*cos(theta_f2(i) + theta_f3(i)) + B*cos(theta_f3(i)) +k3) + f2of3(i)*(B*cos(theta_f3(i)) + k3) +k3;
    J3 = [1 0; -sin(theta_f1(i) + theta_f2(i) + theta_f3(i)) j322];
    T3 = [0 xtof3(i)];
    z = -(J3^(-1))'*T3'*fs;
    f3(1 ,i) = z(1);
    f3(2, i) = z(2);
    
end
end
