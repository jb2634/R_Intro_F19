# Intro to logical operations and subsetting in R

# T/F what are they? ---------------------------------------------------------------------------------------------------

# Internally, logical values TRUE and FALSE are stored as 1 and 0 respectively. Also known as Boolean vectors. 
# These are the simplest representations of data.
# Can represent as 'TRUE', or 'T', 'FALSE' or 'F'.

(logivec = rep(c(TRUE, FALSE), 2))
(logivecT = rep(T, 4))
(logivecF = rep(F, 4))

class(logivec)

as.integer(logivec)

# What are logical operations?
# Most of the operations below are pair-wise, meaning that every vector index is compared to the same index of other vectors.

# LOGICAL NOT (negation of a logical vector)

!logivec

# LOGICAL AND (which elements of vectors are ALL true?)

logivec & logivecT # The first and third positions of both vectors are ALL true.

# Notice that there won't be any TRUE's when logivecF is included

logivec & logivecT & logivecF # None of the positions in these vectors are ALL true, since logivecF is all FALSE.

# LOGICAL OR (which elements of vectors have *at least* one TRUE?)

logivec | logivecT # All true
logivec | logivecF # First and third

# LOGICAL XOR (which elements have one, and ONLY one TRUE)

xor(logivec, logivecT) # The second and fourth positions; see them together to see why
cat(logivec, '\n', logivecT) # What's this? A way to print data neatly to the console, in a fairly raw format. Similar to concatenate in Excel

# What should we get if we run xor(logivecT, logivecF) ?
xor(logivecT, logivecF)





# Logical vectors and their uses

# Tests of equality/inequality ---------------------------------------------------------------------------------------------------

# Mathematical equality

# Is `2 + 2 = 5` a true statement?
2 + 2 == 5

5 == sqrt(25)

1 > 0   # T 
1 >= 0  # T
1 == 0  # F 
1 <= 0  # F
1 < 0   # F
1 != 0  # T (logical NOT)

# What happens if we do this? 1 OR 0? 
1 | 0 
# What happens if we do this?
1 | 1   # T
0 & 1   # F
0 & 0   # F
1 & 1   # T

# Recall, T/F stored as 1/0, respectively

# Other value equality

# Works with characters
"A" == "A"
"B" == "A"

# Works with objects

bignum = 1e6

bignum == bignum

# What about missing values?

is.na(NA)
is.null(NULL)

# Don't try to use direct comparison though! Rstudio will display a warning here.

NA == NA
NULL == NA
NA == NULL








# Vector operations --------------------------------------------------------------------------------------------------------------

# All the operations above Work with vectors - pairwise comparisons; 
# compare a[1] to b[1], 
#         a[2] to b[2], 
#         a[3] to b[3], etc.

# Set values for a & b
(a = 1:10)
(b = c(1:5, 11:15))

a == b # The first five elements are the same, the rest are not

c = c(1:10, NA)

is.na(c) # last element is found to be NA. Again, don't use `==` ! 

# Already we can see the use of this - we can find (and/or remove) missing data!

# How do we see if two vectors are **exactly** alike?

identical(a,b)
identical(a,a)

# identical() is good for testing EXACT equality of OBJECTS, not just their
# values! Note, if there's an attribute like rownames that doesn't match up,
# identical will return FALSE!

d = a                    # d startss off the same as a
identical(a,d)           # d is identical to a at this point

names(d) = letters[1:10] # Set name attribute for each element of c
d                        # Each element (numbers) has a name attribute (letters) above it.

identical(a,a)           # a is still identical to a
identical(a,d)           # d is now NOT identical to a

# While `d` still has the same values as `a`, the OBJECTS are not completely the same. 

# Use all() alongside comparisons to test for value equality
# all() asks, are all the elements in the vector contained true?

all(a == d)              # Evaluates to TRUE because we are only comparing the VALUES. Be careful with identical() and all.equal().

# Similar to all() is any(), which asks within the contained vector, is ANY value true? 

# Will return TRUE with at least one true in the contained vector. Will only return false if ALL are false.

any(a == b)

# Matrix operations --------------------------------------------------------------------------------------------------------------

# A matrix is a bunch of equal-length vectors put together. We can put together a and b from above

ab_mat = matrix(data = c(a,b), nrow = 10, ncol = 2)           # I'm saying the data is a, followed by b, with 10 rows (length of vectors a & b), and 2 columns (two vectors)

ba_mat = matrix(data = c(b,a), nrow = 10, ncol = 2)           # What if we put it in the other way?

ab_mat
ba_mat

# Notice that the order of the data matters. a is in the first column in ab_mat, whereas b is in the first column in ba_mat.
# It may feel odd that the software fills in data by columns because we are accustomed to writing left-to-right.

# R defaults to filling in what's called column-major order, but it is ultimately irrelevant to the end-user because filling in by column-major order is the same as filling in by row-major order of the transpose matrix. The concern here rests squarely with the underlying memory structures.




# Tests of structure --------------------------------------------------------------------------------------------------------------

# Usually prefixed by 'is'

is.integer('a')

is.integer(integer(1))

is.character(23)

is.character('ABC')

is.logical(0)

is.logical(F)

isTRUE(F)

isTRUE(T)

# Most often used in control structures







# Subsetting/indexing -----------------------------------------------------------------------------------------------------------

# A really important part of R, and programming in general
# Sometimes we want to see, usem or manipulate a part of an object, and not the whole thing. 

# Methods for subsetting - By index ------------------------------------------------------------------------------------------

# R begins indexing at 1, and goes to N. Other programming languages start at 0 and go to N-1. Be careful!

a[0]         # There isn't a 0th index in R; integer(0) is R's way of holding an empty object that was set up to be an integer.
a[1]         # This is the first index
a[2]         # Second
             # ...
a[length(a)] # you can pass any object that evaluates to integers to index! Very useful.

head(a)      # Easy way to subset the first 6 values. Use argument `n` inside head(n = N) to set custom length.
tail(a)      # Same as head, but from the bottom.




# Revisit example with NA's above. How do we remove missing data from vector c?

c         # Missing value in 11th slot
# We could just subset c from 1:10

c[1:10]   # No NA

# But what if c was different, and really big?

c_long = sample(c, size = 1e5, replace = T)

table(c_long, useNA = 'always') # Note that there are about 9000 <NA> values. The argument `useNA` sets an option to count NA values - off by default.

# There are NA's, but it would be really cumbersome to remove them by hand. We
# want to subset `c_long` to include only the non-empty values. 

# We can subset by finding the indices of the NA values, using `which`; we get all the corresponding indices

(na.index = which(is.na(c_long)))

# If we pass this to c_long as an index, we should only see NA's

c_long[na.index]

# If the output is truncated, how do we know it's all NA's? Use a logical test

all(is.na(c_long[na.index]))

# Or use table() if it's not continuous values

table(c_long[na.index], useNA = 'always')






# Methods for subsetting - By index ------------------------------------------------------------------------------------------

# But wait - there's another way to subset, and that's by logical vector. If we pass a vector of true/false to an index, we can 'turn on/off' each index in turn. 

length(a)                             # There are 10 elements in `a`
logindex = c(rep(T, 5), rep(F,5))     # We need a vector of 10 logical elements. Let's see what happens if we set the first five to TRUE and the last to FALSE

a[logindex]                           # We receive back ONLY those elements that correspond to TRUE in logindex - that is 1:5.

# Notice that on line 216 when we asked for the indices of the NA values, we also used is.na. Recall that this is a logical test for NA values, and returns a logical vector of TRUE's corresponding to NA positions, and FALSES otherwise.

# This is the better way to subset over supplying indices themselves, because you can always ask for the inverse.

(na.index = is.na(c_long)) # Skip the which() statement for the index positions, and just get a logical vector of same length as c_long

c_clean = c_long[!na.index]          # If we want only those values that AREN'T NA, then we can just invert this logical vector with a logical NOT

# Test this

summary(c_clean)                     # No NA's

# An easy way to clean matrices and data.frames

c_long_mat = cbind(c_long, c_long + 1)                 # Make a new matrix with missing values

c_long_mat_index = complete.cases(c_long_mat)          # Get only those rows with 'complete cases', or no NA's. The result is a logical vector with the same length as the number of rows in the original matrix

c_long_mat_clean = c_long_mat[c_long_mat_index,] # Subset to obtain those rows without ANY NA's.

# Always prove to yourself that it worked! 

# EXERCISES

# Devise two tests to see that c_clean is indeed clean of NA values. ------------------------------------------------

# Clean the airquality dataset --------------------------------------------------------------------------------------

head(airquality)

# CO2 dataset exercises ---------------------------------------------------------------------------------------------

head(CO2)

# Identify the maximum uptake for the Quebecoise plants, using subsetting and max().

# Compare this to the maximum uptake for Mississippian plants


# Formatting data - Categorical covariates --------------------------------------------------------------------------------------

# Often, covariates in a model are categorical, meaning they take on a few discrete values. The way to format this data for analysis is called dummy coding. 
# Load the dummy coded data

load('dummyCode.Rdata') # The object is named 'dummyCode'. Note that objects are named as they are saved, and .Rdata files can contain multiple objects, so don't assign it to an object here!

head(dummyCode)

# Load the adirondack habitats data, and using logical expressions, obtain a dummy-coded matrix. 

load('adk_habitats.Rdata')

# The object `habSummary` has a value for every single grid cell in the Adirondacks. 
# There are four levels; 0, 1, 2, 3, 4, representing categories for 'other', 'conifer', 'deciduous', 'mixed', and 'wetland' specifically.

str(habSummary)

# Exercise: Format the data to obtain the same matrix as dummyCode. Devise a test or two to verify that it is correct.


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 


# Control statements ---------------------------------------------------------------------------------------------------

# Control statements will execute parts of the script conditionally, in pre-defined loops, or indefinitely until a condition is met.

# There are several main control statements

# IF and ELSE ----------------------------------------------------------------------------------------------------

# if(test){do_this}  -  use to execute lines of code conditionally on a logical test passed as an argument. Braces are used to bind the part of the script to be run.

c

(test = any(is.na(c)))

if(test){ # If there are any NA's in c
  
  c[!is.na(c)] # Remove them
  
}

# There is an implicit else here, which is 'do nothing'. Explicitly, this looks like

if(test){ # If there are any NA's in c
  
  c = c[!is.na(c)] # Remove them
  
} else {
  
  NULL
  
}

# There is a function ifelse(), but use this for very simple expressions.

ifelse(test = test, yes = c[!is.na(c)], no = NULL)         # The argument structure of this makes long conditional scripts cumbersome.

# 


# LOOPS -----------------------------------------------------------------------------------------------------------------------------------------------

# FOR -----------------------------------------------------------------------------------------------------------------------------------------------

# This is the simplest loop. It states "For all elements in some index, do the following script that many times.

for(i in 1:10){
  print("Hello!")
}

# Note that i is an object that can be used like any other. USE this to change the behavior of the for loop through elements of some structure!

output = matrix(data = NA, nrow = 20, ncol = 10)

means = seq(0, length.out = ncol(output))
sd = 1

for(i in 1:ncol(output)){
  
  mean = means[i]
  
  output[,i] = rnorm(n = nrow(output), mean = mean, sd = sd)
  
}

# Exercise : We just simulated data with means increasing by 1 per column. Take the column means to see if we did this correctly

# # # 

# We can use if() statements inside for loops. What should we see in the following loop?

for(i in 1:10){
  
  if(i == 5){
    print(i)
  } 
  
}

# We can decide to skip elements conditionally using `next`. NOW what should we see?

for(i in 1:10){
  
  if(i == 5){
    next
  } else {
      print(i)
    }
  
}

# WHILE -----------------------------------------------------------------------------------------------------------------------------------------------

# Perform a section of script over and over until a condition is met.
# Calculate pi to 1 digits using monte carlo method

test = FALSE
points_in = 0
points_out = 0

set.seed(1) # Set a reproducible outcome. Anything (random) run after this will always produce the same output.

rpois(n = 5, lambda = 10) # 8, 10, 7, 11, 14; always

while(!test){
  
  point = c(runif(n = 1, min = -0.5, max = 0.5),
             runif(n = 1, min = -0.5, max = 0.5))
  
  point_dist = sqrt(point[1]^2 + point[2]^2)
  
  if(point_dist < 0.5){
    points_in = points_in + 1
  } else {
    points_out = points_out + 1
  }
  
  message(paste0("Points in: ", points_in, "\nPoints out: ", points_out))
  
  pi_hat = 4 * (points_in / (points_in + points_out))
  
  message(paste0("pi_hat = ", pi_hat))
  
  test = abs(pi_hat - pi) < 0.001
  
}

# REPEAT -----------------------------------------------------------------------------------------------------------------------------------------------

# Repeat does something repeatedly until a condition is met. This is very similar to 'while', except this is more useful in doing something indefinitely.
# I have a repeat function that uploads files to a cloud drive every 15 minutes; there's no terminating condition.

# The example here does implement an end condition, using `break`

repeat(
  {
    sample = rpois(n = 1, lambda = 8)
    print(sample)
    if(sample > 10){break}
  }
)

# FOREACH ----------------------------------------------------------------------------------------------------------------------------------------------------------------

# This will automatically install the package for you if you don't have it.
if(!require(foreach)){install.packages('foreach')}

# Operates mostly similar to for(), but handles output automatically, defaulting to a list for every index

foreach(i = 1:10) %do%{
  print(i)
}

# Let's recall the data we simulated earlier

output = matrix(data = NA, nrow = 20, ncol = 10)

means = seq(0, length.out = ncol(output))
sd = 1

set.seed(1)

for(i in 1:ncol(output)){
  
  mean = means[i]
  
  output[,i] = rnorm(n = nrow(output), mean = mean, sd = sd)
  
}

# To do the same here, we don't even need to create the output matrix. We do need to specify that the output from each 

# Set a seed to compare them.

set.seed(1)

output_foreach = foreach(i = 1:10, .combine = cbind) %do% {
  
  out = rnorm(n = 20, mean = means[i], sd = sd)
  
}

all(output == output_foreach)

# They are the same thing, but foreach is a little simpler to write. 

# The drawbacks of foreach are that it is a little more difficult to implement
# inside another function; you can't use the standard debugger to step through
# and see what is going wrong. 

# The pros of foreach are greater than the drawbacks, in my opinion:
# Parallelizing is made extremely simple. For instance, the above can be done as such:

if(!require(doParallel)){install.packages('doParallel')}

registerDoParallel(cores = 4) # Register four cores to operate 

output_foreach_par = foreach(i = 1:10, .combine = cbind) %dopar% { # Do the following 4 indices at a time
  out = rnorm(n = 20, mean = means[i], sd = sd)
}

registerDoSEQ() # Turn off parallel to free up resources. Always good to do after parallel operations, doesn't hurt.

# Such an example is NOT efficient, but if you have a really long operation per index that are independent, foreach will speed things up tremendously.
# However, there is rather expensive overhead in setting up all the CPU's and sending them information that doesn't exist in serial operations.

# Parallelize when:
# * Operations each individually take hours
# * Operations are independent
# * Many indices that are better done simultaneously.

# Times NOT to parallelize:
# * Short operation per index (on the order of seconds to minutes)
# * Not a whole lot of indices
# * Operations depend on previous indices

# Functions ---------------------------------------------------------------------------------------------------------------------

# Not really logic, but good to know if time allows and follows naturally from control flow statements.

# In R, everything is an object, even a function. Try typing a function name without parentheses

xor

# We can see the function definition, because it's stored as a particular object. 

# We can define our own functions. What is a function? A function is a bunch of
# lines of code that is executed when the function is called, optionally taking
# arguments.

# What is the structure of a function? We've been using them all along:

# Function_name( argument1 = DEFAULT_VALUE, argument2 = DEFAULT_VALUE_2, ..., argumentN) { 
#       body_of_function
#       return(output)
# }
# 

# Arguments can be set with default values, or not. 
# If there exists something in the body of the function that is not supplied as an argument, the function will look to the global environment for it.
# Good practice to return exactly what you want.

# Run the following to define a function. What does this one do?

test_func = function(a, b){
  
  do_something = a + b
  
  return(do_something)
  
}

test_func(a = 1, b = 2)

# The function sums a and b, and returns that output.
# We can put anything we want into the function to execute. 

# Benefits of using a function:
# * No side effects. Notice that `do_something` isn't in our environment. That means no matter what objects we make in the function, we can't accidentally rewrite things in our global environment. Good safety feature! 
# * Use with foreach or other parallelizing functions to perform a function many times at once with different inputs
# * Tuck functions away in their own script for neatness. Also, can use Rstudio debugger!
# * Debugger: insert `browser()` anywhere in the function to debug; ONLY if sourced from another script!


# Example of debugging

source('functions.R') # Notice that we have a new function, a function summarizing random integers.

summarizePois(mean = 5, n_numbers = 20, n_replicates = 10, debug = T)

# Exercise : Write your own function to summarize a vector of numbers.