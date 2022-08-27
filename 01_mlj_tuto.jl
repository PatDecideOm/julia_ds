using BenchmarkTools
using CSV
using DataFrames
using MLJ
using XGBoost

input_path = "C:\\data\\kaggle\\tabular-playground-series-aug-2022"

print(input_path * "\n")

data_train = CSV.read(input_path * "\\train.csv", DataFrames.DataFrame);
data_test = CSV.read(input_path * "\\test.csv", DataFrames.DataFrame);

# Structure du DataFrame "data_train"
# print(schema(data_train))

# Données statistiques du DataFrame "data_train"
print(DataFrames.describe(data_train))
