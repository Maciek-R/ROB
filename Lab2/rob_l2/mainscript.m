% malutki plik do uruchomienia funkcji pdf
load pdf_test.txt
size(pdf_test)

% ile jest klas?
labels = unique(pdf_test(:,1))

% ile jest pr�bek w ka�dej klasie?
[labels'; sum(pdf_test(:,1) == labels')]
		  % ^^^ dobrze by�oby pomy�le� o tym wyra�eniu

% jak uk�adaj� si� pr�bki?
plot2features(pdf_test, 2, 3)


pdfindep_para = para_indep(pdf_test);
% para_indep jest do zaimplementowania, tak �eby dawa�a:

% pdfindep_para =
%  scalar structure containing the fields:
%    labels =
%       1
%       2
%    mu =
%       0.7970000   0.8200000
%      -0.0090000   0.0270000
%    sig =
%       0.21772   0.19172
%       0.19087   0.27179

% teraz do zaimplementowania jest sama funkcja licz�ca pdf 
pi_pdf = pdf_indep(pdf_test([2 7 12 17],2:end), pdfindep_para)

%pi_pdf =
%  1.4700e+000  4.5476e-007
%  3.4621e+000  4.9711e-005
%  6.7800e-011  2.7920e-001
%  5.6610e-008  1.8097e+000

% wielowymiarowy rozk�ad normalny - parametry ...

pdfmulti_para = para_multi(pdf_test)

%pdfmulti_para =
%  scalar structure containing the fields:
%    labels =
%       1
%       2
%    mu =
%       0.7970000   0.8200000
%      -0.0090000   0.0270000
%    sig =
%    ans(:,:,1) =
%       0.047401   0.018222
%       0.018222   0.036756
%    ans(:,:,2) =
%       0.036432  -0.033186
%      -0.033186   0.073868  

% ... i funkcja licz�ca g�sto��
pm_pdf = pdf_multi(pdf_test([2 7 12 17],2:end), pdfmulti_para)

%pm_pdf =
%  7.9450e-001  6.5308e-017
%  3.9535e+000  3.8239e-013
%  1.6357e-009  8.6220e-001
%  4.5833e-006  2.8928e+000

% parametry dla aproksymacji oknem Parzena
pdfparzen_para = para_parzen(pdf_test, 0.5)
									 % ^^^ szeroko�� okna

%pdfparzen_para =
%  scalar structure containing the fields:
%    labels =
%       1
%       2
%    samples =
%    {
%      [1,1] =
%         1.10000   0.95000
%         0.98000   0.61000
% .....
%         0.69000   0.93000
%         0.79000   1.01000
%      [2,1] =
%        -0.010000   0.380000
%         0.250000  -0.440000
% .....
%        -0.110000   0.030000
%         0.120000  -0.090000
%    }
%    parzenw =  0.50000

pp_pdf = pdf_parzen(pdf_test([2 7 12 17],2:end), pdfparzen_para)

%pp_pdf =
%  9.7779e-001  6.1499e-008
%  2.1351e+000  4.2542e-006
%  9.4059e-010  9.8823e-001
%  2.0439e-006  1.9815e+000


% wreszcie mo�na zaj�� si� kartami!
load train.txt
load test.txt

% poniewa� dane s� w istocie z dw�ch populacji zmieniamy
% etykiety "klienta" na etykiety pasuj�ce do klasyfikacji
for i=77:152:1824
	train(i:i+75,1) += 4;
	test(i:i+75,1) += 4;
end

% pierwszy rzut oka na dane
size(train)
size(test)
labels = unique(train(:,1))
unique(test(:,1))
[labels'; sum(train(:,1) == labels')]

% pierwszym zadaniem po za�adowaniu danych jest sprawdzenie,
% czy w zbiorze ucz�cym nie ma pr�bek odstaj�cych
% do realizacji tego zadania przydadz� si� funkcje licz�ce
% proste statystyki: mean, median, std, 
% wy�wietlenie histogramu cech(y): hist
% spojrzenie na dwie cechy na raz: plot2features (dostarczona w pakiecie)

[mean(train); median(train)]
hist(train(:,1))
plot2features(train, 4, 6)

% do identyfikacji odstaj�cych pr�bek doskonale nadaj� si� wersje
% funkcji min i max z dwoma argumentami wyj�ciowymi

[mv midx] = min(train)

% poniewa� warto�ci minimalne czy maksymalne da si� wyznaczy� zawsze,
% dobrze zweryfikowa� ich odstawanie spogl�daj�c przynajmniej na s�siad�w
% podejrzanej pr�bki w zbiorze ucz�cym

% powiedzmy, �e podejrzana jest pr�bka 58
midx = 58
train(midx-1:midx+1, :)
% tu akurat wysz�y r��ne klasy, wi�c por�wnanie jest trudne...

% je�li nabra�em przekonania, �e pr�bka midx jest do usuni�cia, to:
size(train)
midx = 642
train(midx, :) = [];
midx = 186
train(midx, :) = [];
size(train)

% 642 i 186(w tej kolejności)

% procedur� szukania i usuwania warto�ci odstaj�cych trzeba powtarza� do skutku

% po usuni�ciu warto�ci odstaj�cych mo�na zaj�� si� wyborem DW�CH cech dla klasyfikacji
% w tym przypadku w zupe�no�ci wystarczy poogl�da� wykresy dw�ch cech i wybra� te, kt�re
% daj� w miar� dobrze odseparowane od siebie klasy

plot2features(train, 2, 4)

% Po ustaleniu cech (dok�adniej: indeks�w kolumn, w kt�rych cechy siedz�):
train = train(:, [1 4 6]);  % wybieram 2 i 4, czyli train = train(:, [1 2 4]);
test = test(:, [1 4 6]);

%do wykonania
train = train(:, [1 2 4]);
test = test(:, [1 2 4]);
%

% to nie jest najros�dniejszy wyb�r; 4 i 6 na pewno trzeba zmieni�

% tutaj jawnie tworz� struktur� z parametrami dla klasyfikatora Bayesa 
% (po prawdzie, to dla funkcji licz�cej g�sto�� prawdobie�stwa) z za�o�eniem,
% �e cechy s� niezale�ne

pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001); 
% w sprawozdaniu trzeba podawa� szeroko�� okna (nie liczymy tego parametru z danych!)	

% wyniki do punktu 3
base_ercf = zeros(1,3);
base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
result3 = base_ercf

% wyniki - 0.0263158   0.0049342   0.0241228

% W kolejnym punkcie przyda si� funkcja reduce, kt�ra redukuje liczb� pr�bek w poszczeg�lnych
% klasach (w tym przypadku redukcja b�dzie taka sama we wszystkich klasach - ZBIORU UCZ�CEGO)
% Poniewa� reduce ma losowa� pr�bki, to eksperyment nale�y powt�rzy� 5 (lub wi�cej) razy
% W sprawozdaniu prosz� poda� tylko warto�� �redni� i odchylenie standardowe wsp��czynnika b��du

parts = [0.1 0.25 0.5 1];
rep_cnt = 5; % przynajmniej

% YOUR CODE GOES HERE 
base_ercf = zeros(rep_cnt,3, columns(parts));
base_ercf_4cl = zeros(rep_cnt,3, columns(parts));
for i=1:rep_cnt
  for k=1:columns(parts)
    newParts = repmat([parts(k)], [1;rows(unique(train(:,1)))]);
    reducedToTrain = reduce(train, newParts);
    %params
    pdfindep_para = para_indep(reducedToTrain);
    pdfmulti_para = para_multi(reducedToTrain);
    pdfparzen_para = para_parzen(reducedToTrain, 1/1000);
    %test
    bayes_indep = bayescls(test(:,2:end), @pdf_indep, pdfindep_para);
    a1 = bayes_indep != test(:,1);
    base_ercf(i, 1, k) = mean(a1);
    base_ercf_4cl(i, 1, k) = mean(mod(bayes_indep,4) != mod(test(:,1),4));
   
    bayes_multi = bayescls(test(:,2:end), @pdf_multi, pdfmulti_para);
    a2 = bayes_multi != test(:,1);
    base_ercf(i, 2, k) = mean(a2);
    base_ercf_4cl(i, 2, k) = mean(mod(bayes_multi,4) != mod(test(:,1),4));
  
    bayes_parzen = bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para);
    a3 = bayes_parzen != test(:,1);  
    base_ercf(i, 3, k) = mean(a3);
    base_ercf_4cl(i, 3, k) = mean(mod(bayes_parzen,4) != mod(test(:,1),4));
  end
end
base_ercf;
mean(base_ercf)
mean(base_ercf_4cl)
result4_1 = mean(base_ercf)
result4_2 = mean(base_ercf_4cl)
%


% Punkt 5 dotyczy jedynie klasyfikatora z oknem Parzena (na pe�nym zbiorze ucz�cym)

parzen_widths = [0.0001, 0.0005, 0.001, 0.005, 0.01];
parzen_res = zeros(1, columns(parzen_widths));
parzen_res_4cl = zeros(1, columns(parzen_widths));

% YOUR CODE GOES HERE 
%
for i=1:columns(parzen_widths)
  pdfparzen_para_tmp = para_parzen(train, parzen_widths(i));
  parzen_res(i) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para_tmp) != test(:,1));
  parzen_res_4cl(i) = mean(mod(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para_tmp),4) != mod(test(:,1),4));
end

%   1.0000e-04   5.0000e-04   1.0000e-03   5.0000e-03   1.0000e-02
%   2.8509e-02   1.6996e-02   2.4123e-02   7.9496e-02   1.3925e-01
%
%
%

%[parzen_widths; parzen_res]
result5_1 = [parzen_widths; parzen_res]
result5_2 = [parzen_widths; parzen_res_4cl]
% Tu a� prosi si� do�o�y� do danych numerycznych wykres
semilogx(parzen_widths, parzen_res)
semilogx(parzen_widths, parzen_res_4cl)

% W punkcie 6 redukcja dotyczy ZBIORU TESTOWEGO (nie ma potrzeby zmiany zbioru ucz�cego)
% 
apriori = [0.085 0.165 0.165 0.085 0.085 0.165 0.165 0.085];
parts = [0.5 1.0 1.0 0.5 0.5 1.0 1.0 0.5];

% YOUR CODE GOES HERE 
rep_cnt = 5;
base_ercf = zeros(rep_cnt,3);
base_ercf_4cl = zeros(rep_cnt,3);
for i=1:rep_cnt
  reduced = reduce(test, parts);
  %params
  pdfindep_para = para_indep(train);
  pdfmulti_para = para_multi(train);
  pdfparzen_para = para_parzen(train, 0.001);
  %test
  bayes_indep = bayescls(reduced(:,2:end), @pdf_indep, pdfindep_para, apriori);
  a1 = bayes_indep != reduced(:,1);
  base_ercf(i, 1) = mean(a1);
  base_ercf_4cl(i, 1) = mean(mod(bayes_indep,4) != mod(reduced(:,1),4));
  
  bayes_multi = bayescls(reduced(:,2:end), @pdf_multi, pdfmulti_para, apriori);
  a2 = bayes_multi != reduced(:,1);
  base_ercf(i, 2) = mean(a2);
  base_ercf_4cl(i, 2) = mean(mod(bayes_multi,4) != mod(reduced(:,1),4));
  
  bayes_parzen = bayescls(reduced(:,2:end), @pdf_parzen, pdfparzen_para, apriori);
  a3 = bayes_parzen != reduced(:,1);
  base_ercf(i, 3) = mean(a3);
  base_ercf_4cl(i, 3) = mean(mod(bayes_parzen,4) != mod(reduced(:,1),4));
end
mean(base_ercf)
result6_1 = mean(base_ercf);
result6_2 = mean(base_ercf_4cl);

%


% W ostatnim punkcie trzeba zastanowi� si� nad normalizacj�
std(train(:,2:end))
% Mo�e warto sprawdzi�, jak to wygl�da w poszczeg�lnych klasach?

% Normalizacja potrzebna?
% Je�li TAK, to jej parametry s� liczone na zbiorze ucz�cym
% Procedura normalizacji jest aplikowana do zbioru ucz�cego i testowego

% YOUR CODE GOES HERE 
minTrain = min(train(:,2:end));
maxTrain = max(train(:,2:end));
trainNorm = [train(:,1) (train(:,2:end).-minTrain)./(maxTrain.-minTrain)];
testNorm = [test(:,1) (test(:,2:end).-minTrain)./(maxTrain.-minTrain)];
resCl = zeros(rows(testNorm), 1);
for i=1:rows(testNorm)
  resCl(i) = cls1nn(trainNorm, testNorm(i, 2:end));
end

err = mean(resCl != testNorm(:,1))

pdfindep_para = para_indep(trainNorm);
pdfmulti_para = para_multi(trainNorm);
pdfparzen_para = para_parzen(trainNorm, 1/1000); 

base_ercf = zeros(1,3);
base_ercf(1) = mean(bayescls(testNorm(:,2:end), @pdf_indep, pdfindep_para) != testNorm(:,1));
base_ercf(2) = mean(bayescls(testNorm(:,2:end), @pdf_multi, pdfmulti_para) != testNorm(:,1));
base_ercf(3) = mean(bayescls(testNorm(:,2:end), @pdf_parzen, pdfparzen_para) != testNorm(:,1));
base_ercf;

result7_1 = base_ercf

