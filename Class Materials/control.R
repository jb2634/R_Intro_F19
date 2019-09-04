#' ---
#' title: "Logical Operators and Control Structures"
#' author: "Ben Augustine"
#' date: "August 26, 2019"
#' output:
#'   pdf_document: default
#'   html_document:
#'     df_print: paged
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
# knitr::purl("control.Rmd", output = "control.R", documentation = 2)

#' ##Logical Operations
#' 
#' Logical operators are used to test whether certain conditions hold. They are useful for many tasks, including subsetting data structures.
#' 
#' First, let's look at boolean data types, which can only take the values *TRUE* and *FALSE*.
#' 
#' 
## ------------------------------------------------------------------------
val=TRUE #assign that "val" is true
val #look at val
class(val) #query the type of object val is
is.logical(val) #ask if val is a "logical" data type
T #can also just use a capital T or F (unless you assign over them--try not to do that)

#' 
#' 
#' We can use *!* to negate a logical. A logical NOT. 
## ------------------------------------------------------------------------
val #look at val
!val #what is the opposite of val? "Not val"
!TRUE #opposite of TRUE is?

#' 
#' Often, we want to test for equality.
## ------------------------------------------------------------------------
val=5 #set val to 5
val==5 #test if val is equal to 5
val!=5 #test if val is not equal to 5

#' 
#' We can test for greater or less than using *>*, *<*, *>=*, and *<=*.
## ------------------------------------------------------------------------
val<5 #is val less than 5?
val>5 #is val greater than 5?
val>=5 #is val less than or equal to 5?
val<=5 #is val greater than or equal to 5?

#' 
#' We can combine test conditions using *&* and *|* (and, or).
## ------------------------------------------------------------------------
val_1=5
val_2=10
val_1>4&val_2<15 #is val_1 greater than 4 (TRUE) and is val_2 less than 15 (TRUE)
(val_1>4)&(val_2<15) #better to use parentheses (follows typical order of operations)
(val_1<4)&(val_2<15) #is val_1 less than 4 (FALSE) and is val_2 less than 15 (TRUE)
(val_1<4)|(val_2<15) #is val_1 less than 4 (FALSE) and is val_2 less than 15 (TRUE)
#these types of statements are equivalent to asking
TRUE&TRUE
TRUE&FALSE
TRUE|FALSE
FALSE|FALSE

#' 
#' We can test for missing values. Missing values in R are indicated with *NA*.
## ------------------------------------------------------------------------
data=c(1,3,NA,2,5) #specify a vector with 1 missing value
is.na(data) #is each element of "data" coded as NA?

#' 
#' Often, we want to identify which elements of a data structure meet certain conditions.
## ------------------------------------------------------------------------
which(is.na(data)) #which elements of "data" are coded as NA?
which(data>1) #which elements of "data" are greater than 1?

#' 
#' We often want to use logical tests to subset data structures
## ------------------------------------------------------------------------
idx=which(is.na(data)) #assign idx to be the elements of "data" coded as NA
data[-idx] #display data with idx removed
data[-which(is.na(data))] #alternatively, do this in 1 line
data[idx] #display only the element stored in idx
data=data[-idx] #permanently remove "idx" from "data" by reassigning "data"
data

#' 
#' Let's try using logical tests to subset a data frame with rows and columns
## ------------------------------------------------------------------------
data(iris) #load iris data set
str(iris) #look at its structure
iris$Species=="setosa" #test which elements of the Species column of the iris data frame are "setosa"
which(iris$Species=="setosa") #which elements meet this condition?
iris[iris$Species=="setosa",] #subset the iris data frame to only the setosa species
iris[-which(iris$Species=="setosa"),] #subset to exclude the setosa species
iris2=iris[-which(iris$Species=="setosa"),] #we need to assign the subsetted data to a data object to store it

#' 
#' Now, let's use logical tests to modify specific data values. What if we want to set the values of "sepal length" less than 5 as missing data (don't ask why!)?
## ------------------------------------------------------------------------
idx=which(iris$Sepal.Length<5) #find the sepal lengths less than 5
iris$Sepal.Length[idx]=NA
iris

#' 
#' *any* and *all* are useful functions for logical operators
## ------------------------------------------------------------------------
any(is.na(data)) #are any elements of "data" coded as NA?
all(is.na(data)) #are all elements of "data" coded as NA?

#' 
#' Finally, we can do math on logical data structures
## ------------------------------------------------------------------------
sum(iris$Sepal.Width<3) #add the elements of "sepal width" that are less than 3
sum(iris$Sepal.Width>3) #add the elements of "sepal width" that are more than 3
#looking at the inputs to sum(), we can see that TRUE is counted as 1 and FALSE as 0
iris$Sepal.Width<3
iris$Sepal.Width>3
sum(iris$Sepal.Width>3) #add the elements of "sepal width" that are more than 3
#Let's do the same for Sepal Length
sum(iris$Sepal.Length<6)
sum(iris$Sepal.Length>6)
#Why are we getting an NA?
sum(iris$Sepal.Length<6,na.rm=TRUE)

#' 
#' ##Control Structures
#' 
#' Control structures allow you to control the flow of execution of a series of R expressions. They are useful for automating repetitive tasks and performing particular tasks depending upon the values of the inputs. We will look at the *for*, *while*, and *if* structures.
#' 
#' *for* loops generally take the form:
## ----eval = FALSE--------------------------------------------------------
for( variable in sequence ){
  expression
  expression
  expression
}

#' They allow us do things like this:
## ------------------------------------------------------------------------
a=0 #initialize a variable with value 0
for(i in 1:10){ #we increment i from 1 to 10
  a=a+1 #for each iteration, i, we add 1 to a
  print(a) #prints the value of a on each iteration
}

#' 
#' One thing to understand here is what the sequence of numbers after *in* is doing. In the loop above, 1:10 specifies a *sequence of numbers* which *i* will cycle through.
## ------------------------------------------------------------------------
1:10
seq(from=1,to=10,by=1) #equivalent

#' 
#' We can specify any sequence of numbers (well, integers) we want. For example: 
## ------------------------------------------------------------------------
seq(from=10,to=1,by=-1) #specify a sequence starting at 10, ending at 1, incremented by -1
for(i in seq(10,1,-1)){ #put this sequence in the for loop
  print(i)
}

#' 
#' Another example:
## ------------------------------------------------------------------------
idx=c(1,2,200,4000) #define idx to be a sequence of arbitrary integers
for(i in idx){ #iterate through the sequence stored in idx
  print(i)
}

#' 
#' Often, one *for* loop is not sufficient for the task at hand. You may need to nest multiple for loops inside one another like this:
## ------------------------------------------------------------------------
for(i in 1:3){ #increment i from 1 to 3
  for(j in 1:3){ #increment j from 1 to 3
    print(c(i,j)) #prints the value of i and j on each iteration
  }
}

#' 
#' Here is an example where we set "val" to 0, add 1 on each i iteration, and add 10 on each j iteration
## ------------------------------------------------------------------------
val=0 #initialize a variable with value 0
for(i in 1:3){ #we increment i from 1 to 3
  for(j in 1:3){
    val=val+1 #for each j iteration we add 1 to val
    print(val) #prints the value of val on each iteration
  }
  val=val+10 #for each i iteration, we add 10
}

#' In the previous examples, i is incremented from 1 to 10, but not used directly. Often, we want to utilize the value of i, or whichever variable we use to represent the itertion number inside the loop. Here, we will store the values of a on each iteration of the *for* loop.
## ------------------------------------------------------------------------
store=rep(NA,10) #preallocate a vector of length 10 with missing values
a=0 #initialize a variable with value 0
for(i in 1:10){ #we increment i from 1 to 10
  a=a+1 #for each iteration, i, we add 1 to a
  store[i]=a #on each iteration, we store the current value of a into the ith index of store
}
store #evaluate store to see the values we recorded

#' 
#' This example introduces the concept of *preallocation*. Say we want to store the output of a loop in a vector. One way to do this would be to increase the size of the vector on each iteration like:
## ------------------------------------------------------------------------
vec=c() #specify an empty vector
for(i in 1:25){
  vec=c(vec,i) #append the loop index to "vec"
}
vec

#' This approach "grows" the vector one element at a time. *Preallocation* is where we specify the size of the vector (or other data object) ahead of time and fill in the elements one by one. For example:
## ------------------------------------------------------------------------
vec=rep(NA,25) #Preallocate an empty vector
for(i in 1:25){
  vec[i]=i #assign "i" to the ith element of "vec"
}
vec

#' *Preallocation* is much faster because the memory for the entire vector or data object is specified ahead of time rather than rewriting it each time the object changes. We can use Sys.time() to see this.
## ------------------------------------------------------------------------
vec=c() #specify an empty vector
a=Sys.time()
for(i in 1:25000){
  vec=c(vec,i) #append the loop index to "vec"
}
b=Sys.time()
b-a
vec=c() #specify an empty vector
vec=rep(NA,25000) #Preallocate an empty vector
a=Sys.time()
for(i in 1:25){
  vec[i]=i #assign "i" to the ith element of "vec"
}
b=Sys.time()
b-a

#' 
#' Now, we will move on to *while* loops. These are typically less commonly used, but sometimes necessary for particular tasks. *while* loops generally take the form:
## ----eval = FALSE--------------------------------------------------------
while( condition ){
  expression
  expression
  expression
}

#' 
#' *while* loops allow us do do things like:
## ------------------------------------------------------------------------
x=0
while(x<15){ #logical operator testing condition that x is less than 15
  x=x+2
  print(x)
}

#' 
#' Here, we added 2 to *x* until it was no longer less than 15. One thing to watch out for with *while* loops is an infinite loop. For example:
## ------------------------------------------------------------
x=0
while(x<15){
  x=x*2
  print(x)
}

#' 
#' If you run this loop, it will never satisify the condition required to stop. If you find yourself in this situation, you can press *escape* to stop the script from running (or press the *stop* button in the console).
#' 
#' The final set of control statements we will look at are *if* and *else*. These generally take the form:
## ------------------------------------------------------------
if( condition ){
  expression
} else {
  expression
}

#' 
#' Although, the *else* does not always need to be specified if you do not want to do anything if *condition* is not met.
#' 
## ------------------------------------------------------------------------
x=0
if(x==0){
  print("x is equal to 0")
}

x=1
if(x==0){
  print("x is equal to 0")
}else{
  print("x is not equal to 0")
}

#' 
#' Often, there are more than 2 options. We can then use *else if*
## ------------------------------------------------------------------------
x=1
if(x==0){
  print("x is equal to 0")
}else if(x<0){
  print("x is less than 0")
}else{
  print("x is greater than 0")
}

#' 
#' 
#' *if* statements are often nested within *for* loops to automate tasks that depend on the outcome of a logical operator. Here, we will specify a matrix with some missing values, loop over the rows with *i* and over the columns with *j* and count the missing values.
#' 
## ------------------------------------------------------------------------
mat=matrix(1:9,nrow=3,ncol=3) #specify a 3 x 3 matrix
mat[1,3]=NA #set two elements to NA
mat[3,2]=NA
mat
#how can we use a for loop to count the missing values in the matrix a?
count=0 #create an object to store the count of NAs
#go through each element of a, test for NA, and increment the count
for(i in 1:nrow(mat)){ #iterate across the rows of mat
  for(j in 1:ncol(mat)){ #iterate across the columns of mat
    if(is.na(mat[i,j])){ #is this element NA?
      count=count+1 #if yes, increment "count"
    }
  }
}
count

#an alternative solution without using a for loop
sum(is.na(a))

#' 
#' ##Exercises
#' 
#' 1. Let's load the built-in "iris" data set.
## ------------------------------------------------------------------------
data("iris")
head(iris) #show the first 6 rows of the iris data frame
head(iris,20) #look at first 20 rows

#' This data set contains various measurements for three iris species.
## ------------------------------------------------------------------------
unique(iris$Species) #what are the unique values of the "Species" column of the "iris" object?
table(iris$Species) #how many entries are there for each species?

#' 
#' 1a. Count the number of entries for each species (i.e., reproduce the results from table() above) using logical subsetting. Hint: iris$Species, ?sum
#' 
#' 1b. How many entries for species "setosa" have a petal width of less than 1? Hint: &
#' 
#' 1c. How many entries have a petal width of less than 1 or a sepal length less than or equal to 5?
#' 
#' 1c. How many entries have a petal width of less than 1 or a sepal length less than or equal to 5 and are of species "setosa"?
#' 
#' 1d. Are any sepal lengths less than 8? Are they all less than 8?
#' 
#' 1e. Use one or more *for* loops to count the number of entries for each species. Hint:
## ----eval=FALSE----------------------------------------------------------
counts=rep(0,3) #create a vector of length 3 to store the counts
for(i in ?){
  #find species for row i
  counts[i]=counts[i]+1#increment appropriate count
}

#' 
#' 1f. Let's look at a histogram of the values for sepal length in the iris data set.
## ----eval=FALSE----------------------------------------------------------
hist(iris$Sepal.Length)

#' Create a new variable "SepalCat" in the iris data frame, which will will use to break the sepal length measurements into sepal length categories, "small", "medium", and "large". Use a  *for* loop to assign these category levels. You can assign them using whatever criteria you like or you can use the quantiles of the data. For example, you could assign "small" to sepal lengths less than the 25th percentile, "medium" to sepal lengths in the middle 50th percentile, and "large" to sepal lengths greater than the 75th percentile. Hint:
## ----eval=FALSE----------------------------------------------------------
iris$SepalCat=NA #create a new data frame column SepalCat, filled with missing data
head(iris) #make sure it worked
for(i in ?){
  #is iris$Sepal.Length small? then assign small
  iris$SepalCat[i]="small"
  #is it medium? Then assign medium
  iris$SepalCat[i]="medium"
  #else assign large
  iris$SepalCat[i]="large"
}
iris$SepalCat

#' 
#' 2. Below is code modified from an earlier example. The *for* loop contains an error. Why does it not run? Can you fix it? Try not to look back at the original code.
## ----eval=FALSE----------------------------------------------------------
mat=matrix(1:9,nrow=3,ncol=3) #specify a 3 x 3 matrix
mat[1,3]=NA #set two elements to NA
mat[3,2]=NA
mat
#how can we use a for loop to count the missing values in the matrix a?
count=0 #create an object to store the count of NAs
#go through each element of a, test for NA, and increment the count
for(i in 1:nrow(mat)){ #iterate across the rows of mat
  for(j in 1:ncol(mat)){ #iterate across the columns of mat
    if(is.na(mat[i,j+1])){ #is this element NA?
      count=count+1 #if yes, increment "count"
    }
  }
}
count

#' 
#' 3. An equation for exponential population growth in discrete time is $N_t=\lambda N_{t-1}$. Use a *for* loop to calculate the population size over 10 years, starting with N(1)=100. Let's say lambda=1.1. What are $N_2$ through $N_{11}$? Can this be done without a for loop? Hint:
## ----eval=FALSE----------------------------------------------------------
lambda=1.1 #set lambda
N=rep(NA,11) #specify a vector to hold N for 11 years
N[1]=100 #fill in the first year
N #which indices do we need to fill in?
for(t in ?){ #loop over these indices
  N[t]=? #How do we plug in the equation above?
}

#' 
#' 
#' 4. Let's look at the lynx data set. Load and plot the data set. What are we looking at?
## ----eval=FALSE----------------------------------------------------------
data(lynx)
lynx
plot(lynx)
?lynx

#' Use a for loop to calculate the change in population size between years. Can you do this without a for loop? If so, how might you do it (advanced question!)?
#' 
#' 5. A very inefficient way to calculate C=A/B (A divided by B) is to subtract B from A until A is less than B to get the whole number and then use the remainder to get the remaining fraction. Say A is 100 and B is 11. How many times can we subtract 11 from A until A is less than 11? This is the whole number of times that A can be divided by B. Then we are left with the remainder. Use a while loop to calculate A/B. Hint:
## ----eval=FALSE----------------------------------------------------------
value=100
divisor=11
count=1 #number of times we have subtracted the divisor
remainder=100-11
while(divisor<remainder){
  count=? #increment count
  remainder=? #subtract divisor from remainder
}
count+remainder/divisor #the answer for C

#' 
#' 
