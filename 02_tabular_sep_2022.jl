using BenchmarkTools
using CSV
using DataFrames
using MLJ
using XGBoost
using Plots
using TimeSeries

input_path = "C:\\data\\kaggle\\tabular-playground-series-sep-2022";

print(input_path * "\n")

data_train = CSV.read(input_path * "\\train.csv", DataFrames.DataFrame);
data_test = CSV.read(input_path * "\\test.csv", DataFrames.DataFrame);

n = size(data_train, 1)
print("nrows : ", n)
print("\n")
print(levels(data_train.store))
print("\n")
print(levels(data_train.product))
print("\n")

function complex_filter(country, store, product, date)::Bool
  filter_country = eval(country == "Belgium")
  filter_store = eval(store == "KaggleMart")
  filter_product = eval(product == "Kaggle Getting Started")
  filter_date = eval(Dates.year(date) <= 2021)
  filter_country && filter_store && filter_product && filter_date
end

p1 = filter([:country, :store, :product, :date] => complex_filter,
                  data_train)

p1_train = TimeArray(p1; timestamp = :date)

function complex_filter(country, store, product, date)::Bool
  filter_country = eval(country == "Belgium")
  filter_store = eval(store == "KaggleMart")
  filter_product = eval(product == "Kaggle Recipe Book")
  filter_date = eval(Dates.year(date) <= 2021)
  filter_country && filter_store && filter_product && filter_date
end

p2 = filter([:country, :store, :product, :date] => complex_filter,
                  data_train)

p2_select = p2[!, [:date, :num_sold]]
CSV.write(input_path * "\\recipe_book.csv", p2_select)

p2_train = TimeArray(p2; timestamp = :date)

function complex_filter(country, store, product, date)::Bool
  filter_country = eval(country == "Belgium")
  filter_store = eval(store == "KaggleMart")
  filter_product = eval(product == "Kaggle Advanced Techniques")
  filter_date = eval(Dates.year(date) <= 2021)
  filter_country && filter_store && filter_product && filter_date
end

p3 = filter([:country, :store, :product, :date] => complex_filter,
                  data_train)

p3_train = TimeArray(p3; timestamp = :date)

function complex_filter(country, store, product, date)::Bool
  filter_country = eval(country == "Belgium")
  filter_store = eval(store == "KaggleMart")
  filter_product = eval(product == "Kaggle for Kids: One Smart Goose")
  filter_date = eval(Dates.year(date) <= 2021)
  filter_country && filter_store && filter_product && filter_date
end

p4 = filter([:country, :store, :product, :date] => complex_filter,
                  data_train)

p4_train = TimeArray(p4; timestamp = :date)

plot(p1_train[:num_sold], label="Getting Started", legend=:best)
plot!(p2_train[:num_sold], label="Recipe Book")
plot!(p3_train[:num_sold], label="Advanced Techniques")
plot!(p4_train[:num_sold], label="Kaggle for Kids")
