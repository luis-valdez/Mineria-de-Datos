%Inicializar variables
num_samples = size(Train,1);
num_benignos = sum(Train(:,11) ==  2);
num_malignos = sum(Train(:,11) ==  4);
prob_apriori_ben = num_benignos / num_samples;
prob_apriori_mal = num_malignos / num_samples;
freq_benignos = zeros(9 , 10);
freq_malignos = zeros(9 , 10);
Train_Puro = Train(1:num_samples,2:10);

%Recorrer num_samples
for i=1 : num_samples
    %Recorrer cada atributo dentro de el sample i
    for j=1 : size(Train_Puro,2)
        valor_actual=Train_Puro(i,j);
        %En caso de ser benigno aumentar 1 de frecuencia en el sample i, atributo j
        if(Train(i,11) == 2)
            freq_benignos(j,valor_actual) = freq_benignos(j,valor_actual) + 1;
        end
        %En caso de ser maligno aumentar 1 de frecuencia en el sample i, atributo j
        if(Train(i,11) == 4)
            freq_malignos(j,valor_actual) = freq_malignos(j,valor_actual) + 1;
        end
    end
end

freq_benignos = freq_benignos + 1;
freq_malignos = freq_malignos + 1;


