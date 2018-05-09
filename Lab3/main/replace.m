function vec = replace(vec, old_elem, new_elem)
  for idx = 1:rows(vec);
    if vec(idx) == old_elem
       vec(idx) = new_elem;
    end
  end
end