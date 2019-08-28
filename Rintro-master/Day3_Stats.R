### Summary of Days Before
# Day 1: Object type, assignment, basic subsetting and extraction, 
# Day 2: Logic, loops, and functions
# Day 3: Plotting with base and ggplot2

### Day 4###########################################
# Some basic statistical analyses
# this is not a lecture on Stats, but a lecture on Stats in R!
# probability distributions
# Linear regression, model selection
# Anova 

#### General summary statistics ####
summary(CO2)
mean(CO2$uptake)
median(CO2[CO2$conc=="95",]$uptake)
sd(CO2[CO2$conc=="95",]$uptake)
var(CO2[CO2$conc=="95",]$uptake)
mode <- function(x) { # to calculate the most common value
  tab <- table(x) # count the frequency of each unique value
  index.of.max<-nnet:::which.is.max(tab) #find the index of the value with max freq
  as.numeric(names(tab)[nnet:::which.is.max(tab)]) # turn the value into an integer
}

# Alternative way to define mode using base functions - very similar logic

Mode <- function(x) {
  ux <- unique(x) # What are the unique values? 
  return(ux[which.max(tabulate(match(x, ux)))]) # Which one of the unique values has the most occurrences? First one encountered is spit out, so ties are not handled elegantly.
}

mode(CO2$uptake)

### Probability Distributions ####
set.seed (234) # is your best friend for reproducibility. Initializes a pseudorandom number generator.
rnorm(n=100,mean=10,sd=2) #generate 100 values from a normal distribution with mean 10 and sd 2
?runif()
#R has many distributions in base package
#https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Distributions.html
plot(density(rnorm(n=100,mean=10,sd=2))) #what happens if we change n?
pnorm(8,mean=10,sd=2)
abline(v=8)

### Models and Regressions ####
# response variable and predictor variables, and find a pattern.
# look at data 
head(CO2)
ggplot(data=CO2,aes(x=CO2$conc,y=CO2$uptake))+
  geom_point()+
  geom_smooth(method="lm",se=TRUE,fullrange=TRUE,level=0.95)


#create linear regression models
# lm - linear model assumes that error around observed data are normally distributed around 0
# create a linear model that minimizes difference between observed and line

CO2.mod <- lm(data=CO2,uptake ~ conc) # regression formula
names(CO2.mod) #various output
plot(CO2.mod$residuals) # are these uniformly distributed, to support use of a linear model?
summary(CO2.mod) 

CO2.mod2 <- lm(data=CO2,uptake ~ conc+Type) # regression formula
summary(CO2.mod2)

ggplot(data=CO2,aes(x=CO2$conc,y=CO2$uptake,color=Type))+
  geom_point()+
  geom_smooth(method="lm",se=TRUE,fullrange=TRUE,level=0.95)

# compare models with AIC: Akaike's Information Criterion
# goodness of fit but penalty for number of parameters to discourage overfitting
AIC(CO2.mod,CO2.mod2) # which model is better/has lower AIC?

#predict new values of uptake for other concentrations
predictCO2<-data.frame(conc = rep(seq(1000,1490,10),2),Type=c(rep("Quebec",50),rep("Mississippi",50)))
newPredictions<-predict(CO2.mod2,predictCO2)

### Significance testing #####
# or do an ANOVA to look at differences in
# is variation in uptake due to variation in conc, type, or both?
CO2.aov2 <- aov(uptake ~ conc+Type, data = CO2)
summary(CO2.aov2)

ggplot(data = CO2) + 
  geom_point(aes(x = conc, y = uptake)) + 
  geom_smooth(aes(x = conc, y = uptake), method = 'lm', formula = y ~ log(x))


### Exercises with Answers
# Day 4: Statistics
  # 1) do a linear regression on the datasets::trees with girth and height and volume, with whatever hypothesis you can come up with
    trees<-datasets::trees
    ggplot()+
      geom_point(data=trees,aes(x=Girth,y=Height,color=Volume))
    ggplot()+
      geom_point(data=trees,aes(x=Girth,y=Volume))
    cor(trees$Girth,trees$Volume)
    tree.Hyp1<-lm(Volume~Girth,data=trees)
    summary(tree.Hyp1)
  # 2) based on your regression, predict new values of your response variable given new values of your explanatory variables
    predictVol<-data.frame(Girth = seq(21,40,length=20))
    newPredictions<-predict(tree.Hyp1,predictVol)
    predictVol<-cbind(predictVol,newPredictions)
    ggplot()+
      geom_smooth(data=trees,aes(x=Girth,y=Volume),method="lm",se=TRUE,fullrange=TRUE,level=0.95)+
      geom_point(data=trees,aes(x=Girth,y=Volume,color=))+
      geom_point(data=predictVol, aes(x=Girth,y=newPredictions),pch=17,col="red")
    
  # 3) create a vector called "age" that has 20 random values drawn from a uniform distribution from 21 to 30.
      age<-round(runif(20,min=21,max=30),0)
# Day 1: Assignment, subsetting
  # 4) Look at the sleep dataset from datasets:sleep
      sleep<-datasets::sleep
      head(sleep)
      str(sleep)
  # 5) How many extra hours, on average did everyone sleep?
      mean(sleep$extra)
  # 6) How many extra hours, on average, did people given Drug 1 sleep? 
      mean(sleep[sleep$group==1,]$extra)
  # 7) Use the cbind() function to add "age" from Exercise 3 to the datasets:sleep
      sleep<-cbind(sleep,age)
  # 8) Create another column to sleep, called 'More' and fill it with NA's. 
      sleep<-cbind(sleep,rep(NA, dim(sleep)[1]))
      colnames(sleep)[ncol(sleep)]<-"More"
      str(sleep)
  # 8) Create a list where the first item is the ID column, the second item is the drug column, the third item is the extra hours of sleep, and the fourth item is the age
      sleepList<-list(ID=sleep$ID,group=sleep$group,hours=sleep$extra,age=sleep$age)
# Day 2: Logic, Loops, Functions
  #9) Use the for loop to go through each row(i.e., person) of your sleep dataset. 
  #   If the person slept more hours (positive value for 'extra'), assign them a 1 in the 'More' column
  #   Else, assign them a 0 in the 'More' column   
      for(i in 1:nrow(sleep)){
        if(sleep[i,]$extra>0){
          sleep[i,"More"]<-1} else{
            sleep[i,"More"]<-0
          }
      }
# Day 3: Plotting
  #10 Use this skeleton to plot the distribution of sleep per group.
ggplot(data=sleep)+
  geom_density(aes(x=age,linetype=group))
  #11 Color the distributions and give them some transparency
ggplot()+
  geom_density(data=sleep,aes(x=age,linetype=group,fill=group),alpha=0.4)

  #12 Maually change the group colors to magenta and orange

ggplot()+
  geom_density(data=sleep,aes(x=age,linetype=group,fill=group),alpha=0.4)+
  scale_fill_manual( values = c("magenta","orange"))
