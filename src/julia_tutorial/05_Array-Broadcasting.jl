### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ b4c7e8d4-f395-11ef-0683-9d7b00cbda37
md"""
# Array Broadcasting

## Contents

- [Introduction](#Introduction)
- [Operations with Arrays](#Operations-with-Arrays)
- [Broadcasting](#Broadcasting)
- [Conclusion](#Conclusion)

## Introduction 

Many languages (such as Python with numpy and Matlab) make extensive use of optimised C or Fortran routines under the hood to perform fast mathematical operations, as such the user is encouraged to write vectorised code, so that these routines can perform faster for loops, as a big part of the CPU time is spent on calling the underlying compiled routine. More or less what happens is that the user writes vectorized code which communicates to C code that can run fast for loops and the result is then returned to the user in the form of an array (or matrix).

In Julia, the interpreter will directly compile to optimised machine code using just-in-time (JIT) compilation.

**NOTE of CAUTION:** measure first! JIT can be a bottleneck on its own (first-time-to-plot is a real issue)

In Julia, the broadcasting notation is given by the dot `.` operator.

## Operations with Arrays

Julia by default deals with operations on arrays and matrices as one would do in mathematics.

From a mathematical point of view, we don’t know how to compute the `sin` of an array, as the sine function is defined only on single (dimensionless) values. At the same time the `exp` can work both on single values and matrices as the exponential of a matrix has a well-defined geometrical meaning. 

For the same reason, you cannot multiply two arrays together, unless their size is matching correctly (i.e. one array is a row array and the other one is a column array) and in this case the multiplication of two arrays becomes the well-defined geometrical product of two arrays (which can be a scalar or a matrix, depending on the order of the multiplication).

Let's start with a simple example:
"""

# ╔═╡ 1c07e3e1-4a3b-4f7b-a9d4-66cfd0b9f1cd
begin

function ErrorColCol()
    col1 = [1,2,3] # is a column vector
    col2 = [4,5,6] # is a column vector
    col1*col2
    return
end

ErrorColCol()
end

# ╔═╡ 35842eea-aa81-4e29-a65f-aa5b500b4033
begin

function MultFun()
    println("Valid array operations:")
    col1 = [1,2,3] # is a column vector
    row1 = [4 5 6] # is a row vector
  
    println( "  Matrix col1 * row1 = ", col1 * row1  )
    println( "  Scalar row1 * col1 = ", row1 * col1  )
  
    # 1D vector to 3x3 2D matrix
    mat = reshape([1,2,3,4,5,6,7,8,9],3,3)
    println( "  Column mat * col1 = ", mat * col1  )
    println( "  Row row1 * mat = ", row1 * mat  )
    return
end

MultFun()
end

# ╔═╡ d0504b8a-5da1-4ea8-998b-d954dcd08f28
md"""
The previous array operations make perfect sense from a mathematical point of view and operators behave how we would expect. Nonetheless, in programming it is often useful to write operations which work on an element by element basis, and for this reason broadcasting comes to our help.

## Broadcasting

In Julia, with broadcasting we indicate the action of mapping a function or an operation (which are the same in Julia) over an array or a matrix "element by element".

The broadcasting notation for operators consists of adding a dot `.` before the operator, for example `.*` .

Considering the example we get:

"""

# ╔═╡ 62b9d253-b8d4-492c-afa3-271cf5a55be4
begin
function BroadcastFun()
    println("Valid array broadcast operations:")
    col1 = [1,2,3] # is a column vector
    row1 = [4 5 6] # is a row vector
  
    println( "  Matrix col1 .* row1 = ", col1 .* row1  )
    println( "  Scalar row1 .* col1 = ", row1 .* col1 )
  
    # 1D vector to 3x3 2D matrix
    mat = reshape([1,2,3,4,5,6,7,8,9],3,3)
    println( "  Column mat .* col1 = ", mat .* col1  )
    println( "  Row row1 .* mat = ", row1 .* mat  )
    
    println( "  Squares col1 .* col1 = ", col1 .* col1)
    return
end

BroadcastFun()
end

# ╔═╡ ee3ac51b-2d68-4649-b3b3-70804a51eaf2
md"""
Notice that when we broadcast the multiplication with a matrix and an array, the array gets multiplied “in the same direction” as it is written, in the sense that if a vector is a column it gets applied column by column etc.

We can use the broadcasting notation also to map a function over an n-dimensional array. There is **no speed gain** in doing so, as it will be exactly equivalent to writing a for loop, but its conciseness may be useful sometimes. So the core idea in Julia is to write functions that take single values and use broadcasting when needed, unless the functions must explicitly work on arrays (for example to compute the mean of a series of values, perform matrix operations, vector multiplications, append to strings, etc).
"""

# ╔═╡ 1304751d-2e92-4b3e-92f0-4ff7f61a0308
begin
function MoreBroadcastFun()
    # strings
    first_names = ["Mark", "Emily"]
    # concatenate element by element
    full_names = first_names .* " Godoy"
    println(full_names)    
    
    
    v = [1,2,3,4,5,6,7,8,9]
    
    # norm
    println( "L2 Norm = ", sum( v .^ 2) ^ (1/2) ) 
    # sines 
    println( "Sine of v elements = ", sin.(v) )
    
    return
end

MoreBroadcastFun()

end

# ╔═╡ 9cc7e008-41b2-4f16-a66d-f0e641e11a0e
md"""

## Conclusion

We have learned what is broadcasting and how it can be used to perform element by element operations between vectors and how to map a function over an array using the concise broadcasting syntax.

We have also pointed out how Julia does not gain in performance by using “vectorised” notations (while other languages do) because the core Julia operations are implemented directly in the Julia language and thus there is no need to call compiled routines coded in other languages under the hood to offload all the heavy work.

"""

# ╔═╡ Cell order:
# ╟─b4c7e8d4-f395-11ef-0683-9d7b00cbda37
# ╠═1c07e3e1-4a3b-4f7b-a9d4-66cfd0b9f1cd
# ╠═35842eea-aa81-4e29-a65f-aa5b500b4033
# ╟─d0504b8a-5da1-4ea8-998b-d954dcd08f28
# ╠═62b9d253-b8d4-492c-afa3-271cf5a55be4
# ╟─ee3ac51b-2d68-4649-b3b3-70804a51eaf2
# ╠═1304751d-2e92-4b3e-92f0-4ff7f61a0308
# ╟─9cc7e008-41b2-4f16-a66d-f0e641e11a0e
