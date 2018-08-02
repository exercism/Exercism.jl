using Test
using Exercism

# copy notebook and tests to temp dir
temp_path = mktempdir()
cp("example-exercise.ipynb", joinpath(temp_path, "example-exercise.ipynb"))
cp("example-exercise-tests.jl", joinpath(temp_path, "example-exercise-tests.jl"))

# submission creator
p = pwd()
cd(temp_path)
Exercism.create_submission("example-exercise")
cd(p)
include(joinpath(temp_path, "example-exercise.jl"))
include(joinpath(temp_path, "example-exercise-tests.jl"))
