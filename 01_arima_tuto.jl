# Import Turing, Distributions, StatsBase, DataFrames and CSV, HypothesisTests and LinearAlgebra
using Turing, Distributions, StatsBase, DataFrames, CSV, HypothesisTests, LinearAlgebra

# Import MCMCChain, Plots and StatsPlots
using MCMCChains, Plots, StatsPlots

# Set a seed for reproducibility.
using Random
Random.seed!(12);

# Turn off progress monitor.
# Turing.turnprogress(false)

# Load in the dataset downloaded from https://github.com/inertia7/timeSeries_sp500_R/blob/master/data/data_master_1.csv
#MIT License
println("Loading the dataset")
df = CSV.read("C:\\data\\kaggle\\tabular-playground-series-sep-2022\\data_master_1.csv", DataFrames.DataFrame)
df[!, :sp_500]

s = df.sp_500
plot(s)

# Split into training and test sets.
train_percentage = 0.95
s_train = s[1:floor(Int, train_percentage*length(s))]
N = length(s_train)

# Plot the training data
plot(s_train)

print(ADFTest(s_train, Symbol("constant"), 5))

s_diff = diff(s_train)
plot(s_diff)
