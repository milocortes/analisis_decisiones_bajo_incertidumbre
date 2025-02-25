### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 82759b62-f341-11ef-2b08-6d161385bc05
md"""
## Arrays

In this section we describe the out-of-the-box support for multidimensional arrays.
In general, Julia follows a model that is very similar to Fortran arrays, while there are high-level functionality that resembles Python's numpy.

A few things:

- Julia uses 1-based index 
- Arrays are memory contiguous and column-based (first index changes the fastest).
- Array must be of the same type (otherwise, they are tuples).

### 1D Vector
A vector is a list of ordered data which share a common type (be it `Int`, `Float`, `String`, or `Any`). Furthermore a vector is a one-dimensional array, and often “vector” and “array” are used a synonyms. Contrarily to the mathematical definition of a vector, in programming a vector is simply a list of values and has no a priori geometrical meaning.

In Julia, to create a vector we use the following syntax:

"""

# ╔═╡ 85b55ac9-5174-4c81-93e3-380389e41bf4


# ╔═╡ e4763113-c824-4b8c-89cc-c51bc8667996
md"""
We can access the members of an array using the indexing syntax: `array_name[index]`, for example, if we want to retrieve the third element of c we type `c[3]`. Contrary to other programming languages, in Julia **indices start at 1**, there is not much to say, it is just like that.
"""

# ╔═╡ b341e258-fc38-42fc-8610-d0a22e971b1d


# ╔═╡ 2fec41da-bffe-40e7-9fc7-ab59310ebd25
md"""
Common functionality, see [here](https://julia.school/julia/arrays/) for more examples:
"""

# ╔═╡ 36563a41-5c43-435a-88b4-6f3fd98e8f9c


# ╔═╡ 80d6f566-a3f9-4d57-947e-5a8ad33b72dd
md"""
### 2D Matrix

2D arrays is how matrices are defined in Julia. The `;` character is used to separate **COLUMNS** (like Fortran, Matlab and R, Julia is column-major, first index is the fastest). Access can be done using the syntax: 
- `A[column,row]`
"""

# ╔═╡ 22b48d03-2b5d-42ce-aba2-54536c44e117


# ╔═╡ 48dbe959-76b6-46d7-a573-ec6cb82bd93f
md"""
### N-Dimensional Arrays

Sometimes we need to create tables with more than 2 dimensions. In this case usually the tables tend to be big, so there is no explicit way to create an n-dimensional array. The suggested practice is to create an array first, and then fill it either manually of using a loop. For several initialization options (zeros, ones, undefined, etc.). Please consult the documentation on [Construction and Initialization](https://docs.julialang.org/en/v1/manual/arrays/#Construction-and-Initialization).

As an example, let’s suppose we want to create a `2x3x4` table, we would do it with `zeros(2,3,4)`. Let’s suppose we want to fill it with the product of the indexes, we can do it in the following way:
"""

# ╔═╡ 430dac24-42b5-46ac-8164-65293e245315


# ╔═╡ 804eac36-7f06-4a3f-8b0a-2f6209bb7be7


# ╔═╡ f9237f58-a87b-4fba-8219-dcfb23c38f5f
md"""
**NOTE:** Please not that Julia stores values in memory differently from Python: in Julia to obtain fast loops we need to iter first over columns (which means that the first index must vary first and so on). For this reason if we plan to store, for example, 42 2x2 matrices, we need to create an array of size 2x2x42 (while in Python we would have created a 42x2x2 table).
"""

# ╔═╡ 02cfc225-2599-4bbd-b1d4-6b2334121cb7
md"""
## Tuples

A tuple is a fixed size group of variables which may share a common type but don’t need to.

Unlike arrays, you cannot increase the size of a tuple once it has been created. Tuples are created using the following syntax:
"""

# ╔═╡ 903cf96f-1fa3-4c0e-8e77-d7d58b3162c3


# ╔═╡ 0b85005c-2af8-49f5-8c82-4f3e6e8f6f30
md"""
So tuples can be created by using regular brackets or no brackets at all! Tuples are really handy, as it is possible to “unpack” a tuple over many values:
"""

# ╔═╡ 05d3c209-7281-41d8-b51b-a49ebfc51997


# ╔═╡ be3cbc1f-ae6a-4f1e-8058-8fcb04c7353e
md"""
It is also possible to use tuples to emulate multiple return values from functions:
"""

# ╔═╡ cc3edca7-fb2e-43bd-9f91-d6e7e197efcc


# ╔═╡ d9e8e8a6-928b-43d7-a30d-d7c11f0a0854
md"""
### Splatting

It is possible to “unpack” a tuple and pass its arguments to a function with the following syntax:
"""

# ╔═╡ 0584914f-4aac-40bb-94a0-11b7b32aae8b


# ╔═╡ 42e3ab98-4d19-4d33-a4b7-2f198ac41e60


# ╔═╡ 6a949f5f-a02a-4313-a294-c74a05718e4c
md"""
So the `...` after a tuple will unpack it! This is useful but addictive, use it only if needed as it is better for clarity (and to avoid multiple dispatch errors) to call a function with its single parameters.

### Names Tuples

Named tuples are like tuples but with a name identifier for a single value, for example:
"""

# ╔═╡ 6dd6c6a9-d0f9-405b-8d9d-ef4d3ce0c888


# ╔═╡ 05f26ebb-f144-4b66-a185-39b2b65462b0
md"""
## Dictionaries

A dictionary is a collection of keys and values. They are unordered (which means that the order of the keys is random) and are really useful when you need to organise, for example, a dataset. For ordered dictionaries see the [OrderedCollections.jl package](https://juliacollections.github.io/OrderedCollections.jl/latest/index.html).

Let’s suppose we want to create an address book. A single entry should be able to store all the fundamental characteristics needed to identify a friend: the name of the contact, the phone number and the shoe size!
I can even make a dictionary containing other dictionaries or add to an existing dictionary:

**NOTE:** as dictionaries become complex use a package for "pretty printing". We use [PrettyPrinting.jl](https://github.com/thautwarm/PrettyPrint.jl) for our example.
"""

# ╔═╡ e78cf949-1b84-44b3-bad2-84d7fcd6bb92


# ╔═╡ 9bd46c70-9eaa-494f-88af-1067bd2d663a
md"""
## Conclusion

In this lesson we have learned how to operate on arrays, tuples and dictionaries. Those structures are the basics of in-memory storage for any data. Arrays are lightweight and useful solutions to pass blocks of data, so use them whenever needed! Contrarily to C++, Julia has a built in garbage collector, so you don’t have to care about freeing memory and deleting pointers, as Julia will take care of it!

"""

# ╔═╡ 8b807e39-84fd-4148-9ab5-bfa0dccb6b6a


# ╔═╡ Cell order:
# ╟─82759b62-f341-11ef-2b08-6d161385bc05
# ╠═85b55ac9-5174-4c81-93e3-380389e41bf4
# ╟─e4763113-c824-4b8c-89cc-c51bc8667996
# ╠═b341e258-fc38-42fc-8610-d0a22e971b1d
# ╟─2fec41da-bffe-40e7-9fc7-ab59310ebd25
# ╠═36563a41-5c43-435a-88b4-6f3fd98e8f9c
# ╟─80d6f566-a3f9-4d57-947e-5a8ad33b72dd
# ╠═22b48d03-2b5d-42ce-aba2-54536c44e117
# ╟─48dbe959-76b6-46d7-a573-ec6cb82bd93f
# ╠═430dac24-42b5-46ac-8164-65293e245315
# ╠═804eac36-7f06-4a3f-8b0a-2f6209bb7be7
# ╟─f9237f58-a87b-4fba-8219-dcfb23c38f5f
# ╟─02cfc225-2599-4bbd-b1d4-6b2334121cb7
# ╠═903cf96f-1fa3-4c0e-8e77-d7d58b3162c3
# ╟─0b85005c-2af8-49f5-8c82-4f3e6e8f6f30
# ╠═05d3c209-7281-41d8-b51b-a49ebfc51997
# ╟─be3cbc1f-ae6a-4f1e-8058-8fcb04c7353e
# ╠═cc3edca7-fb2e-43bd-9f91-d6e7e197efcc
# ╟─d9e8e8a6-928b-43d7-a30d-d7c11f0a0854
# ╠═0584914f-4aac-40bb-94a0-11b7b32aae8b
# ╠═42e3ab98-4d19-4d33-a4b7-2f198ac41e60
# ╟─6a949f5f-a02a-4313-a294-c74a05718e4c
# ╠═6dd6c6a9-d0f9-405b-8d9d-ef4d3ce0c888
# ╟─05f26ebb-f144-4b66-a185-39b2b65462b0
# ╠═e78cf949-1b84-44b3-bad2-84d7fcd6bb92
# ╟─9bd46c70-9eaa-494f-88af-1067bd2d663a
# ╠═8b807e39-84fd-4148-9ab5-bfa0dccb6b6a
