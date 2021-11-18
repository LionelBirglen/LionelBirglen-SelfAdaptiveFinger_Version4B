function [f] = f_V1(A, B, C, D, psi)

[thetas, f1, f2] = V1(A, B, C, D, psi);

out = isreal(thetas);

if out == 0
    
    f = 100;
    
else

a = (sum(f1(2,:) < 0));
b = (sum(f2(2,:) < 0));

e = (a + b)/2;

for i = 1:1:44
    
        if f1(2,i) && f2(2,i) >= 0
        
        M = [f1(2,i), f2(2,i)];
        cv_i(i) = abs(std(M)/mean(M));
        
        else
            cv_i(i) = nan;
        end
        
end

cv = mean(cv_i, 'omitnan');

p1 = min((f1(2,:)./f1(1,:)));
p2 = min((f2(2,:)./f2(1,:)));

p11 = max((f1(2,:)./f1(1,:)));
p22 = max((f2(2,:)./f2(1,:))); 

m1 = (f1(2,:)./f1(1,:) - p1)/(p11 - p1);
m2 = (f2(2,:)./f2(1,:) - p2)/(p22 - p2);

d1 = mean(m1(1:44));
d2 = mean(m2(1:44));

dt = (d1 + d2)/2;

%f = 4/10*e + 1/10*cv + 5/10*dt;
f = 1/3*e + 1/3*cv + 1/3*dt;


end
end
