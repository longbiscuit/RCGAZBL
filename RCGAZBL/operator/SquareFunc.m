

function z = SquareFunc(x)

ts=[0   0
17  0.51
34  0.87
51  1.22
70  1.54
87  1.83
103 2.13
121 2.38
141 2.66
162 2.91
204 3.23
238 3.49
276 3.74
296 3.98
324 4.24];
t=ts(:,1);
s=ts(:,2);
[m,~]=size(ts);
sTheory=zeros(m,1);
Ct=x(1);
ht=x(2);
s0=1;t0=1;
for i=1:m
    sTheory(i)=s0*Ct*log10((t(i)/t0)+10^(ht/Ct))-ht;
end
    z = sum((sTheory-s).^2);

end