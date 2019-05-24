function [probabilidad_acierto]=Bayes_LeaveOneOut(Samples)
num_samples = size(Samples,1);
num_columnas = size(Samples,2);
Asignaciones = zeros(num_samples)
%Inicializar variables
for c=1 : num_samples
    %Nuestro vector de test sera el numero de renglon c de Samples
    Test = Samples(c,:);
    
    %Agregar a Train todo lo que esta antes y despues del renglon c
    Train = Samples;
    Train([c],:) = []; 
    %Etiqueta 1 para no HD
    num_no_presenceHD = sum(Train(:,num_columnas) ==  1);
    %Etiqueta 2 para HD
    num_presence_HD = sum(Train(:,num_columnas) ==  2);
    prob_apriori_noHD = num_no_presenceHD / num_samples;
    prob_apriori_HD = num_presence_HD / num_samples;
    %Crear matriz tamaño (Atributos , Valores)
    %Asumimos que nuestra etiqueta siempre esta en la ultima columna y la
    %quitamos
    freq_no_presenceHD = zeros(num_columnas-1 , 5);
    freq_presenceHD = zeros(num_columnas-1 , 5);
    Train_Puro = Train(:,1:num_columnas-1);

    %Recorrer num_samples
    for i=1 : num_samples-1
        %Recorrer cada atributo dentro de el sample i
        for j=1 : size(Train_Puro,2)
            valor_actual=Train_Puro(i,j);
            %En caso de NO presentar HD aumentar 1 de frecuencia en el sample i, atributo j
            if(Train(i,num_columnas) == 1)
                freq_no_presenceHD(j,valor_actual) = freq_no_presenceHD(j,valor_actual) + 1;
            end
            %En caso de presentar HD aumentar 1 de frecuencia en el sample i, atributo j
            if(Train(i,num_columnas) == 2)
                freq_presenceHD(j,valor_actual) = freq_presenceHD(j,valor_actual) + 1;
            end
        end
    end

    freq_no_presenceHD = freq_no_presenceHD + 1;
    freq_presenceHD = freq_presenceHD + 1;

    %Sacar matriz de probabilidades

    prob_casos_noHD = zeros(size(freq_no_presenceHD));
    prob_casos_HD = zeros(size(freq_presenceHD));
    num_atributos = size(prob_casos_noHD,1);
    num_valores = size(prob_casos_noHD,2);
    for i = 1 : num_atributos
        for j = 1 : num_valores
            prob_casos_noHD(i,j) =  freq_no_presenceHD(i,j) / sum(freq_no_presenceHD(i,:));
            prob_casos_HD(i,j) =  freq_presenceHD(i,j) / sum(freq_presenceHD(i,:));
        end
    end

    %Probar el algoritmo
    Test_Puro = Test(:,1:num_columnas-1);
    %Sacar transpuestas para mejor organizacion
    prob_casos_noHD = transpose(prob_casos_noHD);
    prob_casos_HD = transpose(prob_casos_HD);
    
        prob_no_presenceHD=prob_apriori_noHD;
        prob_presenceHD=prob_apriori_HD;
        %Sacar la probabilidad de que presente o no HD
        for j = 1 : size(Test_Puro,2)
            prob_no_presenceHD = prob_no_presenceHD * prob_casos_noHD(Test_Puro(1,j) , j);
            prob_presenceHD = prob_presenceHD * prob_casos_HD(Test_Puro(1,j) , j);
        end
        %Agregar la prediccion a nuestro vector de asignaciones
        if(prob_no_presenceHD > prob_presenceHD)
            Asignaciones(c) = 1;
        else
            Asignaciones(c) = 2;
        end
    

    
end
probabilidad_acierto=porcentajeSimilitud(Asignaciones, Samples(:,num_columnas))

