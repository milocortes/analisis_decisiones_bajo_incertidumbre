### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 09d5a76d-a8ee-4fd2-8fa3-c5a03b81d9ac
using PlutoUI

# ╔═╡ 1b6b2dec-f32f-11ef-3197-9ba115e9897a
md"""
# Variables and Types

The content material is taken from https://techytok.com/from-zero-to-julia/ 

**Table of Contents**
 - [Variables](#Variables)
 - [Types](#Types)
 - [Conclusion](#Conclusion)

In this lesson you will learn what are variables and how to perform simple mathematical operations. 

"""

# ╔═╡ 4272bab1-e254-4de7-885b-0a2a7d8de4dd
md"""
## Variables

Julia is not very different from other language for simple variables, just assign data to a variable.
A few important things:

1. Julia doesn't support member functions: **Never** `variable.function() will appear`, but always `function(variable)` just like in C or Fortran.
2. Variables can be strings, numbers, multidimensional arrays, and higher-level constructs: dictionaries, structs.
3. Understand default types for your system if you're not assigning types explicitly (see [Types](#Types)).

In Julia, variables can be global or local scope. 

"""

# ╔═╡ dea813f9-418f-4f2f-9363-d15f79d72de7
## Ejemplo de una variable global
globalVariable = 10

# ╔═╡ 792ac6aa-1fa4-40fc-956b-d1555d759a2c
begin 
	function run()
	    # local variables  
	    name = "William F Godoy"
	    napples = 10
	    weight = 167.5
	    kids = ( "Mark"=> 4, "Emily"=> 0) 
	    years = [ 2017, 2020 ]
	  
	    # Unlike Python print doesn't add a newline \n by default. 
	    # Julia uses print and println
	    # It understands higher-level objects (e.g. dictionary)
	    println(name)
	    println(napples)
	    println(weight)
	    println(kids)
	    println(years)
	    return
	end 
	
	# run your local function
	run()
end

# ╔═╡ 4873f6c0-aea2-4b35-a458-d4d26dd5359d
md"""
## Types

In Julia every element has a type. The type system is a hierarchical structure: at the top of the tree there is the type `Any`, which means that every element belongs to it, then there are many other sub-types, for example `Number` which includes `Real` and `Complex`, and `Real` contains for example `Int` (integer) numbers and `Float64` numbers.

$(PlutoUI.LocalResource("images/types.jpg", :width => 600))


Julia enables out-of-the-box type safety as types can be explicitly assigned using the `::` notation, this is preferred for high-performance code as the compiler would actually provide checks and optimizations. In Python, the [typing module](https://docs.python.org/3/library/typing.html) was added in v3.5 for type hints.

Types can be retrieved using the `typeof` function. It's good practtice to be aware of default types on your system:
"""

# ╔═╡ f2d825de-c390-47e2-8432-0ba51700c885
begin 

	println("Default types:")
	function runWithoutTypes()
	    name = "William F Godoy"
	    napples = 10
	    weight = 167.5
	    kids = ( "Mark"=> 4, "Emily"=> 0)
	    years = [ 2017, 2020 ]
	  
	    println("name: ", name, " type: ", typeof(name) )
	    println("napples: ", napples, " type: ", typeof(napples))
	    println("weight: ", weight, " type: ", typeof(weight))
	    printstyled(kids, " type: ", typeof(kids), "\n" ; color = :red)
	    println("years: ", years, " type: ", typeof(years))
	    return
	end 
	
	println()
	runWithoutTypes()
	
	println("")
	println("")
	println("Assigned types:")
	function runWithTypes()
	    name::String = "William"
	    napples::Int32 = 10
	    weight::Float32 = 167.5
	    kids::Dict{String,Int32} = Dict( "Mark"=> 4, "Emily"=> 0 )
	    years::Array{Int32,1} = [ 2017, 2020 ]  
	    
	    println("name: ", name, " type: ", typeof(name) )
	    println("napples: ", napples, " type: ", typeof(napples))
	    println("weight: ", weight, " type: ", typeof(weight))
	    printstyled(kids, " type: ", typeof(kids), "\n" ; color = :red)
	    println("years: ", years, " type: ", typeof(years))
	    return
	end
	
	println()
	runWithTypes()
end

# ╔═╡ ca33400a-911f-49f0-b924-4cdb238d4122
md"""
**NOTE: the dictionary type Dict must be typed at least on the right-side of =, otherwise Julia assings a Tuple** 

Although it is possible to change the value of a variable inside a program (it is a variable, after all) it is good programming practice and is also critical for performance that inside a program a variable is “type stable”. This means that if we have assigned `a = 42` it is better not to assign a new value to a which cannot be converted into an Int without losing information, like a `Float64` `a = 0.42` (if we convert a `Float64` to an `Int`, the decimal part gets truncated).

If we know that a variable (such as a) will have to contain values of type `Float64` it is better to initialise it with a value that is already of that type.
"""

# ╔═╡ ede43c6c-0833-43a9-9c0b-29b11e19478a
begin 
	function run_casteo()
	  a = 2 # if we need to operate with ints
	  println("Type of a: ", typeof(a))
	  b = 2.0 # if we need to operate with floats
	  println("Type of a: ", typeof(b))
	    
	  # a = 2.0  # not a good practice, type is Float64 by default
	  # a = convert(Float32, a) # only is required, we aware of truncation
	  println("Type of a: ", typeof(a))
	
	  return
	end
	
	run_casteo()
end

# ╔═╡ fc2eaac7-7b42-4b47-8a9c-2a921a0b716a
md"""
# Conclusion
We have learned what variables are, how to perform basic operations and we have dealt about types.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.61"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.3"
manifest_format = "2.0"
project_hash = "6d1b77f27e79835fc27b2d7e99ab8fcaf37aa976"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "1833212fd6f580c20d4291da9c1b4e8a655b128e"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.0.0"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "7e71a55b87222942f0f9337be62e26b1f103d3e4"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.61"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "6cae795a5a9313bbb4f60683f7263318fc7d1505"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.10"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╠═09d5a76d-a8ee-4fd2-8fa3-c5a03b81d9ac
# ╟─1b6b2dec-f32f-11ef-3197-9ba115e9897a
# ╟─4272bab1-e254-4de7-885b-0a2a7d8de4dd
# ╠═dea813f9-418f-4f2f-9363-d15f79d72de7
# ╠═792ac6aa-1fa4-40fc-956b-d1555d759a2c
# ╟─4873f6c0-aea2-4b35-a458-d4d26dd5359d
# ╠═f2d825de-c390-47e2-8432-0ba51700c885
# ╟─ca33400a-911f-49f0-b924-4cdb238d4122
# ╠═ede43c6c-0833-43a9-9c0b-29b11e19478a
# ╠═fc2eaac7-7b42-4b47-8a9c-2a921a0b716a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
