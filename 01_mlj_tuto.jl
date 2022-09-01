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
print("\n")

# Calcul du nombre de valeurs manquantes dans la colonne measurement_3
nMissings = length(findall(x -> ismissing(x), data_train.measurement_3));
nMissings_share = nMissings/size(data_train)[1] * 100
print("% Valeurs Manquantes : ", nMissings_share)
print("\n")

# Traitement des données manquantes avec la moyenne par produit
@benchmark for col in names(data_train, any.(ismissing, eachcol(data_train)))
    print("Traitement de la colonne : " * col * "\n")
    for group in groupby(data_train, :product_code)
        group[ismissing.(group[!,col]), col] .= mean(skipmissing(group[!,col]))
    end
end
