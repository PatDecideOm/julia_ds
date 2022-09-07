using BenchmarkTools
using CSV
using DataFrames
using MLJ
using XGBoost
using Plots
using TimeSeries

input_path = "C:\\data\\kaggle\\tabular-playground-series-sep-2022";

print(input_path * "\n")

data_train = CSV.read(input_path * "\\recipe_book.csv", DataFrames.DataFrame);

n = size(data_train, 1)
print("nrows : ", n)
print("\n")

recipe_train = TimeArray(data_train; timestamp = :date)

plot(recipe_train[:num_sold], label="Recipe Book", legend=:best)
