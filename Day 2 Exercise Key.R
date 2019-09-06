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
sum(iris$Species=="setosa")
sum(iris$Species=="versicolor")
sum(iris$Species=="virginica")

#' 1b. How many entries for species "setosa" have a petal width of less than 1? Hint: &
sum(iris$Species=="setosa"&iris$Petal.Width<1) 

#' 1c. How many entries have a petal width of less than 1 or a sepal length less than or equal to 5?

sum(iris$Petal.Width<1|iris$Sepal.Length<=5) 
sum(iris$Petal.Width<1|iris$Sepal.Length<5|iris$Sepal.Length==5) #equivalent

#' 1c. How many entries have a petal width of less than 1 or a sepal length less than or equal to 5 and are of species "setosa"?
sum(iris$Petal.Width<1|iris$Sepal.Length<=5&iris$Species=="setosa") 

#' 1d. Are any sepal lengths less than 8? Are they all less than 8?
any(iris$Sepal.Length<8)
all(iris$Sepal.Length<8)

#' 1e. Use one or more *for* loops to count the number of entries for each species. Hint:
## ----eval=FALSE----------------------------------------------------------
counts=rep(0,3) #create a vector of length 3 to store the counts
for(i in 1:nrow(iris)){
  #find species for row i
  if(iris$Species[i]=="setosa"){
    counts[1]=counts[1]+1#increment setosa count
  }else if(iris$Species[i]=="versicolor"){
    counts[2]=counts[2]+1#increment setosa count
  }else{
    counts[3]=counts[3]+1#increment setosa count
  }
  # print(counts)
}
counts

#' 
#' 1f. Let's look at a histogram of the values for sepal length in the iris data set.
## ----eval=FALSE----------------------------------------------------------
hist(iris$Sepal.Length)
quantile(iris$Sepal.Length)
#' Create a new variable "SepalCat" in the iris data frame, which will will use to break the sepal length measurements into sepal length categories, "small", "medium", and "large". Use a  *for* loop to assign these category levels. You can assign them using whatever criteria you like or you can use the quantiles of the data. For example, you could assign "small" to sepal lengths less than the 25th percentile, "medium" to sepal lengths in the middle 50th percentile, and "large" to sepal lengths greater than the 75th percentile. Hint:
## ----eval=FALSE----------------------------------------------------------
iris$SepalCat=NA #create a new data frame column SepalCat, filled with missing data
head(iris) #make sure it worked
for(i in 1:nrow(iris)){
  if(iris$Sepal.Length[i]<5.1){
    iris$SepalCat[i]="small"
  }else if(iris$Sepal.Length[i]<6.4){
    iris$SepalCat[i]="medium"
  }else{
    iris$SepalCat[i]="large"
  }
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

#"j+1" needs to be changed to "j". There are not ncol(mat)+1 columns

#' 
#' 3. An equation for exponential population growth in discrete time is $N_t=\lambda N_{t-1}$. Use a *for* loop to calculate the population size over 10 years, starting with N(1)=100. Let's say lambda=1.1. What are $N_2$ through $N_{11}$? Can this be done without a for loop? Hint:
## ----eval=FALSE----------------------------------------------------------
lambda=1.1 #set lambda
N=rep(NA,11) #specify a vector to hold N for 11 years
N[1]=100 #fill in the first year
N #which indices do we need to fill in?
for(t in 2:11){ #loop over these indices
  N[t]=lambda*N[t-1] #How do we plug in the equation above?
}
N

#' 
#' 
#' 4. Let's look at the lynx data set. Load and plot the data set. What are we looking at?
## ----eval=FALSE----------------------------------------------------------
data(lynx)
lynx
plot(lynx)
?lynx

#' Use a for loop to calculate the change in population size between years. Can you do this without a for loop? If so, how might you do it (advanced question!)?
Ndiff=rep(NA,length(lynx)-1)
for(t in 2:length(lynx)){
  Ndiff[t-1]=lynx[t]-lynx[t-1]
}
Ndiff

#alternatively,
for(t in 1:(length(lynx)-1)){
  Ndiff[t]=lynx[t+1]-lynx[t]
}
Ndiff


#' 5. A very inefficient way to calculate C=A/B (A divided by B) is to subtract B from A until A is less than B to get the whole number and then use the remainder to get the remaining fraction. Say A is 100 and B is 11. How many times can we subtract 11 from A until A is less than 11? This is the whole number of times that A can be divided by B. Then we are left with the remainder. Use a while loop to calculate A/B. Hint:
## ----eval=FALSE----------------------------------------------------------
value=100
divisor=11
count=1 #number of times we have subtracted the divisor
remainder=100-11
while(divisor<remainder){
  count=count+1 #increment count
  remainder=remainder-divisor #subtract divisor from remainder
}
count+remainder/divisor #the answer for C

#' 
#' 
