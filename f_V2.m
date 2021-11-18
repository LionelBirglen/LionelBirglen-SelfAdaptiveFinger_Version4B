function [f] = f_V2(A, B, C, gamma, psi)

[thetas, f1, f2] = V2(A, B, C, gamma, psi);

out = isreal(thetas);
xt = thetas(4,:);
s = sum(xt < 0);
s1 = mean(f1(1,2:44)); s11 = isnan(s1);
s2 = mean(f2(2,1:44)); s22 = isnan(s2);

if (out == 0 || s > 0) || (s11 == 1 || s22 == 1)
    
    f = 100;
    
else

a = sum(f1(2,:) < 0);
b = sum(f2(2,:) < 0);

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
%f = cv; dt;
%f = dt;

end
end