function [PorcentajeSimilitud]=porcentajeSimilitud(Vector1, Vector2)
coincidencias=0;
for i = 1 : size(Vector1,1)
    if(Vector1(i) == Vector2(i))
        coincidencias = coincidencias + 1;
    end
end
PorcentajeSimilitud = (coincidencias / size(Vector1,1)) * 100;