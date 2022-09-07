using BenchmarkTools
using CSV
using DataFrames
using MLJ
using XGBoost
using Plots
using TimeSeries
using Dates

input_path = "C:\\data\\kaggle\\tabular-playground-series-sep-2022"

print(input_path * "\n")

data_train = CSV.read(input_path * "\\train.csv", DataFrames.DataFrame);
data_test = CSV.read(input_path * "\\test.csv", DataFrames.DataFrame);

# Structure du DataFrame "data_train"
print(schema(data_train))

# Données statistiques du DataFrame "data_train"
print(DataFrames.describe(data_train))
print("\n")

belgium = subset(data_train, :country => ByRow(==("Belgium")) )

dates = [Date(2021,1),Date(2021,2),Date(2021,3)];
yms = [yearmonth(d) for d in dates];

annee = data_train[in(yms).(yearmonth.(data_train.date)), :]

function complex_filter(country, date)::Bool
  interesting_country = eval(country == "Belgium")
  interesting_date = eval(Dates.year(date) == 2020)
  interesting_country && interesting_date
end

belgium_filter = filter([:country, :date] => complex_filter, data_train)

# plot(1:n, sold, ylabel="Sold (num.)", label="data", xlabel = "Time (days)")
#         , xticks=0:365:n)

print(DataFrames.describe(belgium))
print("\n")

n = size(belgium, 1)
print("nrows : ", n)

print("\n")
print(levels(belgium.store))
print("\n")
print(levels(belgium.product))

sold = belgium[!,"num_sold"]

plot(1:n, sold, ylabel="Sold (num.)", label="Belgium", xlabel = "Time (days)")
