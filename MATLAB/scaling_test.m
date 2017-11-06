%% Test script for playing around with scaling and mapping
% mainly for testing out mapping functions from permittivity values to
% image values

%% plot logistic function
%  x = -6:0.1:6;
%  y = sigmf(x,[1 0]);
%  plot(x,y)
%  xlabel('sigmf, P = [1 0]')
%  ylim([0 1])

syms s(t) f(x,a,c) g(x) z(x)
%f(x,a,c) = x+a+c;

% logistic function
f(x,a,c) = 1/(1+exp(-a*(x-c)));
% logit function
g(x) = log(x/(1-x));
% scaled logit
z(x) = 0.5 +(log(x/(1-x))/log(99)/2);

% negative scaled logit
z(x) = -(0.5 +(log(x/(1-x))/log(99)/2)) + 1;

% purely done as test
test = finverse(z);

a = 1;
c = 0;

x = 0.01:0.01:0.99;
z1 = f(x,a,c);
z2 = 0.5 +((g(x)/log(100))/2);
z3 = z(x)
plot(x,z3);
ylim([0 1])

