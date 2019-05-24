heart2=heart(:,1:12)
heart2(:,13) = heart(:,14)

heart2 = heart2 + 1
heart_normalized = normalize_matrix(heart2(:,1:12),4)
heart_normalized = heart_normalized + 1
heart_normalized(:,13) = heart2(:,13)

Train = heart_normalized(1:131,1:13)
Train = [Train ; heart_normalized(166:275,1:13)]

Test = heart_normalized(132:165,1:13)
Test = [Test ; heart_normalized(276:303,1:13)]