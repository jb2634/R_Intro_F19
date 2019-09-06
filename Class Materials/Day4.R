#' ---
#' title: "(Very Basic) Probability and Statistics in R"
#' author: "Ben Augustine"
#' date: "August 28, 2019"
#' output: pdf_document
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

#' 
#' Here, we will cover some basic probability and statistics concepts R. This is not (so much) a lesson in probability or statistics, but a demonstration of how to do a few statistical things in R. 
#' 
#' ## Probability Distributions in R
#' 
#' We will start with the "dpqr" type functions for probability distributions. What are these? Let's look at the Binomial distrubtion help file. 
#' 
## ------------------------------------------------------------------------
?dbinom #RMarkdown will not print the help file for us here

#' 
#' dbinom() is the probability density or mass function (PDF or PMF, PMF for discrete distributions), pbinom is the cumulative distribution function (CDF), qbinom() is the quantile function, and rbinom() is the random number generator. Let's look at the random number generator. The Binomial distribution is a distribution for the number of successes for a given number of trials. It has parameters $K$, the number of trials and $p$, the success probability per trial. Say we are flipping a fair coin where a success is defined as a heads. Then $p$ can be assumed to be 0.5. If we flip it 10 times, $K$ is 10.
#' 
## ------------------------------------------------------------------------
rbinom(1,size=10,prob=0.5)

#' 
#' This is a single Binomial random deviate (1 random draw from a Binomial). We can draw multiple at once
#' 
## ------------------------------------------------------------------------
rbinom(10,size=10,prob=0.5)

#' 
#' How many succeses to we expect, on average? The expected number is $pK$. How much variability do we expect?
#' 
## ------------------------------------------------------------------------
vals=rbinom(1000,size=10,prob=0.5) #generate 1000 random numbers from a Binomial distribution
hist(vals) #create a histogram of the random numbers

#' 
#' How many times do we expect a single heads will be seen when flipping a fair coin 10 times? A good first approximation is to count the proportion of the times this happened in the random data we just simulated.
#' 
## ------------------------------------------------------------------------
sum(vals==1)/length(vals) #test if vals==1, count them, then divide by the number of numbers
mean(vals==1) #equivalent

#' 
#' This is called Monte Carlo simulation. We can approximate many different types of statistics and probabilities via calculations on simulated random numbers. But we can use the Binomial distribution itself to get the exact answer. We need to use the PMF, or probability mass function. What does this look like?
#' 
## ------------------------------------------------------------------------
x=0:10
y=dbinom(x,size=10,prob=0.5) #calculate the PMF values for 1 - 10 successes
plot(y~x,type="h",lwd=2)


#' 
#' We see the PMF is symmetric around 5 successes. What is the exact probability of 1 success?
## ------------------------------------------------------------------------
y[2] #if x is 0 - 10, the 2nd element is 1 


#' 
#' A *cumulative* mass function is the probability that a random variable is less than or equal to a certain value. Say a random variable $X$ has a Binomial distribution with parameters $p=0.5$ and $K=10$. How much probability mass is below value $x$? More formally, what is $P(X<=x)$. This is perhaps best visualized.
## ------------------------------------------------------------------------
y2=pbinom(x,size=10,prob=0.5) #calculate the CMF values for 1 - 10 successes
par(mfrow=c(2,1)) #set plotting environment to plot 2 per screen
plot(y~x,type="h",lwd=2)
plot(y2~x,type="h",lwd=2)
par(mfrow=c(1,1)) #set plotting environment back to plot 1 per screen


#' 
#' So that's cool, but what are some more interesting things we can do with probability in R? How about modeling population growth in the presence of environmental stochasticity? Say we have a population of size 100 that will undergo exponential population growth following $N_t=\lambda N_{t-1}$. First, let's look back at one of the exercises from Day 2. There, we wanted to predict the population size for 10 years, starting at $N=100$, with a constant growth rate of $\lambda=1.1$. How do we do that?
#' 
## ------------------------------------------------------------------------
Nyears=11 #How many years will there be? Starting year plus 10 more
N=rep(NA,Nyears) #preallocate a vector to store the yearly population sizes
N[1]=100 #fill in the first value
lambda=1.1
for(t in 2:Nyears){
    N[t]=lambda*N[t-1]
}
plot(N,type="l",xlab="Year",ylab="population size, N")

#' 
#' But now, let's consider that there are good and bad years (environmental stochasticity). In good years, $\lambda=1.2$ and in bad years $\lambda=0.9$. Good and bad years are equally likely. Let's project this population 100 years into the future.
#' 
## ------------------------------------------------------------------------
Nyears=101 #How many years will there be? Starting year plus 10 more
N=rep(NA,Nyears) #preallocate a vector to store the yearly population sizes
N[1]=100 #fill in the first value
lambda_bad=0.9
lambda_good=1.2
for(t in 2:Nyears){
  if(runif(1)<0.5){ #randomly apply either condition with probability 0.5
    N[t]=lambda_bad*N[t-1]
  }else{
    N[t]=lambda_good*N[t-1]
  }
}
plot(N,type="l",xlab="Year",ylab="population size, N")

#' 
#' Finally, what will happen if the bad years occur with probability 0.75 and good years with probability 0.25? Also, let's say bad years are a little worse with $\lambda=0.8$
## ------------------------------------------------------------------------
Nyears=101 #How many years will there be? Starting year plus 10 more
N=rep(NA,Nyears) #preallocate a vector to store the yearly population sizes
N[1]=100 #fill in the first value
lambda_bad=0.8
lambda_good=1.2
for(t in 2:Nyears){
  if(runif(1)<0.75){ #now bad years happen with probability 0.75
    N[t]=lambda_bad*N[t-1]
  }else{
    N[t]=lambda_good*N[t-1]
  }
}
plot(N,type="l",xlab="Year",ylab="population size, N")

#' 
#' ## Summary Statistics
#' Now, let's switch gears and look at some summary statistics. We will work with the *CO2* data set in R, which we used for plotting.
## ------------------------------------------------------------------------
data(CO2) #load the mtcars data set
CO2 #look at it
str(CO2) #query its structure
?CO2 #look at help file for more description

#' 
#' We can calculate basic summary statistics like this:
## ------------------------------------------------------------------------
mean(CO2$uptake) #mean CO2 uptake
median(CO2$uptake) #median
max(CO2$uptake) #maximum value
min(CO2$uptake) #minimum value
sd(CO2$uptake) #standard deviation
var(CO2$uptake) #variance

#' 
#' We can use the *summary* command to look at basic summary statistics for each variable:
## ------------------------------------------------------------------------
summary(CO2)

#' 
#' We can calculate all the pairwise correlations between variables:
## ------------------------------------------------------------------------
#In this case, only concentration and uptake are continuous data, the 4th and 5th column
cor(CO2[,4:5])

#' 
#' Yesterday, we looked at some plots for the CO uptake at the two sites by treatment:
## ------------------------------------------------------------------------
boxplot(uptake ~ Type, data = CO2, main = "Uptake VS. Type")
boxplot(uptake ~ Treatment, data = CO2, main = "Uptake VS. Treatment")

#' 
#' Do you think CO2 uptake varies by type? What about by treatment? How would we measure the difference? How about the mean? Let's subset the data into each group and compare the means.
## ------------------------------------------------------------------------
#subset out the data for Quebec
Q=CO2[CO2$Type=="Quebec",]
#subset out the data for Mississippi
M=CO2[CO2$Type=="Mississippi",]
#subset out the data for chilled
chill=CO2[CO2$Treatment=="chilled",]
#subset out the data for nonchilled
nonchill=CO2[CO2$Treatment=="nonchilled",]

#compare means of Quebec and Mississippi
mean(Q$uptake)
mean(M$uptake)

#compare means of chilled and nonchilled
mean(nonchill$uptake)
mean(chill$uptake)

#' 
#' The means are different, but is this just sampling variation, or is there evidence that the population parameters actually differ?
#' 
#' ## Basic Inferential Statistics
#' 
#' We can use t-tests to quantify the evidence for a difference.
## ------------------------------------------------------------------------
t.test(Q$uptake,M$uptake)
t.test(chill$uptake,nonchill$uptake)
?t.test #let's look at the assumptions we are making for these 2 tests

#' 
#' We can also use a linear model to quantify the evidence for a difference. This will do an analysis of variance (ANOVA). We do this using the *lm()* function. We will be estimating the parameters of $uptake_i = \beta_0 + \beta_1 Type_i + \epsilon$ and $uptake_i = \beta_0 + \beta_1 Treatment_i + \epsilon$. We assume $\epsilon \sim Normal(0,\sigma^2)$. We are testing the null hypotheses $H_0: \beta_1=0$. If the p-value is low enough, we reject the null in favor of the alternative $H_a: \beta_1\neq 0$ (not equal to).
#' 
#' In linear models with categorical predictors, we typically make one level the intercept. This decision is arbitrary. In R, the first level is automatically made the intercept.
## ------------------------------------------------------------------------
levels(CO2$Type)
levels(CO2$Treatment)
#We can reassign levels however we like
CO2$Type=relevel(CO2$Type,ref="Mississippi") #Make Mississippi the reference category

#' 
#' Now, let's fit these two linear models and compare the results to the t-test.
## ------------------------------------------------------------------------
mod1=lm(uptake~Type,data=CO2)
mod2=lm(uptake~Treatment,data=CO2)
summary(mod1)
summary(mod2)
#How do the p-values compare to the t-tests? Why do they differ?
t.test(Q$uptake,M$uptake,var.equal=TRUE) #set var.equal to TRUE
t.test(chill$uptake,nonchill$uptake,var.equal=TRUE) #set var.equal to TRUE
#A t-test with equal variances is equivalent to an ANOVA, which assumes
#equal variances by default

#But treatment could be confounded by type. Let's put both in the model.
#Here, we can test for a treatment effect controlling for type
mod3=lm(uptake~Treatment+Type,data=CO2)
summary(mod3)

#' 
#' So we have evidence that CO2 uptake varies by both type and treatment. But does it vary by Treatment the same for each type? Let's look at a boxplot:
#' 
## ------------------------------------------------------------------------
boxplot(uptake ~ Type+Treatment, data = CO2, main = "Uptake VS. Type and Treatment")

#' 
#' It looks like the treatment *might* have a larger effect for the Mississippi type. We can test this using a linear model with an *interaction* term. We last fit the model $uptake_i = \beta_0 + \beta_1 Treatment_i + \beta_2 Type_i$. The model with an interaction is $uptake_i = \beta_0 + \beta_1 Treatment_i + \beta_2 Type_i+ \beta_3 Treatment_iType_i$. The null hypothesis of no interaction is $H_0: \beta_3=0$ and the alternative is $H_0: \beta_3\neq 0$
#' 
## ------------------------------------------------------------------------
mod4=lm(uptake~Treatment*Type,data=CO2) #multiply instead of add for an interaction
summary(mod4)
AIC(mod1,mod2,mod3,mod4) #We can compare modes via their AIC values, too. Lower is better.

#' 
#' We can also look at residual plots to see if there is evidence that we are violating any assumptions of ANOVA.
#' 
## ------------------------------------------------------------------------
plot(mod4)

#' 
#' The first 2 plots indicate that the variance increases with the mean. This could be due to a missing covariate. Let's try adding the *concentration* variable.
#' 
## ------------------------------------------------------------------------
CO2$logConc=log(CO2$conc)
mod5=lm(uptake~Treatment*Type+logConc,data=CO2) #we'll add concentration on the log scale *waives hands*
plot(mod5) #still not perfect, but much better.
summary(mod5) #The concentration effect is highly significant. Now, so is the interaction between
#treatment and uptake.
AIC(mod4,mod5) #The new model is much better as judged by AIC as well.

#' 
#' Finally, we can plot the fitted model with a little bit of work. We won't look too deeply at this code now.
## ------------------------------------------------------------------------
logConc=seq(min(CO2$logConc),max(CO2$logConc),0.01)
newdata1=data.frame(Type="Quebec",Treatment="chilled",logConc=logConc)
newdata2=data.frame(Type="Quebec",Treatment="nonchilled",logConc=logConc)
newdata3=data.frame(Type="Mississippi",Treatment="chilled",logConc=logConc)
newdata4=data.frame(Type="Mississippi",Treatment="nonchilled",logConc=logConc)
predict1=predict(mod5,newdata=newdata1)
predict2=predict(mod5,newdata=newdata2)
predict3=predict(mod5,newdata=newdata3)
predict4=predict(mod5,newdata=newdata4)

plot(uptake~logConc,data=CO2)
points(uptake~logConc,data=CO2[CO2$Type=="Quebec"&CO2$Treatment=="chilled",],col="red",pch=16)
points(uptake~logConc,data=CO2[CO2$Type=="Quebec"&CO2$Treatment=="nonchilled",],col="blue",pch=16)
points(uptake~logConc,data=CO2[CO2$Type=="Mississippi"&CO2$Treatment=="chilled",],col="green",pch=16)
points(uptake~logConc,data=CO2[CO2$Type=="Mississippi"&CO2$Treatment=="nonchilled",],col="black",pch=16)
lines(predict1~logConc,col="red")
lines(predict2~logConc,col="blue")
lines(predict3~logConc,col="green")
lines(predict4~logConc,col="black")
legend("topleft",legend=c("Q-chilled","Q-nochill","M-chill","M-nochill"),
                          lty=c(1,1,1,1),col=c("red","blue","green","black"))

#' We see that the relationship between log(concentration) and uptake is not exactly linear. Let's try adding a quadratic term for log(concentration).
## ------------------------------------------------------------------------
mod6=lm(uptake~Treatment*Type+poly(logConc,2),data=CO2) #poly(x,2) adds a quadratic term
#same plotting code below
logConc=seq(min(CO2$logConc),max(CO2$logConc),0.01)
newdata1=data.frame(Type="Quebec",Treatment="chilled",logConc=logConc)
newdata2=data.frame(Type="Quebec",Treatment="nonchilled",logConc=logConc)
newdata3=data.frame(Type="Mississippi",Treatment="chilled",logConc=logConc)
newdata4=data.frame(Type="Mississippi",Treatment="nonchilled",logConc=logConc)
predict1=predict(mod6,newdata=newdata1)
predict2=predict(mod6,newdata=newdata2)
predict3=predict(mod6,newdata=newdata3)
predict4=predict(mod6,newdata=newdata4)

plot(uptake~logConc,data=CO2)
points(uptake~logConc,data=CO2[CO2$Type=="Quebec"&CO2$Treatment=="chilled",],col="red",pch=16)
points(uptake~logConc,data=CO2[CO2$Type=="Quebec"&CO2$Treatment=="nonchilled",],col="blue",pch=16)
points(uptake~logConc,data=CO2[CO2$Type=="Mississippi"&CO2$Treatment=="chilled",],col="green",pch=16)
points(uptake~logConc,data=CO2[CO2$Type=="Mississippi"&CO2$Treatment=="nonchilled",],col="black",pch=16)
lines(predict1~logConc,col="red")
lines(predict2~logConc,col="blue")
lines(predict3~logConc,col="green")
lines(predict4~logConc,col="black")
legend("topleft",legend=c("Q-chilled","Q-nochill","M-chill","M-nochill"),
                          lty=c(1,1,1,1),col=c("red","blue","green","black"))

#' This looks better, but still not perfect. Our inferential statistics support this observation:
## ------------------------------------------------------------------------
summary(mod6)
AIC(mod5,mod6)

#' 
#' Here is one final thing to look at, if we have time. We can use the *t-test()* command to test if the mean of one variable is different from zero. We can also get a confidence interval. Let's look at the CO2 uptake levels for Quebec.
## ------------------------------------------------------------------------
t.test(Q$uptake)

#' 
#' What assumptions does this t-test make? One is that the data are normally distributed. How could we get a p-value and confidence interval without this assumption? One way is to use *randomization methods*, specifically non-parametric *bootstrapping*. The idea is that if we have a random sample of data, we can randomly resample the data to see how *statistics* behave due to random variation. Let's try bootstrapping the sample mean.
#' 
## ------------------------------------------------------------------------
Niter=1000 #How many times to resample the data
store=rep(NA,Niter) #preallocate a vector to store the mean
for(i in 1:Niter){
  newdata=sample(Q$uptake,length(Q$uptake),replace=TRUE) #resample the data
  store[i]=mean(newdata) #store the mean of the resampled data
}

hist(store)
#what is the mean of the resampled data sets?
mean(store)
#this is pretty close to the mean of the actual data 
mean(Q$uptake)
#how might we calculate a p-value from the bootstrap distribution of the sample mean?
mean(store<=0)
#how might we get a confidence interval from the bootstrap distribution of the sample mean?
quantile(store,c(0.025,0.975))
#how does this compare to the confidence interval from the t-test?

#' 
#' 
#' ##Exercises
#' 1. Load the built in data set *PlantGrowth*. 
## ------------------------------------------------------------------------
data(PlantGrowth)

#' 
#' 1a. Describe this data set. What is each variable and how many observations are there? How many per treatment group? What is the mean, maximum, and minimum value for each treatment group (use R functions to find these)?
#' 
#' 1b. Use the *t.test()* function to see if there is evidence that weight for each treatment group differs from the control group.
#' 
#' 1c. Use the *lm()* function to do the same.
#' 
#' 2. Load the built in data set *RatPupWeight*. It is in the *nlme* package, so we need to load that first.
## ------------------------------------------------------------------------
library(nlme)
data(RatPupWeight)

#' 
#' 2a. Describe this data set. Make some plots to see if weight appears associated with any predictors.
#' 
#' 2b. Use the *lm()* function to see if there is evidence that weight for each treatment group differs from the control group. Do we need to control for other confounders? If so, does the inference about treatment effects change?
#' 
#' 3. Load the built in data set *mtcars*. 
## ------------------------------------------------------------------------
data(mtcars)

#' 
#' 3a. Describe this data set. Which variable is the response? Make some plots of the predictors vs. the response variable.
#' 
#' 3b. Use the *lm()* function to see which predictors are associated with vehicle miles per gallon. 
#' 
#' 4. Earlier, we looked at population growth that followed the equation $N_t=\lambda N_{t-1}$. We considered that the population growth rate $\lambda$ varied between good and bad years, which occurred with equal probability. But what if we allow more variation in $\lambda$? Modify the previous code  (or start from scratch) to vary lambda each year following a Normal random variable with mean 1.1 and standard deviation 0.1. Store the randomly-generated values for $\lambda$ and plot their histogram. Also, plot a simulated population trajectory.
#' 
