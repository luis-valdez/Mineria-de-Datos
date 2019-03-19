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

%Sacar probabilidades

prob_benignos = zeros(size(freq_benignos));
prob_malignos = zeros(size(freq_malignos));
num_atributos = size(prob_benignos,1);
num_valores = size(prob_benignos,2);
for i = 1 : num_atributos
    for j = 1 : num_valores
        prob_benignos(i,j) =  freq_benignos(i,j) / sum(freq_benignos(i,:));
        prob_malignos(i,j) =  freq_malignos(i,j) / sum(freq_malignos(i,:));
    end
end

%Probar el algoritmo
Test_Puro = Test(1:239,2:10);
%Sacar transpuestas para mejor organizacion
prob_benignos = transpose(prob_benignos);
prob_malignos = transpose(prob_malignos);
%Vector que nos dira si cada caso del test es benigno(2) o maligno(4)
Asignaciones = zeros(size(Test_Puro,1),1);
for i = 1 : size(Test_Puro,1)
    prob_ser_benigno=prob_apriori_ben;
    prob_ser_maligno=prob_apriori_mal;
    for j = 1 : size(Test_Puro,2)
        prob_ser_benigno = prob_ser_benigno * prob_benignos(Test_Puro(i,j) , j);
        prob_ser_maligno = prob_ser_maligno * prob_malignos(Test_Puro(i,j) , j);
        
    end
    if(prob_ser_benigno < prob_ser_maligno)
        Asignaciones(i) = 4;
    else
        Asignaciones(i) = 2;
    end
end

porcentajeSimilitud(Asignaciones, Test(:,11))

