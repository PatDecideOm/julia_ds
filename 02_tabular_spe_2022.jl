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

function complex_filter(country, store, product, date)::Bool
  filter_country = eval(country == "Belgium")
  filter_store = eval(store == "KaggleMart")
  filter_product = eval(product == "Kaggle Getting Started")
  filter_date = eval(Dates.year(date) >= 2019)
  filter_country && filter_store && filter_product && filter_date
end

belgium = filter([:country, :store, :product, :date] => complex_filter,
                  data_train)

ta_train = TimeArray(belgium; timestamp = :date)

plot(ta_train[:num_sold])
