using MLJ
ImageClassifier = @load ImageClassifier
model = ImageClassifier(epochs=10, acceleration=CUDALibs())
mach = machine(model, X, y) |> fit!
