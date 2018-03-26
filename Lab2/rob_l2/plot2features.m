function plot2features(tset, f1, f2)
	% rysuje punkty zbioru tset na dwuwymiarowym wykresie
	%  u¿ywaj¹c cech f1 i f2
	% wartoœci¹ funkcji s¹ wspó³rzêdne cech f1 i f2

	% parametry rysowania poszczególnych klas (ograniczone do 8)
	pattern(1,:) = "ks";
	pattern(2,:) = "rd";
	pattern(3,:) = "mv";
	pattern(4,:) = "b^";
	pattern(5,:) = "kd";
	pattern(6,:) = "r^";
	pattern(7,:) = "mc";
	pattern(8,:) = "bd";
	
	
	res = tset(:, [f1, f2]);
	
	% wydobycie wszystkich etykiet pojawiaj¹cych siê w tset
	labels = unique(tset(:,1));
	
	% utworzenie okna wykresu i zablokowanie usuwania zawartoœci
	figure;
	hold on;
	for i=1:size(labels,1)
		idx = tset(:,1) == labels(i);
		plot(res(idx,1), res(idx,2), pattern(i,:));
	end
	hold off;
end
