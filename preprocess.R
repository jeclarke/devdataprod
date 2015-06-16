csv <- data.frame(read.csv("premierleague.csv"))
names(csv) <- c("year","spend","position")

ranked <- transform(csv, 
          year.rank = ave(spend, year, 
                          FUN = function(x) rank(-x, ties.method = "first"))
          )

#ranked$year.rank <- as.factor(ranked$year.rank)

plot (position~year.rank, data=ranked)
library(caret)
set.seed(98562)
inTrain = createDataPartition(ranked$position, p = 0.75, list=F)
training = ranked[inTrain,]
testing = ranked[-inTrain,]

mod <- lm(position~1+year.rank, training)
abline(mod)

pred <- data.frame(predict(mod, testing, interval="predict"))
names(pred) <- c("prediction","lower","upper")
result <- merge(pred, testing, by=0)
result$error <- abs(result$prediction - result$position)

print(mean(result$error))
