%Inicializar variables
num_samples = size(Train,1);
%Etiqueta 1 para no HD
num_no_presenceHD = sum(Train(:,13) ==  1);
%Etiqueta 2 para HD
num_presence_HD = sum(Train(:,13) ==  2);
prob_apriori_ben = num_no_presenceHD / num_samples;
prob_apriori_mal = num_presence_HD / num_samples;
%Crear matriz tamaño (Atributos , Valores)
freq_no_presenceHD = zeros(12 , 5);
freq_presenceHD = zeros(12 , 5);
Train_Puro = Train(:,1:12);

%Recorrer num_samples
for i=1 : num_samples
    %Recorrer cada atributo dentro de el sample i
    for j=1 : size(Train_Puro,2)
        valor_actual=Train_Puro(i,j);
        %En caso de ser benigno aumentar 1 de frecuencia en el sample i, atributo j
        if(Train(i,13) == 1)
            freq_no_presenceHD(j,valor_actual) = freq_no_presenceHD(j,valor_actual) + 1;
        end
        %En caso de ser maligno aumentar 1 de frecuencia en el sample i, atributo j
        if(Train(i,13) == 2)
            freq_presenceHD(j,valor_actual) = freq_presenceHD(j,valor_actual) + 1;
        end
    end
end

freq_no_presenceHD = freq_no_presenceHD + 1;
freq_presenceHD = freq_presenceHD + 1;

%Sacar probabilidades

prob_benignos = zeros(size(freq_no_presenceHD));
prob_malignos = zeros(size(freq_presenceHD));
num_atributos = size(prob_benignos,1);
num_valores = size(prob_benignos,2);
for i = 1 : num_atributos
    for j = 1 : num_valores
        prob_benignos(i,j) =  freq_no_presenceHD(i,j) / sum(freq_no_presenceHD(i,:));
        prob_malignos(i,j) =  freq_presenceHD(i,j) / sum(freq_presenceHD(i,:));
    end
end

%Probar el algoritmo
Test_Puro = Test(:,1:12);
%Sacar transpuestas para mejor organizacion
prob_benignos = transpose(prob_benignos);
prob_malignos = transpose(prob_malignos);
%Vector que nos dira si cada caso del test es benigno(2) o maligno(4)
Asignaciones = zeros(size(Test_Puro,1),1);
for i = 1 : size(Test_Puro,1)
    prob_no_presenceHD=prob_apriori_ben;
    prob_presenceHD=prob_apriori_mal;
    for j = 1 : size(Test_Puro,2)
        prob_no_presenceHD = prob_no_presenceHD * prob_benignos(Test_Puro(i,j) , j);
        prob_presenceHD = prob_presenceHD * prob_malignos(Test_Puro(i,j) , j);
        
    end
    if(prob_no_presenceHD > prob_presenceHD)
        Asignaciones(i) = 1;
    else
        Asignaciones(i) = 2;
    end
end

porcentajeSimilitud(Asignaciones, Test(:,13))

