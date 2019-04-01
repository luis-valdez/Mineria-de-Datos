import pandas as pd
import matplotlib.pyplot as plt
data = pd.read_csv("D://6to Semestre//Mineria de datos//Mineria//Correlacion//brain_damage.csv")
print(data['Brain Weight'].corr(data['Head Size']))
plt.scatter(data['Brain Weight'],data['Head Size'])
plt.xlabel("Brain Weight")
plt.ylabel("Head Size")
plt.show()




