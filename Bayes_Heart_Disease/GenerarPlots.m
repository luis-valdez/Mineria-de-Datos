%Separar malignos y benignos :P
MapBenignos=Train(:,11)==2;
benignos = Train_Puro(MapBenignos,:);
MapMalignos = Train(:,11)==4;
malignos = Train_Puro(MapMalignos,:);

%Graficar todos los benignos
for i = 1 : size(Train_Puro,2)
    figure(i)
    plot(benignos(:,i), '*')
end

%Graficar todos los malignos
for i = 1 : size(Train_Puro,2)
    figure(i)
    plot(malignos(:,i), '*')
end