### Day 1###########################################
# This is an R script. The file extension is ".R"
# You can create other files in Rstudio, such as .txt, .Rmd, .stan which do different things, but .R is the basic,
# and no frills file format for saving your code and workflow.
# At the beginning of every script, and throught your script,  keep notes about what, why, when, how.
# You can use the # key at the beginning of each line (as we are here) to tell R that you are annotating 
# rather than writing executable script.

# Today covers: 
#.	Data Input/Output 
#.	Packages; installing and loading for use 
#.	Creating Data: Variables and objects
#.	Manipulating Data
#.	Introduce the CO2 dataset. 


### First Things First #############################
# See what the current working directory (wd) is
# and then set it to another location (where the file is)
getwd() # this is short for 'get working directory'. It tells you what director location R is currently working in
setwd("") # this will set the working directorty to the path file you provide inside quotations.
          # you can also set the working directory in Session>Set Working Directory
          # it is often most useful to set it to where ever the R file is, via: 
          # Session>Set Working Directory>To Source File Location
          
# Your working directory is where R searches for or saves data automatically.  If you need to load or 
# save data outside of the working directory, you must include the full path name to the relevant directory.  

### Topic 1: Data 

#Math, Calculations #### 
5+4 

# this does a calculation. Nothing is saved to the environment because you haven't assigned the output
10*4+2

# this another a calculation. Nothing is saved to the environment. 
cos(82) 

# a "function" is something that does something under the hood and is indicated by (). cos() takes the cosine.
# Inside any functions '()', are things called "arguments" that whoever created the function specified to be 
# part of the function's operation
# Multiple arguments are separated by ","
# let's see what the R help file for cos() says about the arguments needed, along with other helpful info:

?cos()
# Base R functions like cos() are preloaded with R, along with their help files. 
# Package-specific functions and their help files are accessible
# when you download and load the package into your environment.

#Assignment (of values to objects) ####
#To save the output of a calculation or function, you need to "assign" the answer to an object.
#More details at 
?assignOps 

# Examples:

x<-5+4 

# this uses a '<-' to  assign the value of '5+4' to 'x'
# Now, in your global environment, you have a data object named "x" that is the numeric value of 9

y = 10*4+2  

# You can also use "=" to assign to objects (Note that the order of operations holds in R, so 
# 10*4+2 is different from 10*(4+2))
# You can see to the right that x and y have now been added to your environment

sum(x, y) # you can use these objects as arguments inside functions.

# This takes the value of x and y and calculates the sum
# and you can assign the output of a function to an object:

sumxy <- sum(x, y)

#Object/Data types and structures ####
#More details at https://swcarpentry.github.io/r-novice-inflammation/13-supp-data-structures/

#Objects can be of different types: character, numeric, integer, logical, complex
# using is.x and as.x

is.numeric(4) 

# 4 is a floating point numeric. You cant see it but there are lots of points of precision in the background.

is.integer(4) # this gives FALSE because '4' is not an 'integer' type, even though it is a whole number

is.integer(4L) # this gives TRUE. The L after the 4 says that it is an integer. Storing 4 this way takes up less space.

is.double(4) # Double is a kind of numeric.


is.logical(TRUE) # "TRUE" is logical. "FALSE" is also logical

z <- 10*4^(1/3) #what type is 'z'?

class(z)
z_new <- as.integer(z) # this makes a new integer object called 'z_new' that is the transformed numeric object Z
class(z_new)

is.character("puppy") # character strings are always surrounded by "" to differentiate them from objects or other data types. 

# Numbers surrounded by "" are also characters:

is.numeric("4")

is.character("4")

# But you can transform them to numbers:

charToNumber <- as.numeric("4")

class(charToNumber)

#structures: Vectors, Matrices, Dataframes, Lists
#Vectors are strings of things, and they must always be the same type of "things"
aVector <- c(1,3,2.5,2)  # this creates a vector of 4 numbers using c()
?c()
class(aVector)
aVector


textvector <- c("apple", "plum", "banana")
class(textvector)
textvector

bVector <- aVector * 1.3 ; bVector # this creates a new vector. the ";" lets you write two executable lines on one line.
# So, you assign the output of avector * 1.3 and then print the object bvector

#You can also surround an assignment with () to automatically print the output:
  
(bVector <- aVector * 1.3)

# note that the above operation multiplied 1.3 by each element in aVector. R automatically handles mismatches in length by cycling through the
# object of shorter length, in this case 1.3.

# When you do basic math on 2 vectors of equal length, each element is automatically operated on in a pairwise manner:

aVector * bVector


#you can also use the functions sort(), rep(), and seq() to create or organize vectors.
dVector <- rep(1,10) # this creates a vector by saying you want the number 1 repeated 10 times

cVector<-sort(aVector,decreasing=FALSE ) # 'decreasing' is an argument in sort(). False is the default and that means it will NOT sort in decreasing order.

cVector<-sort(aVector) # with sort(),if you do not specify decreasing=FALSE, it will assume this because that's the default

eVector<-seq(from=2,to=42,by=4) # a sequence of values from  2 to 42, increasing by 4

length(aVector) # this tells you the number of entries inside 'aVector'

# If you want a series of numbers separated by 1, then you can use a colon between the min and max bounding numbers to do so

1:10
1.5:20.5
20.75:1.8 # you can even create it decreasing

#Matrix: entries are all one type, with some number of rows and columns 

aMatrix<-matrix(data = c(4,13), nrow = 3, ncol = 2, byrow = FALSE, dimnames = NULL) 
# matrix with 3 rows and 2 columns, where 4 and 13 are put into the matrix by columns.

dim(aMatrix) # this will give you the dimensions. the first number is the number of rows; the second is the number of columns. Rows are always
# the first index in R, columns the second.  

length(aMatrix) # you can also get the total number of entries 'aMatrix'. It is rows * columns

rbind(aVector,bVector) # you can also create matrices by binding vectors or matrices. Either by row with rbind()

cbind(aVector,bVector) # or by columns with cbind() 

rbind(aVector,eVector) # if you bind things of unequal length you get a warning message
eVector
aVector # Note that it cycled through the shorter vector, aVector, to make up the difference automatically

# if you try to bind things of different types, it will convert them to the same type, for instance

(mismatchvec <- cbind(eVector, textvector)) # Note the quotations around the elements of eVector?
class(mismatchvec[ , 1]) # It automatically turned the numeric vector to a character one. 
# also, remember how we said rows are always the first index and columns the second? Well here we see that in action
# the [ ,1] is the way you return all row elements in the first column of "matrix mismatchvec"
# if you did:
mismatchvec[1, ] # it would return all column elements of the first row
# or just return a specific element:
mismatchvec[1, 2] # element from row 1, col 3
# or maybe you want the 1 col elements from the first 3 rows:
mismatchvec[1:3, 1]
# and so on...

#Matrices vs. Dataframes: kind of like a matrix upgraded. I like to think of a dataframe as a bunch of vector columns that can be of different
# data types, bound together (cbind())) into one matrix dimensioned object

aDataframe<-data.frame() #create empty dataframe
people <- c("Alex", "Barb", "Carl") # create a vector of character names
ages <- c(19, 29, 39)  # create a vector of numeric ages
aDataframe <- data.frame(people, ages)  # create a dataframe with these two vectors
colnames(aDataframe) # the names of the columns are the names of the vectors
rownames(aDataframe) # the names of the rows are automatic here.  

# You can also do this all in one line:
aDataframe <- data.frame(people = c("Alex", "Barb", "Carl"),
                         ages = c(19, 29, 39))

# The columns get named whatever is on the left side of the "=" sign

colnames(aDataframe)
aDataframe
class(aDataframe[,1]); class(aDataframe[,2])
# Note how the data types are different? Dataframes also have a habit of automatically turning character vectors
# into factors.  This transforms simple strings into something with "levels". 
# It still looks like text, but they are stored and handled differently in R.

# let's try that again, but keep the people vector as characters:
aDataframe <- data.frame(people = c("Alex", "Barb", "Carl"),
                         ages = c(19, 29, 39), 
                         stringsAsFactors = FALSE)

class(aDataframe[,1]); class(aDataframe[,2])
# The argument stringsAsFactors specifies if you want to keep characters as character strings or turn them into factors.  
# It defaults to TRUE, though you can change that in your working environment.
?data.frame

aDataframe$people # In addition to [] indexing, you can also access data.frame columns using "$"
# '$' extracts the columns of that name. You cant use '$' with a matrix, even a matrix with column names

colnames(aMatrix) <- c("col1", "col2")
aMatrix
aMatrix$col1

names(aDataframe) # for data.frames, names() is equivalent to colnames()
aDataframe$height <- c("short","tall","tall") # you can also add a column to a dataframe with the specified values
names(aDataframe)

dim(aDataframe) # you can get the dimensions of a dataframe too. 
str(aDataframe) # this looks at the structure of 'aDataframe'. gives you all the info you need to know 
aDataframe_asMatrix<-as.matrix(aDataframe)# you can transform a dataframe into a Matrix. 
# But if the columns are of different types, they will be transformed to the same data type

# Lists are lists of things. they can be of different things that are each of different size, length, dimensions. 
# Lists are a very useful, flexible way of storing and manipulating data, though their utility can be less intuitive to 
# R beginners.  
aList <- list(aVector,aMatrix,aDataframe);aList # creating a list of 3 different things
aList <- list(aVector=aVector,aMatrix=aMatrix,aDataframe=aDataframe);aList #this does the same thing, but I've also given them names 
aList$aVector
# with lists, you can also use [[]] to index a list element
# So, 
aList[[1]] # extracts the first element, which was aVector
# You can further subset the list element if you want a column in a matrix, or an element in a vector:
aList[[1]][1]
aList[[2]][ ,1]
aList$aVector[1]
aList$aMatrix[ ,1]

# more advanced subsetting:



# Reading and Writing ###
datasets::CO2 # this is a dataset on a CO2 experiment with plants. It is a dataset that came automatically with R. 
head(CO2) # this looks at the head/beginning of CO2
tail(CO2) # this looks at the tail/end of CO2. These are useful when you want to make sure that everythign looks good
View(CO2) # This is another way to see the data. It opens up a new tab. 
summary(CO2) # this looks at a summary of the data. R automatically determines what things to summarize.
C02b <- CO2 # CO2 exists as a dataset deep inside R, but not in our environment here until you make an assignment.
write.csv(CO2b, file="CO2.csv") # this writes the CO2 dataset as a comma separated file into the current working directory.
# If you wanted to write or read from a directory other than the wd, you need to specify the full path name.
C02_readin <- read.csv("CO2.csv",header=TRUE) # this grabs the CO2.csv file from your current working directory, brings it into R, and assigns it to CO2_readin
?read.csv
?read.table

####################
#Exercises      ####
####################
# There are multiple ways to do most things in R. 
# To get help, look above for examples, reference help files, google, or just ask for help from us or your neighbors. 

# 1.  Create a 4X2 matrix of numbers (4 rows, 2 columns) called "classmat"
      # the first column should be the series of whole numbers from 4 to 7.
      # the second column should be a decreasing series of whole numbers from 10 to 7.
      # name their rows and columns whatever you like

# 2. Subset the matrix to return the first 3 row elements from the second column and 
      # assign to a new object called "submat"
      # sum the numbers in submat.
      # sort the numbers in submat in decreasing order

# 3. Create a data frame from the columns in classmat and call it "classdf"
      # change the second column of your data frame to characters

# 4. create a list of class  mat, submat, and classdf and make sure to name each element
      # return the 2nd element from the submat list element

# 5. How many entries are in CO2, and what features are being recorded? 

# 6. Change the concentration values to be of type 'factor' rather than of type 'numeric'

# 7. What is the 'type' for uptake? Change it to type 'integer'. 

### we'll do these together, but if you finish earlier go ahead and start trying, and use google for help:

# 8. What is the total uptake rate of all the plants?

# 9. What is the maximum uptake rate? Lowest uptake rate? 

# 10. What is the uptake rate of the 54th plant? What are the units of the uptake rate?

# 11. What is the average uptake rate of Mississippi plants that were chilled?


