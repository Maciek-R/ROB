function para = para_parzen(ts, width = 0.0001)
% Liczy parametry dla funkcji pdf_parzen
% ts zbi�r ucz�cy (pr�bka = wiersz; w pierwszej kolumnie etykiety)
% width - szeroko�� okna Parzena 
% para - struktura zawieraj�ca parametry:
%	para.labels - etykiety klas
%	para.samples - tablica kom�rek zawieraj�ca pr�bki z poszczeg�lnych klas
%	para.parzenw - szeroko�� okna Parzena

	labels = unique(ts(:,1));
	para.labels = labels;
	para.samples = cell(rows(labels),1);
	para.parzenw = width;

	for i=1:rows(labels)
		para.samples{i} = ts(ts(:,1) == labels(i), 2:end);
	end
end