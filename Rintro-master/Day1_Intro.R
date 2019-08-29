### Day 1###########################################
# This is an R script. The file extension is ".R"
# At the beginning of every script
# provide some details about what, why, when.
# Things on each line can be performed, or executed, or run.
# Things on the same line are assumed to be a single calculation or function to be run.
# to put in annotations/ comments / notes, put  a "#" before it. Nothing after the "#" will run.
# If you try to execute/run this line, nothing happens

# Today covers: 
#.	Data Input/Output 
#.	Packages
#.	Creating Data: Variables and objects
#.	Manipulating Data
#.	Introduce the CO2 dataset. 


### First Things First #############################
# See what the current working directory (wd) is
# and then set it to another location (where the file is)
getwd() # this is short for 'get working directory'. It tells you where R is pointing to in your computer 
setwd("") # this will set the working directorty to the path file you provide inside quotations.
          # you can also set the working directory in Session>Set Working Directory
          # it is often most useful to set it to where ever the R file is, via: Session>Set Working Directory>To Source File Location
          
          

### Topic 1: Data 

#Math, Calculations #### 
5+4 # this does a calculation. Nothing is saved to the environment. 
10*4+2# this another a calculation. Nothing is saved to the environment. 
cos(82) # Curved parentheses indicate that 'cos' is a function. 
# Inside the '()', are things called arguments that the function uses to do the calculation.
# if multiple arguments are necessary, separate them with a ','

#Assignment (of values to objects) ####
#To do calculations and then save the answer, you need to "assign" the answer to an object.
#More details at http://stat.ethz.ch/R-manual/R-patched/library/base/html/assignOps.html
#We will see cases of <-, =, and ==
x<-5+4 # this uses a '<-' to  assign the value of '5+4' to 'x'
y=10*4+2  # this is also an assignment, but it uses the '='. 
#see that x and y have now been added to your environment
sum(x,y) # you can use these objects as arguments inside functions. This takes the value of x and y and calculates the sum


#Object/Data types and structures ####
#More details at https://swcarpentry.github.io/r-novice-inflammation/13-supp-data-structures/

#Objects can be of differen types: character, numeric, integer, logical, complex
# using is.x and as.x
is.numeric(4) # 4 is a floating point numeric. You cant see it but there are lots of points of precision in the background.
is.integer(4) # this gives FALSE because '4' is not an 'integer' type, even though it is a whole number
is.integer(4L) # this gives TRUE. The L after the 4 says that it is an integer. Storing 4 this way takes up less space.
is.double(4) # Double is a kind of numeric.
is.logical(TRUE) # "TRUE" is a logical thing. "FALSE" is also a logical thing
z<-10*4^(1/3) #what type is 'z'?
z_new<-as.integer(z) # this makes a new object called 'z_new' and makes it an integer and adds an L

#structures:Vectors, Matrices, Dataframes, Lists
#Vectors are strings of things
aVector<-c(1,3,2.5,2)  # this creates a vector of 4 numbers
bVector<-aVector*1.3 ; bVector # this creates a new vector. the ";" says you have another function on the same line
#you can also use the functions sort(), rep(), and seq() to create vectors.
dVector<-rep(1,10) # this creates a vector by saying you want the number 1 repeated 10 times
cVector<-sort(aVector,decreasing=FALSE ) # 'decreasing' is an argument in sort(). False is the default and that means it will NOT sort in decreasing order.
cVector<-sort(aVector) # with sort(),if you do not specify decreasing=FALSE, it will assume this because that's the default
eVector<-seq(from=2,to=42,by=4) # a sequence of values from  2 to 42, increasing by 4
length(aVector) # this tells you the number of entries inside 'aVector'

#Matrix: entries are all one type, with some number of rows and columns
aMatrix<-matrix(data = c(4,13), nrow = 3, ncol = 2, byrow = FALSE, dimnames = NULL) # matrix with 3 rows and 2 columns, where 4 and 13 are put into the matrix by columns.
dim(aMatrix)# this will give you the dimensions. the first number is the number of rows; the second is the number of columns
length(aMatrix) # you can also get the total number of entries 'aMatrix'. It is rows * columns
rbind(aVector,bVector) # you can also create matrices by binding vectors or matrices. Either by row with rbind()
cbind(aVector,bVector) # or by columns with cbind() 
rbind(aVector,eVector) # You cant bind things that are not of the same length or dimension

#vs. Dataframe: columns can be of different types, with some number of rows and columns
aDataframe<-data.frame() #create empty dataframe
people <- c("Alex", "Barb", "Carl") # create a vector of character names
ages <- c(19, 29, 39)  # create a vector of numeric ages
aDataframe <- data.frame(people, ages)  # create a dataframe with these two vectors
colnames(aDataframe) # the names of the columns are the names of the vectors
rownames(aDataframe) # the names of the rows are automatic here.  

aDataframe$people # the '$' extracts the columns of that name. You cant use a '$' with a matrix
aDataframe$height<-c("short","tall","tall") # you can also add a column to a dataframe with the specified values
dim(aDataframe) # you can get the dimensions of a dataframe too. 
str(aDataframe) # this looks at the structure of 'aDataframe'. gives you all the info you need to know 
aDataframe_asMatrix<-as.matrix(aDataframe)# you can coerce a dataframe into a Matrix. But if the columns are of different types, they will be coerced to the same thing 

#Lists are lists of things. they can be of different things that are each of different size, length, dimensions
aList<-list(aVector,aMatrix,aDataframe);aList # creating a list of 3 different things
aList<-list(aVector=aVector,aMatrix=aMatrix,aDataframe=aDataframe);aList #this does the same thing, but I've also given them names 

#Basic Data Manipulation ####
#index,extract,subset
# square brackets extract are used to extract.
aVector[3]  #this gets the 3rd item of 'aVector'
aMatrix[2,1] # this gets the item in the 4th row and 3rd column. the row comes before the ',' and the column goes after the ','
aMatrix[2,] # when you leave either the row or the column space blank, you are saying you want all of the rows or columns 
aMatrix[,1] # when you leave either the row or the column space blank, you are saying you want all of the rows or columns 
aMatrix[c(1,2,3),1] # this grabs the first column for rows 1, 2, and 3
aMatrix[1:3,1] # this does the same, but says it differently: grab the first column for rows 1 through 3, useful when you want to grab many
aList[[1]] # double square brackets extract from a list
aList$aVector # if you gave the items in your list names, you can also access them with a '$' like a dataframe

# Reading and Writing ###
datasets::CO2 # this is a dataset on a CO2 experiment with plants. It is a dataset that came automatically with R. 
head(CO2) # this looks at the head/beginning of CO2
tail(CO2) # this looks at the tail/end of CO2. These are useful when you want to make sure that everythign looks good
View(CO2) # This is another way to see the data. It opens up a new tab. 
summary(CO2) # this looks at a summary of the data. R automatically determines what things to summarize.
CO2<-CO2 # CO2 exists as a dataset deep inside R, but not in our environment here until you make an assignment.
write.csv(CO2,file="CO2.csv") # this writes the CO2 dataset as a comma separated file into the current working directory
C02_readin<-read.csv("CO2.csv",header=TRUE) # this grabs the CO2.csv file from your current working directory, brings it into R, and assigns it to CO2

### HELP ###
?summary() # putting a question mark in front of a function will bring up it's help page.


####################
#Exercises      ####
####################
# 1) Extract from aList the third element in the first item 
FirstItem_in_AList<-aList[[1]] # it is a vector
FirstItem_in_AList[3] # this grabs the 3rd element
aList[[1]][3] # this does the same thing as the two lines above, but in 1 action. 

# 2) How many entries are in CO2, and what features are being recorded? 
dim(CO2) # this tells you how many rows and columns are in CO2. the number of rows is the number of entries
head(CO2) # you can the column names, and therefore what is recorded
str(CO2) # provides all this information. You can also click on CO2 in the environment

# 3) What is the uptake rate of the 54th plant? What are the units of the uptake rate?
uptake<-CO2$uptake # this grabs just the uptake information.
uptake[54] #this grabs the 54th plant
CO2$uptake[54] # this does the 2 lines in 1 action
str(CO2) #will show you what the units are: umol/m^2 s
?CO2 # you can also find it in the help file for the dataset

# 4) What is the total uptake rate of all the plants?
sum(CO2$uptake) #this take the entire uptake column and calculates the sum. sum is a function that already exists in R

# 5) What is the maximum uptake rate? Lowest uptake rate?
max(CO2$uptake);min(CO2$uptake) # look at the max(imum) and min(imum) values of the uptake column
summary(CO2) # you can also get the values by looking at the summary of CO2

# 6) What is the average uptake rate of Mississippi plants that were chilled?
CO2$Treatment=="chilled" # this will tell you for each item if it was chilled or not.
CO2$Treatment==chilled # this will give you an error because it thinks 'chilled' is an object. You need the quotation marks
Chilled<-CO2[CO2$Treatment=="chilled",] # this creates a dataframe of just the plants that had the "chilled" treatment. Take the rows that say "chilled" in the Treatment column, 
Chilled$Type=="Mississippi" # this will tell you for each item if the 'Type' is 'Mississippi'
Mississippi_chilled<-CO2[Chilled$Type=="Mississippi",] # this creates a dataframe of just the plants that were from "Mississippi" Take the rows that say "Mississippi" in the Type column, 
mean(Mississippi_chilled$uptake) # this takes the average/mean of the uptake
CO2[CO2$Treatment=="chilled" &CO2$Type=="Mississippi",] # this uses logic to subset CO2 to the rows that have BOTH "chilled" as the treatment and "Mississippi" as the type.
mean(CO2[CO2$Treatment=="chilled" &CO2$Type=="Mississippi",]) # this takes the mean/average of that

# 7) Change the concentration values to be of type 'factor' rather than of type 'numeric'
class(CO2$conc) # this tells you that is of type "numeric"
is.factor(as.factor(CO2$conc)) # if you coerce it to be a factor and then ask if that is a factor, it will say yes. This line not permanently changed anything, though. 
CO2$conc<- as.factor(CO2$conc) # to make the change complete, assign it and overwrite the old version that was of type "numeric"
# 8) What is the 'type' for uptake? Change it to type 'integer'. 
class(CO2$uptake) # it is of type "numeric".
CO2$uptake<-as.integer(CO2$uptake) # same process as Problem 7.



