# Backtesting-de-Value-at-Risk

L’une des thématiques majeures pour les organismes financiers consiste en la sécurité et la
fiabilité des systèmes, d'où le besoin de mettre en place des outils de suivi du risque., la
Value at Risk s’impose donc dans ce domaine comme un outil indispensable pour le suivi des
risques sur les placements financiers. La VaR mesure la perte maximale potentielle que peut
subir un investisseur sur un temps déterminé, ce déterminée à partir d’un niveau de
probabilité fixé au départ. Mathématiquement, la VaR se présente comme suit :

VaR α (X) = − inf{x ∈ R; P(X ≤ x) > α} = q1−α(−X)

X représentant le vecteur de rendement de l’actif concerné, une valeur positive de X
s’exprime comme un gain tandis qu’une valeur négative représente une perte. Le paramètre α
quant à lui représente le seuil de confiance sur lequel on veut déterminer la perte potentielle,
plus il est proche de 1, plus il se définit comme un niveau de confiance et vice versa.

La littérature scientifique nous démontre qu’il existe trois procédés différents pour calculer la
Value at Risk, on note parmi ceux-ci :
- La VaR paramétrique ;
- la VaR historique ;
- la VaR de Monte Carlo.

a) VaR paramétrique :
Pour les calculs de la VaR présente dans la suite, on raisonne sous l'hypothèse que notre
portefeuille ne comprend qu’un seul actif, afin d'être plus proche de notre travail.
Ainsi, le calcul de la VaR paramétrique est effectuée de la manière suivante :

VaR = Wo Z1-α (N)^½

Wo représente la valeur du portefeuille au moment du calcul de la Var, ainsi, la VaR se
calcule sur plusieurs périodes prend a chaque période la valeur du portefeuille correspondant.
1-α représente dans cette formule le seuil de confiance fixé au départ, la volatilité reliée à
l’actif et N le nombre de période de calcul. Cette méthode s'avère simple à mettre en œuvre,
son inconvénient se révèle cependant sur le fait qu’elle suppose que les rendements ont une
distribution normale, ce qui n’est pas toujours le cas; elle ne prend pas en compte
l'aplatissement de certaine distribution surtout vers la gauche.

b) VaR historique :

La VaR historique est selon certains auteurs plus complexe à mettre en œuvre dans une
machine de calcul. Elle repose sur l'hypothèse que le passé sert à prédire le futur, ce qui
s'avère souvent faux.

VaR = Wo quantile(1-α, HR)

HR représente ici le vecteur de rendement historique de l’actif financier contenu dans notre
portefeuille, la signification des paramètres Wo et 1-α est la même que présenté ci-dessus.
Cependant, pour que ce résultat soit fiable, il faudrait que la période d'échantillonnage soit
suffisamment longue (n > 100) afin de bien prendre en compte la distribution des rendements,
ce qui n’est pas le cas dans notre travail, cette méthode ne sera donc pas utiliser, notre
période de Backtesting étant sur 50 jours.

 c) VaR de Monte Carlo :
Cette méthode s'avère plus sophistiquée que les deux précédentes. Elle consiste à effectuer un
grand nombre de simulations en utilisant plusieurs scénarios sur variables de marché
susceptibles de faire varier la valeur du portefeuille concerné.
