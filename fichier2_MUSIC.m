%% clean

clc; clear all; close all;

M =  20; % nb capteurs
N = 500; % lonngueur d'echantillons
varv = 1; % variance bruit
tetas0deg = [40 45]; % degres
vars = [1 1]; % variance du signal d'interet

tetas = tetas0deg.*pi./180; % rad
K = length(tetas0deg); % Juste une source
a1 = (0:M-1).';
A = [exp(-1j*pi.*a1*sin(tetas))];

% s = randn(M, 1); Ca c'est en reel

sn = diag(sqrt(vars/2))*(randn(K,N) + 1i*randn(K,N)); % loi gaussienne imaginaire

vn = sqrt(varv/2)*(randn(M,N) + 1i*randn(M,N)); % vu que le bruit = bruit thermique, autant de vecteur de bruit que de capteurs

Y = A*sn+vn; % ce qui se balade sur le canal/à l'entrée des capteurs

R_chap = zeros(M);
for i_ech = 1:N
    yn = Y(:,i_ech);
    Rn = yn*yn'; % la matrice R mais pourrie vu que c'est que pour un instant donné
    R_chap = R_chap + Rn;
end
R_chap = R_chap/N; % notre vrai R_chap estimé en tant que moyenne

% maintenant qu'on a notre R^ on peut essayer de calculer P^
% on va tatonner pour tater teta, jusqu'à tomber sur un endroit où y a une source
% même si on taffe sur que 5 trucs reçus, avec ces 5 là, + notre filtrage spatial, on arrive à savoir d'où vient quoi

% teta forcement entre -pi/2 et pi/2
d_chaps = [];
yn = Y(:,1);
inter_theta = -pi/2:0.001:pi/2;
for teta_tmp = inter_theta 
    
    eig();
    a_tmp = exp(-1j*pi.*a1*sin(teta_tmp));
    
    
    P_chaps = [P_chaps P_chap];
end

plot(inter_theta*180/pi, abs(P_chaps));
