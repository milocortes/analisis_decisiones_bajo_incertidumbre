### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 433d2748-f394-11ef-1d84-19fbd954eb02
md"""
# Control Flow

In this lesson we will learn how to work with control statements. We will first learn how to use conditional blocks like `if ... else` blocks and then we will learn how to perform loops.

## Contents

- [if...else](##if...else)
- [for loops](##for-loops)
- [enumerate](##enumerate)
- [break](##break)
- [continue](##continue)
- [while loops](##while-loops)
- [Conclusion](##Conclusion)
"""

# ╔═╡ 6abcd733-d3c2-4b50-a6e6-746bae17aef7
md"""
## if...else

When a program needs to take decisions according to certain conditions, the `if ... else` block is the default choice.

Let’s suppose that we want to write a simple implementation of the absolute value of a number. The absolute value of a number is defined as the number itself, if the number is positive, or the opposite if the value is negative. This is the typical case where the `if ... else` construct is useful! We can write a simple absolute function in this way:
"""

# ╔═╡ 14a5b0a5-f38e-49bd-924e-3b5f067ed3be


# ╔═╡ dba9b205-cdaf-456b-aa73-cb4b3e6fe40f
md"""
As you can see, an `if ... else` block is closed with the word `end`, like a `function`.

If we need to check more than one condition, we can bind together conditions using:

- "negation" is written as `!`
- “and” is written as `&&` 
- “or” is written as `||`

**NOTE:** same as C or C++

For example, if we want to check whether 3 is both minor than 4 and major than 1 we type:
"""

# ╔═╡ 07c65996-9331-4072-b7c0-5d39c6c29ef2


# ╔═╡ 0889a2dc-cb3f-4419-9bbc-024006e8c86d
md"""
If we want to check if a value satisfies one of several different conditions, we can use the `elseif` statement: Julia will check if the first condition specified in the if is satisfied, if it is not met it moves on to the first `elseif` and so on:
"""

# ╔═╡ 91cbfca6-cf9b-4199-904f-d01c37d04582


# ╔═╡ 130cbec9-177e-4d61-9e39-255c4ccf756d
md"""
## for loops

**Ranges**: There is many ways to iterate over a list of values and perform some operation on each element.

  - `for i in min:max`
  - `for i = min:max`

Ranges can be defined explicitly using the [`range` function](https://docs.julialang.org/en/v1/base/math/#Base.range).
For example let’s suppose we want to print all the squares of the numbers comprised between 1 and 10, we can do it using a for loop:
"""

# ╔═╡ 74fa285a-7d8c-469e-a210-cdcc3db29c0d


# ╔═╡ 61858a08-473c-4269-8bc9-764f5206397f
md"""
`i` is the variable which contains the data which gets updated at each new cycle (in this case i holds the numbers from 1 to 10 respectively), while `1:10` is a *range*. A range is an iterable object which does exactly what its name suggests: it specifies the range on which the loop has to be performed (in this case 1 to 10).

**Lists**: we can iterate element by element in data structures that can be represented as lists: arrays, tuples, dictionaries (key/value pairs or keys only). 

For example, let’s suppose we have an array and a dictionary:
"""

# ╔═╡ dd79a3d6-b764-4ebf-ae84-5cf7a68a3389


# ╔═╡ 9385d5b3-22c3-483b-a3b4-e1c6dc58bf5c
md"""
## enumerate 

`enumerate` is a function which comes in handy when we need to iterate on an array (or similar) and we need to keep track of the number of iterations we have already performed.

enumerate will return an iterator (which is something like an array which can be iterated in for loops). It will produce couples of the form `(i, x[i]).`
"""

# ╔═╡ f5a1afae-1257-4b62-a08b-a42f46e52c2b


# ╔═╡ f18a3fb2-f9f0-43e4-9983-fbd070600758
md"""
## break

In the case we want to forcefully interrupt a `for` loop we can use the `break` statement, for example:
"""

# ╔═╡ ea21fdc9-592a-4d95-9561-e4e4fa2b35cd


# ╔═╡ d1a1f8e4-76b0-4e9e-9447-a812da595eb8
md"""
Here we check `if i>10`, in that case we break the loop and finish the iteration, else we print `i^2`.

## continue

This is the opposite of `break`, `continue` will forcefully skip the current iteration and move to the next cycle:
"""

# ╔═╡ 36b3e125-c6a3-4608-907f-b1b61f3f214f


# ╔═╡ d59bca47-5a3a-4a02-a470-29b86fc91fd1
md"""
This loop prints all the numbers from 1 to 10 except the multiples of 3.

## while loops

When a loop needs to continue until a certain condition is met, a while loop is the preferable choice:
"""

# ╔═╡ 5b09c876-de7f-4efd-b236-d47e4b93bf0d


# ╔═╡ a54b771c-8762-4495-b74b-8aec421ab4c0
md"""
## Conclusion

In this lesson we have learned how to let a program take “decisions” using `if ... elseif ... else` blocks, how to perform loops using for and while and how to have control on such loops using `break` and `continue`. We have then given an example of how enumerate can be used to help the process of filling an array.

**NOTE:** Julia does not have support for `switch` statements
**NOTE:** use the length function to get array length for ranges

"""

# ╔═╡ 4cb2a5b8-347c-45fe-9aa3-d55e75b89ce4


# ╔═╡ 454b8afe-50c4-427e-8963-c5abeaa3a1c3


# ╔═╡ Cell order:
# ╟─433d2748-f394-11ef-1d84-19fbd954eb02
# ╟─6abcd733-d3c2-4b50-a6e6-746bae17aef7
# ╠═14a5b0a5-f38e-49bd-924e-3b5f067ed3be
# ╟─dba9b205-cdaf-456b-aa73-cb4b3e6fe40f
# ╠═07c65996-9331-4072-b7c0-5d39c6c29ef2
# ╟─0889a2dc-cb3f-4419-9bbc-024006e8c86d
# ╠═91cbfca6-cf9b-4199-904f-d01c37d04582
# ╟─130cbec9-177e-4d61-9e39-255c4ccf756d
# ╠═74fa285a-7d8c-469e-a210-cdcc3db29c0d
# ╟─61858a08-473c-4269-8bc9-764f5206397f
# ╠═dd79a3d6-b764-4ebf-ae84-5cf7a68a3389
# ╟─9385d5b3-22c3-483b-a3b4-e1c6dc58bf5c
# ╠═f5a1afae-1257-4b62-a08b-a42f46e52c2b
# ╟─f18a3fb2-f9f0-43e4-9983-fbd070600758
# ╠═ea21fdc9-592a-4d95-9561-e4e4fa2b35cd
# ╟─d1a1f8e4-76b0-4e9e-9447-a812da595eb8
# ╠═36b3e125-c6a3-4608-907f-b1b61f3f214f
# ╟─d59bca47-5a3a-4a02-a470-29b86fc91fd1
# ╠═5b09c876-de7f-4efd-b236-d47e4b93bf0d
# ╟─a54b771c-8762-4495-b74b-8aec421ab4c0
# ╠═4cb2a5b8-347c-45fe-9aa3-d55e75b89ce4
# ╠═454b8afe-50c4-427e-8963-c5abeaa3a1c3
