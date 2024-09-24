install.packages("readr")
price<-read.csv("C:\\Users\\DELL\\Desktop\\price.csv")


# Look at the first 6 observations
head(price)
# Check the dimension
dim(price)
model1 <- lm(price$Price ~price$Sale+price$weight+price$resoloution+price$ppi+price$cpu.core
            +price$cpu.freq+price$internal.mem+price$ram+price$battery, data = price)

# Get the model residuals
model_residuals = model1$residuals

# Plot the result
hist(model_residuals)

# Plot the residuals
qqnorm(model_residuals)
# Plot the Q-Q line
qqline(model_residuals)

# Install and load the ggcorrplot package
install.packages("ggcorrplot")
library(ggcorrplot)

# Remove the sale column
reduced_data <- subset(price, select = -Sale)

# Compute correlation
corr_matrix = cor(reduced_data)

# Compute and show the  result
ggcorrplot(corr_matrix, hc.order = TRUE, type = "lower",
           lab = TRUE)

model2 <- lm(price$Price ~price$Sale+price$resoloution+price$ppi+price$cpu.core
             +price$cpu.freq+price$internal.mem+price$battery, data = price[-c(33,48,75,77),])

pric.rem<-pric[-c(33,48),]
price.col <- subset(price, select = -c(price$resoloution,price$weight))
head(pric)

pric <- price[, -which(names(price) %in% c("weight", "resoloution"))]

model3<-lm(pric.rem$Price~.,data = pric.rem)

summary(model3)
avPlots(model3)
vif(model3)
influenceIndexPlot(model3,grid = T,id=list(n=10,cex=1.5,col="blue"))
influence.measures(model3)
qqPlot(model3)



# Get the model residuals
model_residuals = model2$residuals

# Plot the result
hist(model_residuals)

# Plot the residuals
qqnorm(model_residuals)
# Plot the Q-Q line
qqline(model_residuals)

# Anova test
anova(model1, model2)

# Print the result of the model
summary(model1)
summary(model2)

