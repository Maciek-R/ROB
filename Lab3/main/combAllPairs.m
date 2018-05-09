function res = combAllPairs(list)
  list = sort(list');
  res = [];
  for i=1:rows(list)
    for j=i+1:rows(list)
      res = [ res ; [ list(i) list(j) ] ];
    end
  end
end