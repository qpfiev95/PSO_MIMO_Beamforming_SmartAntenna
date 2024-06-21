function particle = makeunique( particle )
a = zeros(1,numel(particle));
for i = 1 : (numel(particle) - 1)
    for j = i+1 : numel(particle)
        if particle(i).Cost == particle(j).Cost
        a(j) = 1;
        end
    end
end

b = find(a == 1);
for i = 1 : numel(b)
    c(i) = i - 1;
end
if b ~= 0
b = b - c;
end
 if b ~= 0
      for j = 1 : numel(b)-1
         particle(b(j)) = [];
          
      end
else
end
end


