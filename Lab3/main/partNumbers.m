function res = partNumbers(fun, list, dat)
  res = [];
  for i=1:rows(list)
    res = [ res ; fun(list(i, :), dat) ];
  end
end