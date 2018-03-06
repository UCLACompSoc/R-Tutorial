###########Computational Sociology Working Group###########
###########INTRO TO PROGRAMMING IN R WORKSHOP: 1/18/2017###########


###########STEP 0: MOTIVATION###########



#R is: reproducible, free, powerful for statistics/data analysis and data visualization, popular in many disciplines and in industry for data analysis, has lots of resources for learning and troubleshooting, a desirable skill for jobs in and out of academia
#R is not: always intuitive, so popular in Sociology, as fast as python, backed up by a company like STATA or SAS


###########STEP 1: INSTALL R AND R STUDIO###########

#troubleshooting?


###########STEP 2: ORIENTING YOURSELF TO R###########

#opening R studio, opening a new script. If you save a script where does it save? Your "working directory." What are comments vs code? how do you "hide" a section to make code more readable? "Help" window pane
#what are the different window panes: console, enviornment, packages?

#how do you run code?

#its really just a very fancy calculator:
2+2
1/3

#what is a package? install a new package with 'install.packages', and then tell R you are using it in this session with 'library':
install.packages("ggplot2")
library(ggplot)

#what if you get an error? 1) check syntax, R like any programming language is NOT THAT SMART! Capitalizations, and punctuation matter (e.g., ggplot isn't the same as GGPLOT) 2) look it up in the "help" window pane in R studio, or google the error message or what you are trying to accopmplish (stack exchange is your bff) 3) ask a R friend, go to CompSoc office hours, go to ATS/IDRE statistics office hours. 

#how do you run code?



###########STEP 3: BASIC OBJECTS AND STRUCTURES IN R###########

#what is object oriented programming? what is an "object"? are STATA, Python, or Excel object oriented programming? 


#VECTORS
myvector1<- c(2,8,3,4,5,6,712) #now check out your environment!

myvector1 

myvector1[2] #what does this do?
myvector1[2:4] #what does this do?

myvector1[-1]
#on your own, what is the 5th element (item) in myvector1? 

#MATRICES
myvector_modified<- myvector1[2:4] #make a NEW object. check out your environment. 
myvector_modified
myvector_modified[1] #what will this return?

mymatrix1<- matrix(c(2, 4, 3, 1, 5, 7), nrow=3, ncol=2)
mymatrix1
dim(mymatrix1) #what do you tink this does?
mymatrix1[2,] #2nd row of mymatrix1
mymatrix1[,2] #2nd column of mymatrix1
#on your own, try assigning the 2nd row of mymatrix1 as a new object, called "newobject." 


#OTHER DATA TYPES

#Your data types may be a mix of numeric, characters, a mix, or other types of data
mynumbers<- c(2,8,3,4,5,6,712) #now check out your environment!
class(mynumbers)
mycharacters<- c("R", "is" ,"pretty", "cool")
class(mycharacters)
mynumbersandcharacters<- c("R", 2, "is" ,"pretty", "cool", 2, 4,5) 


mylist <- list("a" = 2.5, "b" = TRUE, "c" = 1:3) #LISTS (mix of data types)
mydataframe <- data.frame("Favorite Color" = c("red", "blue"), "Age" = c(11,12), "Name" = c("Mary","Anna"))  #dataframes more on this soon....


#Extra Tricks! For more to try on basic R data structures: https://swcarpentry.github.io/r-novice-inflammation/13-supp-data-structures/
len(myvector1) #what does this do?
is.na(myvector1) #what does this do?
myvectorNA<- c(myvector1, "NA") #take a look at myvector NA, how is ti different from myvector1? try is.na() now on myvector NA, what happens?
as.numeric(is.na(myvectorNA)) #what does this do?

myvector2<- myvector1+ 1 #what does this do?
myvector2 #check it out

myvector3<- cbind(myvector2, myvector1) #cbind= "column bind". Look at myvector 3 to see what happened. How would you "row bind"?
myvector3

#######,-####STEP 3A: DATA STRUCTURES###########
#ou *could* put it all9 in manually:
mydataf<-as.data.frame(mymatrix1)
mydata <- data.frame(id = letters[1:22], variableX = 1:22, variableY = 230:251) 
head(mydata) #check out the first few rows
nrow(mydata) #what does this do?
names(mydata) #what does this give you?
class(mydata) #check what type of object this is
mydata$variableX  #just look at variableX
class(mydata$variableX)  #just look at variableX


mydata[2,"variableX"]

#what type of data is mydata$VariableX?
#what is the 1st element of VariableX?


#but let's just import data. What is a working directory? 

getwd()
setwd("C:/Users/Alina Arseniev/Dropbox/CompSoc_WG/R_Tutorial/") #fill in with somewhere on your computer. this needs to be PRECISE or R gets confused! Note the file path is slightly different for MAC vs PC users.
getwd() #check- is your working directory now where you intended?

#how do you read your data into R?

#R doesn't read in Excel spreadsheets, but it does read in files like .csv and .txt. Usually your data will be in .csv format. What is a CVS datafile? how is it different from Excel spreadsheet? How do you go back and forth? 

mydata1<- read.csv("OnlineNewsPopularity.csv")  #get csv here, and put in your working directory: http://archive.ics.uci.edu/ml/machine-learning-databases/00332/  #note this object is now in your "environment"
View(mydata1)
mydata2 <- read.csv(file.choose()) #quick trick! only drawback is that it is less reporducible...you don't have a record of the precise file name and location you used when writing the script
View(mydata2)  
rm(mydata2) #you may want to remove mydata2 from your environment so R doesn't have to keep track of it. How can you tell if this worked?
#if you want to remove ALL objects in your workspace (use carefully!): rm(list=ls(all=TRUE))

###########STEP 4: DATA MANIPULATION###########

View(mydata1)
ncol(mydata1) #what does this do? (n)umber of (c)olumns
#how would you check how many observations/rows are in mydata2? 
names(mydata1)

#subsettting data is VERY useful! more tricks here: https://www.statmethods.net/management/subset.html
vars<- mydata1[,2:3] #just take variables 2 and 3
head(vars)
observations<- mydata1[2:3,] #just take rows 2 and 3
View(observations)
edit(observations) #sometimes helfpul to view with this command, but avoid actually editing here since its not reproducible

specific_obs<- subset(mydata1, global_sentiment_polarity>.2)
nrow(specific_obs)                              
randsample<- mydata1[sample(1:nrow(mydata1), 20, replace=FALSE),] #take a random sample without replacement
#how many rows are in the random sample? how can you check?

#create a new variable: recode global_sentiment_polarity to binary absed on whether it is greater than .2 or not
global_sentiment_CAT <- ifelse(mydata1$global_sentiment_polarity > .2, c("positive"), c("negative")) 
head(global_sentiment_CAT)
table(global_sentiment_CAT)
#Here is a GREAT and very brief resource whenever you want to recode/make a new variable: https://www.statmethods.net/management/variables.html


###########STEP 5: DATA VISUALIZATION###########

hist(mydata1$shares)
hist(mydata1$global_rate_negative_words)
#make it a bit prettier:
hist(mydata1$global_rate_negative_words, col="light blue", main="Histogram of Amount of Negative Words in News Articles", xlab= "Negative Words",ylab="Frequency", xlim=c(0,.15)) #what are all these different arguments doing? try isolating them one by one to see. try turning this whole graph green!
plot(mydata1$shares, mydata1$global_rate_positive_words)
plot(mydata1$shares, mydata1$global_rate_negative_words)) #try rewriting this to make it prettier. for example, add a title with: main="titlehere") 

#Scatterplot Matrices can be really helpful!
pairs(~mydata1$shares+ mydata1$global_rate_positive_words+ mydata1$num_imgs, main="Scatterplot Matrix")


###########STEP 6: BASIC STATISTICS###########

summary(mydata1$shares)
sd(mydata1$shares, na.rm=TRUE) #specfic you want to remove NA's first. SD function gives you errors if you try it on data with NA's
#own your own, now check the summary statistics for the variable "global_rate_positive words"

#do basic stat tests
ttest(mydata1$shares, mydata1$global_rate_positive_words)
wilcox.test(mydata1$shares, mydata1$global_rate_positive_words) #nonparametric version of the t-test here

mymodel<- lm(mydata1$shares~ mydata1$global_rate_positive_words+  mydata1$global_rate_negative_words +mydata1$num_videos + mydata1$num_imgs +mydata1$data_channel_is_entertainment)
summary(mymodel)

#for generalized linear models, like logistic regression and poisson, use "glm" instead of "lm". look up "glm" in the Help for syntax. 

#try making a binary variable out of mydata1$shares usingn code we learned earlier, and then try predicting this binary variable in a logistic regression (hint: use glm with family=binomial)

###########WHAT NEXT???###########

#You have the basics here, next steps are to find a project/data set you want to work with. And when you get stuck, don't forget Google is your BFF! You can also come to CompSoc office hours and/or IDRE Stat Consulting Office Hours. 
