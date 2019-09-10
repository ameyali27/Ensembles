function C = simil(file)

nvec = vecnorm(file); %compute norm of each colum of Rasterbin (Rb)
Rb = length(file);

%si = nan(Rb);
for i=1:Rb-1
    for ii = 1:Rb
        si(i,ii) = dot(file(:,i),file(:,ii))./(nvec(i)*nvec(ii));%si=similarity index, compute dot product of all possible vector pairs and divide by the norm of each vector   
    end  
end

C = si;

end