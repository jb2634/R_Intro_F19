# # # Day 5 # # # 

# Code style
# Best practices
# Other tips

# Code styling, organization -------------------------------------------------------------------------------------------

# There is nothing more important than comments.
# Make them easy to read, and organize them using headers. Make headers by repeating '-', '#', or '=' a minimum of 4 times.
# Any comments are better than none. You WILL forget what you did years hence, and others will not know.
# COMMENT COMMENT COMMENT

# Things at the beginning of your script -----------------------------------

# Get and set your working directory, automatically or manually
scriptName<-"/Day5_Outro"
setWDHere = function(){
  sourcePath<-rstudioapi::getSourceEditorContext()$path[1] # loc of this script
  sourceLoc<-strsplit(sourcePath,scriptName)[[1]][1] # get the parent folder
  setwd(sourceLoc) # set the wd to the parent folder
}
setWDHere()

# Libraries: put all libraries at the top of the script rather than throughout
if(!require(ggplot2)){install.packages("ggplot2")}

# at the top, define and assign parameters that change that create different datasets 
# this way you can reuse code
threshold<-0.75
sigma<-10

# Carriage returns for organization ---------------------

# Why is this line problematic?

out=matrix(data=NA,nrow=200,ncol=2);for(i in 1:2){out[,i]=rpois(n=200,lambda=3)}

# The following is much clearer - carriage returns make reading code easier; Excel can't do this!

out = matrix(data = NA, nrow = 200, ncol = 2)

for(i in 1:2){
  
  out[,i] = rpois(n = 200, lambda = 3)
  
}

# Indentation for organization ---------------------

# R does not require any specific indentation structure, so the following are equivalent:

# Implementation 1
# An array is just a 'bind' of some matrices of the same dimension bound across a third dimension. Dimensions are not limited to 3. 
# See package 'abind' for intuitive tools for combining matrices.
out = array(data = NA, dim = c(3,3,3)) 
set.seed(1)
for(i in 1:3){
for(j in 1:3){
for(k in 1:3){
out[i,j,k] = rpois(n = 1, lambda = 10)
}
}
}

# Implementation 2 :indentation
# either use the automatic indentation, or be consistent between tab vs. spaces

out_2 = array(data = NA, dim = c(3,3,3))
set.seed(1)
for(i in 1:3){
  for(j in 1:3){
    for(k in 1:3){
      out_2[i,j,k] = rpois(n = 1, lambda = 10)
      } # Ending brackets . . .
    }# . . . are easier . . .
  }# . . . to match to start

# They are the same
identical(out, out_2)

# OR add some additional carriage returns so it's not so cluttered

# Implementation 3

out_3 = array(data = NA, dim = c(3,3,3))

set.seed(1)

for(i in 1:3){ # Annotate what this loop represents
  
  for(j in 1:3){ # Annotate each one
    
    for(k in 1:3){ # So your readers and your future self know.
      
      out_3[i,j,k] = rpois(n = 1, lambda = 10)
      
    }
    
  }
  
}

# They're all the same.
identical(out, out_2, out_3)

# Using returns to unclutter things ---------------------

# Normal

3 + 6

# Any hanging operator followed by a carriage return will take the next line to
# complete the command. These are silly examples, but the concept is very useful.

3 + 
  6

3 >
  6

# Operators include math operations, logical operations, %>%, commas, parentheses, braces, brackets

# Reflow long expressions . . . 

theta = exp(
  beta_1 * covariate_matrix[,1] + 
  beta_2 * covariate_matrix[,2] + 
  beta_3 * covariate_matrix[,3] + 
  beta_4 * covariate_matrix[,4] + 
  beta_5 * covariate_matrix[,5] + 
  beta_6 * covariate_matrix[,6] 
  )

# . . . so that you can see the components easier than if they were on one line. 

theta = exp(beta_1 * covariate_matrix[,1] + beta_2 * covariate_matrix[,2] + beta_3 * covariate_matrix[,3] + beta_4 * covariate_matrix[,3] + beta_5 * covariate_matrix[,3] + beta_6 * covariate_matrix[,3])


# Say you have a function with a lot of arguments, potentially with long names

test_fn = function(argument_1, argument_2, argument_3, argument_4, argument_5, argument_6){
  
  sum(argument_1, argument_2, argument_3, argument_4, argument_5, argument_6)
  
}

# You can separate and unclutter arguments by including carriage returns

# Run test_fn all in one line.

test_fn(argument_1 = 1, argument_2 = 3, argument_3 = 5, argument_4 = 7, argument_5 = 9, argument_6 = 11)

# Or, include returns for clarity. Helpful when argument names are really long,
# so that they don't run off the page. Easier to identify typos.

test_fn(argument_1 = 1,
        argument_2 = 3,
        argument_3 = 5,
        argument_4 = 7,
        argument_5 = 9,
        argument_6 = 11
        )


# Best practices -------------------------------------------------------------------------

# Object names ---------------------

# Name format ----------------------

# This is very subjective; take with grains of salt.

# Typical naming formats 

# camelCase
# names have no spaces or symbols separating letters; instead, new words after the first get Capitalized.

aSquareMatrix = matrix(data = 1:9, nrow = 3, ncol = 3)

# snake_case 
# Generally no capitalization, but words are instead separated by underscores.

a_square_matrix = matrix(data = 1:9, nrow = 3, ncol = 3)

# Evidence is mixed as to which one is 'better'.

# http://www.cs.kent.edu/~jmaletic/papers/ICPC2010-CamelCaseUnderScoreClouds.pdf
# http://citeseerx.ist.psu.edu/viewdoc/download;jsessionid=376163100A8301ECD04E9CECBE0F834F?doi=10.1.1.158.9499&rep=rep1&type=pdf
# https://softwareengineering.stackexchange.com/questions/27264/naming-conventions-camelcase-versus-underscore-case-what-are-your-thoughts-ab


# MAIN TAKEAWAY is be consistent, but try them out and be open to any naming convention. 

# The names of objects -------------------------

# Object names should be sufficiently descriptive to deduce what it is.

a_square_matrix = matrix(data = 1:9, nrow = 3, ncol = 3)

# . . . is better than . . . 

m = matrix(data = seq(1,9), nrow = 3, ncol = 3)

# Try not to have names too long

a_square_matrix_that_is_one_to_nine_with_three_rows = matrix(data = seq(1,9), nrow = 3, ncol = 3)

# While you can use autocomplete, it's just not pretty or helpful.

# Assignment of variables to objects -------------

# You may be tempted to save everything into their own object. 
# You'll look up how to programatically assign names to objects . . .

# Say you have a number of analyses. You may try something like this; I know
# that to me it was intuitive at one point:

for(i in 1:3){
  
  # Assign something to a name that you can define programmatically, here referenced by loop index `i`.
  assign(x = paste0('matrix', i), value = matrix(data = seq(i,(9+i-1)), nrow = 3, ncol = 3))
  
}

# DO NOT DO THIS. THIS IS NOT GOOD PRACTICE. https://stackoverflow.com/questions/2679193/how-to-name-variables-on-the-fly

# If you want to add all the matrices together, what do you do? Well now you
# have to write out ALL of their names:

matrix1 + matrix2 + matrix3

# What if you have 1,000,000 matrices? You can't do it. What if you changed the naming convention between saves? Now it's impossible.

# What if you want to save them all? Now you have to loop through the index again, 

for(i in 1:3){
  save(list = paste0('matrix', i), file = paste0('matrix',i, '.Rdata'))
}

# Now what if you want to load them all? You have to identify all of the save files in your directory and loop again.

for(i in 1:3){
  load(paste0('matrix', i,'.Rdata'))
}

# HERE'S THE PROBLEM: If you add just one more output, you have to go back and
# change all of the loop indices. If you have 1,000,000 analyses, you now have
# polluted your directory with 1,000,000 little files instead of one bigger one.
# It's not a good way to live.

# But there are better ways. GENERALLY SPEAKING:

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Use the simplest data structure that accommodates all of your related outputs into one object #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Most of the time this will be a list. Instead of the above, you instead do:

out_list = list()

for(i in 1:3){
  out_list[[i]] = matrix(data = seq(i,(9+i-1)), nrow = 3, ncol = 3)
}

# We can add them all together easily, without caring how many elements are inside

# Good way
Reduce(f = `+`, x = out_list) # ?Reduce to see what this does.

# Bad way. Same result, but you will more easily make mistakes and can't accomplish this with more than a few items.
(matrix1 + matrix2 + matrix3)
  
# Now you can see where you go wrong if you have 1 million matrices to sum.

# We can use an even simpler structure.

# We can identify that all these matrices are of the same dimension and use an array, which is just a matrix in 3+ dimensions.

out_array = array(data = NA, dim = c(3,3,3)) # This is an array with 3 matrices of 3 rows and 3 columns, but it goes dim( nrow, ncol, nmatrices )

for(i in 1:3){ # For matrix i
  
  # Set matrix i equal to the following . . . 
  out_array[ , , i] = matrix(data = seq(i, (9+i-1)), nrow = 3, ncol =3) 
  
  # Notice I left row and column index blank. This is because I want it to take the values of the i'th matrix, and fill it in by row and column of the i'th matrix in the array.
  # Play with arrays to see how they function. Try subsetting a specific column of all matrices, and prove to yourself that it is the correct one.
  
}

# Now we sum the matrices, again, not caring how many are contained.

apply(X = out_array, MARGIN = c(1,2), FUN = sum)

# Which one is fastest? Let's try with a bigger set of matrices

# Assignment
for(i in 1:20){
  
  # Assign something to a name that you can define programmatically, here referenced by loop index `i`.
  assign(x = paste0('matrix', i), value = matrix(data = seq(i,(9+i-1)), nrow = 3, ncol = 3))
  
}

# List
out_list = list()

for(i in 1:20){
  out_list[[i]] = matrix(data = seq(i,(9+i-1)), nrow = 3, ncol = 3)
}

# Array 


for(i in 1:20){ # For matrix i
  
  # Set matrix i equal to the following . . . 
  out_array[ , , i] = matrix(data = seq(i, (9+i-1)), nrow = 3, ncol =3) 
  
}


(item = microbenchmark::microbenchmark("Array Sum" = apply(X = out_array, MARGIN = c(1,2), FUN = sum),
                               "Reduce Sum" = Reduce(f = `+`, x = out_list),
                               "Bad Sum" = matrix1 + matrix2 + matrix3 + matrix4 + matrix5 + matrix6 + matrix7 + matrix8 + matrix9 + matrix10 + matrix11 + matrix12 + matrix13 + matrix14 + matrix15 + matrix16 + matrix17 + matrix18 + matrix19 + matrix20)
)

microbenchmark::autoplot.microbenchmark(item)

# "The bad way" might be fastest, but notice we didn't have to change the very short command to run the sum again, whereas we had to change the sum for the bad way. The miniscule time we saved was offset by the extra several seconds re-typing everything.

# Get rid of matrixN items - uses regular expression to isolate specific string patterns.

rm(list = ls(pattern = 'matrix\\d'))


# Vectorization ---------------------

# Where possible, use vectorized, optimized functions instead of loops.

# Column means

n = 30000
ncol = 3
nrow = n / ncol

x = matrix(data = rnorm(n = n, mean = 0, sd = 1), nrow = nrow, ncol = ncol)

manual_colMeans = function(x){
  
  out = vector(mode = 'numeric', length = 3)
  
  for(i in 1:ncol(x)){
    
    out[i] = mean(x[,i])
    
  }
   
  return(out)
  
}

# Use the optimized function instead.

colMeans(x)

(item = microbenchmark::microbenchmark("Manual" = manual_colMeans(x), 
                                       "Optimized" = colMeans(x), times = 1e3))

microbenchmark::autoplot.microbenchmark(item)

# The `apply` family of functions is often faster than loops as well, but not
# always! In this example, the manual function and the apply function are
# basically saying the same thing, but they are nowhere near as fast as the
# optimized function.

# It's actually slower in this example.

manual_colMeans_apply = function(x){
  
  out = apply(X = x, MARGIN = 2, FUN = mean)
  
  return(out)
  
}

(item = microbenchmark::microbenchmark("Manual" = manual_colMeans(x), 
                                       "Manual (apply)" = manual_colMeans_apply(x), 
                                       "Optimized" = colMeans(x), times = 1e3))

microbenchmark::autoplot.microbenchmark(item)

# When is apply faster? When your operation is considering full vectors instead of elements.
# Take this extra slow for loop

manual_slow_colMeans = function(x){
  
  out = vector(mode = 'numeric', length = ncol(x))
  
  for(j in 1:ncol(x)){
    
    row_sum = 0
    
    for(i in 1:nrow(x)){
      
      row_sum = row_sum + x[i,j]
      
    }
    
    out[j] = row_sum / nrow(x)
    
  }
  
  return(out)
  
}

(item = microbenchmark::microbenchmark("Manual (slow)" = manual_slow_colMeans(x), 
                                       "Manual" = manual_colMeans(x), 
                                       "Manual (apply)" = manual_colMeans_apply(x), 
                                       "Optimized" = colMeans(x), times = 1e3))

microbenchmark::autoplot.microbenchmark(item)

# As much as possible, avoid looping over elements of a vector when the function
# applied to each element is the same. 

# Best option is to find an optimized function to do what you want.

# Next best is to use `apply`, or as in `manual_colMeans`, use the function with respect to the
# whole column. There are easy methods for parallelizing `apply` functions for extra speed.

# Use `for` loops for simple, quick operations, where the time expense of setting up parallel operations is high relative to the `for` loop. If your operation takes hours to days, consider parallel operations.

# https://www.r-bloggers.com/faster-higher-stonger-a-guide-to-speeding-up-r-code-for-busy-people/

# Microbenchmark can test your functions' speed on small datasets, so that you're not losing time on the large ones.


# Other tips -----------------------------------------------------------------------------

# Use different scripts for different purposes. Dont create a massive script.
# For example: 
# A script that loads data: load.R
# A script that cleans data: cleaning.R
# A script that has all your functions that you can then source in: func.R
# A script that analyses: do.R
# A script that does the post processing: postProcessing.R


# Regular expressions are important to learn if you are doing any manipulation
# of character vectors, file directories, etc. 

# Regular expressions are used with most all string search functions in R.

# ?substr ; ?gsub ; ?grep ; ?dir ; ?ls ; dozens more

# If you find yourself in a situation where you need it, I would use https://regex101.com/ to test and learn

# Microsoft R Open (MRO) --------------------------------------

# This version of R comes with math libraries for speeding up certain
# operations, but it also constrains package installations to come from a
# specific snapshot of CRAN from a specific date. 

# Therefore, if you have MRO version 3.4.4, everyone else with that version is
# GUARANTEED to have interoperability with your scripts. Using ordinary R, your
# packages are updated as you command, so you may have a mix of old and new
# packages. New users will have brand-new packages, and so it is not guaranteed
# that scripts will function exactly alike.

# Useful keyboard shortcuts - used most often -----------------

# Windows                Mac 

# Restart R Session - I find it best to run your script fresh from time to time.
# This way you can be sure it will run on other people's computers from start to
# finish.
# ctrl-shift-F10         command-shift-F10

# Show all keyboard shortcuts
# alt-shift-k            option-shift-k

# New document
# ctrl-shift-n           command-shift-n

# Move focus to editor
# ctrl-1                 ctrl-1

# Move focus to console
# ctrl-2                 ctrl-2

# Move focus to plot area
# ctrl-6                 ctrl-6

# Maximize editor
# ctrl-shift-1           ctrl-shift-1 ?

# Maximize console
# ctrl-shift-2           ctrl-shift-2 ?

# Maximize plot area
# ctrl-shift-6           ctrl-shift-6 ?

# Run code from beginning to current line
# ctrl-alt-b             command-option-b

# Re-run previous command 
# ctrl-shift-p           command-shift-p

# Comment/uncomment lines
# ctrl-shift-c           command-shift-c

# Make comment lines neater
# ctrl-shift-/           command-shift-/

# Insert %>%
# ctrl-shift-m           command-shift-m

# Edit all names of a variable in scope
# ctrl-alt-shift-m       ?

# Example # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# What's this for? If you find that a variable is just not named the way you
# want it, instead of manually re-setting all the names, just use this to do
# them all at once. A few caveats:

# You can highlight `wrong_name` and change all of the names of that variable
# simultaneously, but ONLY within the function's scope. IF you do it outside a
# function, you will be changing everything in the document (unless it's inside
# a function)

# Highlight `wrong_name` outside the function. You will see all instances of it.
# If you press ctrl-alt-shift-m, you will highlight only the ones outside the
# function. You can start typing it to `right_name` if you wish.

wrong_name

wrong_name

# If you highlight `wrong_name` inside the function, whether the argument or the call to the argument inside, you can change every appearance of it WITHIN the function.

test_fn = function(x, y, wrong_name){
  
  z = x + y - wrong_name
  
}

# End example # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Reference cards 
# https://cran.r-project.org/doc/contrib/Short-refcard.pdf
# https://cran.r-project.org/doc/contrib/YanchangZhao-refcard-data-mining.pdf