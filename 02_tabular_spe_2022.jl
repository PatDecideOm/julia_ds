using BenchmarkTools
using CSV
using DataFrames
using MLJ
using XGBoost
using Plots
using TimeSeries

input_path = "C:\\data\\kaggle\\tabular-playground-series-sep-2022"

print(input_path * "\n")

data_train = CSV.read(input_path * "\\train.csv", DataFrames.DataFrame);
data_test = CSV.read(input_path * "\\test.csv", DataFrames.DataFrame);

ta_train = TimeArray(data_train; timestamp = :date)

plot(ta_train[:num_sold])
