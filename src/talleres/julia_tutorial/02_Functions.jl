### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 068c4be6-f333-11ef-3bb2-cf09eeb2fa8c
md"""
# Functions

The content material is taken from https://techytok.com/from-zero-to-julia/ 

**Table of Contents**
 - [Defining Functions](#Defining-Functions)
 - [Void Functions](#Void-Functions)
 - [Anonymous Functions](#Anonymous-Functions)
 - [Optional and Keyword Arguments](#Optional-and-Keyword-Arguments)
 - [Documenting Functions](#Documenting-Functions)
 - [Conclusion](#Conclusion)
            
Functions are the main building blocks in Julia. Every operation on variables and other elements is performed through functions, even the mathematical operators (e.g. `+`) are functions in an infix form.


## Defining Functions

A typical function looks like this: **NOTE: Julia doesn't enforce indentation as Python**
"""

# ╔═╡ 36606c15-875c-460e-92e2-5a66a7c1ed3f


# ╔═╡ d081903e-0faa-4fb5-9682-58302d2a9596
md"""
Although the previous is the most common way to write functions, it is sometimes convenient to use the inline version (think of the REPL):
"""

# ╔═╡ 9d57f590-ad09-4fe6-90eb-537872507ad1


# ╔═╡ 5ba14dd3-ec49-45ff-ad55-425acff14aad
md"""
A few important things:
- Functions are defined with the keyword **function** and always finalized with **end**. 
- Julia **doesn't have member functions** ( foo.bar() ), functions can be scoped with modules (think Fortran).
- Function arguments and return types are optional, but highly recommended
- Function arguments can limit types using Abstract* types (see example below)
- Functions can have multiple signatures (overloaded), it's the basis for multiple dispatch
- Function arguments are *"passed by reference"*. Just like in Fortran, single values won't be modified, but array contents will.
- It's a convention that if a function modifies its arguments it ends with `!`
- The dot (`.`) operator is syntactic sugar for element by element operations (vectorization), see [article](https://julialang.org/blog/2017/01/moredots/). It's also called broadcasting.
"""

# ╔═╡ 5884d38a-7030-49b1-9e21-5ed2a91dc7ed


# ╔═╡ a31cb149-c24f-460d-bf36-543abf630720
md"""
## Void Functions

Julia has a unique signature for all functions. `void` functions (`subroutines` in Fortran), those that don't return anything. Functions may also take no arguments and return no value, if needed, for example we can create a function which prints a string:
"""

# ╔═╡ 6d9d050d-3f23-473c-8f99-4f8f49100254


# ╔═╡ 03b16167-1bcd-489e-acc9-b0caca340a90
md"""
If the function returns no value `return` can be omitted. In general, ~it is also possible to omit the return statement even in regular functions and Julia will return the last computed value~. **NOTE: bad idea**
"""

# ╔═╡ dc6b74ef-8352-41fe-a9d8-c04d3c142f84


# ╔═╡ e4b6a1ca-02c7-49e6-aa94-d8753ab41a8d


# ╔═╡ 72ca684d-8daa-4c32-b246-b2f04f3cd10d
md"""
## Anonymous Functions

It is also possible to create anonymous functions (like lambdas in Python or C++) using the following structure:
"""

# ╔═╡ b1e833bc-00f4-487b-a4f1-cad8c8c83a20


# ╔═╡ 4cef525e-8d75-403b-815c-6869ec31c44b
md"""
**NOTE: It is not recommended to use anonymous functions unless they are really simple.** It is generally better to write functions using the `function/end` keywords unless you need to write a small wrapper around another function and pass it to a third function. (Think of lambda functions in C++ and Python)

"""

# ╔═╡ 835342ee-a874-460e-bc6d-7410a0b41dc1
md"""
## Optional and Keyword Arguments

### Optional arguments
Sometimes a parameter may have a default value which can be specified so that the user doesn’t need to always type it. For example let’s write a function which converts our “weight” as measured on Earth (in kg) to the one measured on another planet.
"""

# ╔═╡ 25c06cb0-40f6-4b96-99e6-6217bf99632b


# ╔═╡ fa0f6bd5-ef63-4c38-96e4-0ae6e424708d
md"""
As the name suggests positional arguments must be used in the right order, we cannot specify g before `weightOnEarth` and, as opposed to other languages like Python, in Julia we cannot change the order of the arguments even if we specify the name of the parameter. If we want optional arguments with no fixed position, we need to use **keyword arguments**.
"""

# ╔═╡ aaf00ddd-34d4-4317-a364-30acbcd38d7c
md"""
### Keyword arguments 
Keyword arguments are separated from positional arguments by a semicolon ; and must always be addressed by their name, although their order is irrelevant. They can be either optional and not, but usually we use keyword arguments for optional parameters.
"""

# ╔═╡ 2bba72af-fb16-488b-81a1-9b0a6afddec4


# ╔═╡ d6a4a94c-1d74-4ee3-9ee4-0dda68ae1d90


# ╔═╡ 3f23587a-e393-453f-ae95-f50b9edf9450


# ╔═╡ ad212d9e-541f-4437-a35e-78856c479135
md"""
**Tip**: prefer positional arguments for performance (function called several times) as it's closer to underlying libraries (C, Fortran, C++)
"""

# ╔═╡ 261b5841-d7cf-4f78-9f39-6410826d8fb6
md"""
## Documenting Functions

Julia supports function API documentation using Markdown, similar to Python docstring. Function documentation is done above a function using the \""" \""" opening and closing symbols. While the macro `@doc` (or the `?function_name` in the REPL) exposes the documentation information if available.

"""

# ╔═╡ 5df5e5ea-b3a8-4fad-870e-81858f2c7345


# ╔═╡ 6b368e85-403f-4677-bf3d-a670186f6470


# ╔═╡ 9ef8c8be-3ea9-4b40-844f-88c9a0a7b4df
md"""
## Conclusion

In this lesson we learned how to define functions and use positional as well as keyword arguments.

**Questions:**

1. How many way exist to define a function in Julia?
2. Can functions be member functions in Julia?
3. What's the difference between Optional and Keyword arguments?
4. How do you document your function API in Julia?
"""

# ╔═╡ f426ba47-0a05-4f92-8a10-697c75bcc903


# ╔═╡ e1b28ccd-3012-469e-9aaa-624f4db22176


# ╔═╡ bca75e0a-52e2-4371-9a98-72a49d727b6a


# ╔═╡ Cell order:
# ╟─068c4be6-f333-11ef-3bb2-cf09eeb2fa8c
# ╠═36606c15-875c-460e-92e2-5a66a7c1ed3f
# ╟─d081903e-0faa-4fb5-9682-58302d2a9596
# ╠═9d57f590-ad09-4fe6-90eb-537872507ad1
# ╟─5ba14dd3-ec49-45ff-ad55-425acff14aad
# ╠═5884d38a-7030-49b1-9e21-5ed2a91dc7ed
# ╟─a31cb149-c24f-460d-bf36-543abf630720
# ╠═6d9d050d-3f23-473c-8f99-4f8f49100254
# ╟─03b16167-1bcd-489e-acc9-b0caca340a90
# ╠═dc6b74ef-8352-41fe-a9d8-c04d3c142f84
# ╠═e4b6a1ca-02c7-49e6-aa94-d8753ab41a8d
# ╟─72ca684d-8daa-4c32-b246-b2f04f3cd10d
# ╠═b1e833bc-00f4-487b-a4f1-cad8c8c83a20
# ╟─4cef525e-8d75-403b-815c-6869ec31c44b
# ╟─835342ee-a874-460e-bc6d-7410a0b41dc1
# ╠═25c06cb0-40f6-4b96-99e6-6217bf99632b
# ╟─fa0f6bd5-ef63-4c38-96e4-0ae6e424708d
# ╟─aaf00ddd-34d4-4317-a364-30acbcd38d7c
# ╠═2bba72af-fb16-488b-81a1-9b0a6afddec4
# ╠═d6a4a94c-1d74-4ee3-9ee4-0dda68ae1d90
# ╠═3f23587a-e393-453f-ae95-f50b9edf9450
# ╟─ad212d9e-541f-4437-a35e-78856c479135
# ╟─261b5841-d7cf-4f78-9f39-6410826d8fb6
# ╠═5df5e5ea-b3a8-4fad-870e-81858f2c7345
# ╠═6b368e85-403f-4677-bf3d-a670186f6470
# ╟─9ef8c8be-3ea9-4b40-844f-88c9a0a7b4df
# ╠═f426ba47-0a05-4f92-8a10-697c75bcc903
# ╠═e1b28ccd-3012-469e-9aaa-624f4db22176
# ╠═bca75e0a-52e2-4371-9a98-72a49d727b6a
