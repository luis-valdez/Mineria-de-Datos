num_attributes = size(Train_Puro,2);
%Sacar medias y desviaciones

medias_malignos = zeros(num_attributes,1);
desviaciones_malignos = zeros(num_attributes,1);
medias_benignos = zeros(num_attributes,1);
desviaciones_benignos = zeros(num_attributes,1);
for i = 1 : num_attributes
    medias_malignos(i) = mean(malignos(:,i));
    desviaciones_malignos(i) = std(malignos(:,i));
    medias_benignos(i) = mean(benignos(:,i));
    desviaciones_benignos(i) = std(benignos(:,i));
end

