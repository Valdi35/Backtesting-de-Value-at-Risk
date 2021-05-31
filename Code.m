%-----------------------------------------
% Calcul de la VaR selon plusieurs methodes
%------------------------------------------

% Chargement des donnees
%pwd
%ls

cd C:\Users\Mayima\
[Date,Open,High,Low,Close,Volume,AdjClose] ...
= textread("SP_1993_2006.tex", ...
"", "delimiter", ",","headerlines",1,"endofline","\r\n") ;
Date = Date(1:length(Open)) ;

% 2 - Extraction annees, mois et jours
an = fix(Date/10000) ;
mois = fix((Date - an*10000)/100);
jour = fix((Date - an*10000 - mois*100));
tps = datenum(an,mois,jour);

% 3 - Representation graphique

plot(tps,AdjClose);
datetick('x',"mm/yyyy");
xlabel("date");
ylabel("AdjClose");
title("Cours de l'indice ajuste a la cloture");

% Question 4
AdjClose = AdjClose(end:-1:1);
tps = tps(end:-1:1);

% Question 5
x = diff(AdjClose)./AdjClose(1:end-1);
plot(x)
title("Rendements de l'indice ajuste a la cloture")
xlabel("Date")
ylabel("Rendement")
datetick('x',2)

%------------------------------------
% Estimation base sur la loi de Gauss
% -----------------------------------

% Question 1
L=250;
n = length(x);
Tstart = find(an(end:-1:2)==1995,1);
Tf = Tstart : n ;
time  = tps(Tstart+1:end);

% Question 2
pkg load statistics;
Q95 = norminv(0.05);
Q99 = norminv(0.01);

%Ecart-type et Value at Risk pour chaque quantile
for t = Tf
  Ef = t-L:t-1;
  stdEmpirique = std(x(Ef));
  i = t-Tstart+1;
  VaR95(i) = Q95*stdEmpirique;
  VaR99(i) = Q99*stdEmpirique;
end

% Question 3 : Representation graphique
plot(time,x(Tstart:end),'k', time,VaR99, time,VaR95);
xlabel("date");
ylabel("VaR");
title("Estimation de la VaR avec distribution Gaussienne");
datetick('x',2);
legend("Rendement","VaR a 99%","VaR a 95%",'Location', 'NorthWest');

% Question 4 : Histogramme

%histfit(x(Tf))
%histogramme sur toute la fenetre d'estimation
histfit(x(Ef));
%histogramme sur une periode inferieure a la fenetre d'estimation
%Ef1 = t-125:t-1;
%histfit(x(Ef1));

% Question 5

%Quantile-quantile plot
qqplot(x(Ef));

% Les valeurs extremes sont omises, certaines pertes
%situes a l'extreme gauche de notre distribution ne sont pas 
%prises en compte avec cette methode.
% Les rendements ne sont pas distribues selon une loi normale

%--------------------------------------------------
% Estimation par la methode de simulation historique
%-------------------------------------------------

for t = Tf
  Ef = t-L:t-1;
  Ret = x(Ef);
  i = t-Tstart+1;
  VaRhist95(i) = quantile(Ret,0.05);
  VaRhist99(i) = quantile(Ret,0.01);
end

%Representation graphique
plot(time,x(Tstart:end),'k', time,VaRhist99, time,VaRhist95);
xlabel("date");
ylabel("VaR");
title("Estimation de la VaR avec simulation historique");
datetick('x',2);
legend("Rendement","VaR hist a 99%","VaR hist a 95%",'Location', 'NorthWest');

%----------------------------------------------------------
% Estimation par la moyenne ponderee des poids exponentiels
%----------------------------------------------------------

%Question1 : Initialisons la methode EWMA par une periode de chauffe sur 
% les 1eres observations

lambda = 0.94;
c = 1/(1-lambda);

poids(1) = (1-lambda);
for k=2:length(Tf)
   poids(k) = poids(k-1)*lambda;
end

%Periode de chauffe sur les rendements les plus recents
poids = poids(end:-1:1);
#plot(time,poids);



%Question2 :
function Y=EWMASTD(X,y)

t=length(X);
for i=1:length(X)-1 
    F(i,:)=((y^(i-1))*(X(t-i,:)-mean(X))^2); 
   Y(i,:)=sqrt((1-y)*(sum(F)+F(i,:))); 
end
   
end


VaRemwa = EWMASTD(x(Tstart:end),lambda);
VaRemwa = VaRemwa'

time  = tps(Tstart+1:end-1);
plot(time,x(Tstart:end-1),'k', time,VaRemwa);
xlabel("date")
ylabel("VaR")
title("Estimation de la VaR avec EWMA")
datetick('x',2)
legend("Rendement","VaR EWMA",'Location', 'NorthWest')


%Question 3 :
%La methode EMWA ne prends pas en compte les variations quotidiennes
%de l'actif, il estime une perte constante dans le temps
