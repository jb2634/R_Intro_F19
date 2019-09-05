
####################
#Exercises      ####
####################
# There are multiple ways to do most things in R. 
# To get help, look above for examples, reference help files, 
# google, or just ask for help from us or your neighbors. 

# 1.  Create a 4X2 matrix of numbers (4 rows, 2 columns) called "classmat"
# the first column should be the series of whole numbers from 4 to 7.
# the second column should be a decreasing series of whole numbers
# from 10 to 7.
# name their rows and columns whatever you like
first <- 4:7; first <- c(4, 5, 6, 7)
second <- 10:7
classmat <- matrix(data = c(first, second), 
                   nrow = 4, ncol = 2, 
                   byrow = FALSE)
classmat <- matrix(data = c(4:7, 10:7), 
                   nrow = 4, ncol = 2, 
                   byrow = FALSE)
classmat <- cbind(first, second)

row.names(classmat) <- c("one", "two", "three", "four")
row.names(classmat) <-1:4
colnames(classmat) <- c("col1", "col2")
classmat
# 2. Subset the matrix to return the first 3 row elements from the 
# second column and 
# assign to a new object called "submat"
# sum the numbers in submat.
# sort the numbers in submat in decreasing order

submat <- classmat[1:3,2]
sort(submat, decreasing = TRUE)
# 3. Create a data frame from the columns in classmat and call it "classdf"
# change the second column of your data frame to characters

classdf <- data.frame(one = classmat[,1], two = classmat[,2])
classdf <- as.data.frame(x = classmat)
class(classdf$col2)

classdf$col2 <- as.character(classdf$col2)

# 4. create a list of classmat, submat, and classdf and make sure to 
# name each element
# return the 2nd element from the submat list element

classlist <- list(classmat, submat, classdf)
names(classlist) <- c("element1", "element2", "element3")
classlist <- list(element1 = classmat, element2 = submat, element3 = classdf)

classlist[[2]][2]
classlist$element2[2]
classlist[["element2"]][2]

# 5. How many entries are in CO2, and what features are being recorded? 
head(CO2)
nrow(CO2)
class(CO2)
length(CO2)
length(CO2$uptake)
colnames(CO2)
names(CO2)
str(CO2)
# 6. Change the concentration values to be of type 'factor' rather 
# than of type 'numeric'

CO2$conc  <- as.factor(CO2$conc)
class(CO2$conc)
CO2$conc
# 7. What is the 'type' for uptake? Change it to type 'integer'. 
class(CO2$uptake)

CO2$uptake <- as.integer(CO2$uptake)

### We'll do these together, but if you finish early go ahead and 
# start trying, and use google for help:

# 8. What is the total uptake rate of all the plants?

sum(CO2$uptake)
# 9. What is the maximum uptake rate? Lowest uptake rate? 
max(CO2$uptake)
min(CO2$uptake)
range(CO2$upt)

# 10. What is the uptake rate of the 54th plant? What are the 
# units of the uptake rate?
CO2[54, "uptake"]
str(CO2) # "(umol/m^2 s)"

# 11. What is the average uptake rate of Mississippi plants that were 
# chilled?

CO2$Treatment

mean(CO2[CO2$Treatment == "chilled" & CO2$Type == "Mississippi", "uptake"])

summary(CO2[CO2$Treatment == "chilled" & CO2$Type == "Mississippi",])
