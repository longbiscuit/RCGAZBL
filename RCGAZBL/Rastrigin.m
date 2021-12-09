function y = Rastrigin(x)
% Rastrigin function
% Matlab Code by A. Hedar (Sep. 29, 2005).
% Last updated by Ahmed Tawfik (Apr. 30, 2013).
% -5.12 <= x <= 5.12 
n = length(x); 
s = 0;
for j = 1:n
    s = s+(x(j)^2-10*cos(2*pi*x(j))); 
end
y = 10*n+s;