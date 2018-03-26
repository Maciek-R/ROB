function pdf = pdf_parzen(pts, para)
% Aproksymuje warto�� g�sto�ci prawdopodobie�stwa z wykorzystaniem okna Parzena
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz)
% para - struktura zawieraj�ca parametry:
%	para.samples - tablica kom�rek zawieraj�ca pr�bki z poszczeg�lnych klas
%	para.parzenw - szeroko�� okna Parzena
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	pdf = rand(rows(pts), rows(para.samples));
  for i=1:rows(para.samples)
    sqrt(rows(para.samples{i}));
    width = para.parzenw / sqrt(rows(para.samples{i}));
    for j=1:rows(pts)
      sample = pts(j, :);
      product = ones(rows(para.samples{i}), 1);
	    for k=1:columns(pts)
        product .*= normpdf((para.samples{i})(:, k), sample(k), width);
      end
      pdf(j,i) = mean(product);
    end
  end
end
