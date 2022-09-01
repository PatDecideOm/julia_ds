using BenchmarkTools
using CSV
using DataFrames
using MLJ
using XGBoost
using Plots

input_path = "C:\\data\\kaggle\\tabular-playground-series-sep-2022"

print(input_path * "\n")

data_train = CSV.read(input_path * "\\train.csv", DataFrames.DataFrame);
data_test = CSV.read(input_path * "\\test.csv", DataFrames.DataFrame);

# Structure du DataFrame "data_train"
# print(schema(data_train))

# Données statistiques du DataFrame "data_train"
print(DataFrames.describe(data_train))
print("\n")

size_train = size(data_train, 1)
print("nrows : ", size_train)

sold = data_train[!,"num_sold"]
