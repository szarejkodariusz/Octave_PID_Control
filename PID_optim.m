clear;
clc;
%
b = 1;
a1 = 1;
a2 = 3;
a3 = 1;
K0 = tf([b],[1 a1 a2 a3]);
pole(K0)

n = 1000
T = 30
dT = T / n;
t = linspace(0,T,n);
u = 1*ones(n,1);
k_min = [];
Ti_min = [];
Td_min = [];
calka_min = [];
i = 1;
for k = [0.5:0.25:1.5]
  for Ti = [0.5:0.25:1.5]
    for Td = [0.5:0.25:1.5]
      P = k;
      I = tf([1],[Ti 0]);
      D = tf([Td 0],[1]);
      PID_reg = P*(1+I+D);
      main = PID_reg * K0;
      G = feedback(main, 1);
      % Symulacja
      [y, t, x] = lsim (G, u, t);
      er = y - u;
      er_st = er(end);
      %calka = cumsum(t .*( (er - er_st).^2)) * dT;
      calka = sum(t .*( (er - er_st).^2)) * dT;
      k_min(i)  = k;
      Ti_min(i) = Ti;
      Td_min(i) = Td;
      calka_min(i) = calka(end);
      i = i + 1;
    end
  end
end
plot(calka_min,'LineWidth',2)
grid on
[x,i] = min(calka_min);
sprintf('Calka = %f',calka_min(i))
sprintf('K = %f, Ti = %f, Td = %f',k_min(i),Ti_min(i),Td_min(i))