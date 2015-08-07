setwd("~/Documents/non-indexed/Stat 139/Final Project/Data/Stat-139-Final-Project/")

#read inital data file
data <- read.csv("Premier League 2011-12 Match by Match.csv")

#aggregating total attempts
data$Total.Attempts <- rowSums(data[, c(64:75)])

#choosing variables for analysis
sub_data <- subset(data, select = c("Date", "Team", "Opposition", "Venue", "Goals", "Goals.Conceded", "Shots.On.Target.inc.goals",
                                    "Shots.Off.Target.inc.woodwork", "Blocked.Shots", "Total.Successful.Passes.All",
                                    "Total.Unsuccessful.Passes.All", "Assists", "Key.Passes","Successful.Dribbles",
                                    "Unsuccessful.Dribbles", "Touches", "Duels.won", "Duels.lost", "Tackles.Won", 
                                    "Tackles.Lost", "Total.Clearances", "Blocks", "Interceptions", "Recoveries",
                                    "Total.Fouls.Conceded", "Total.Fouls.Won", "Yellow.Cards", "Red.Cards",
                                    "Saves.Made", "Challenge.Lost", "Team.Formation", 
                                    "Dispossessed", "Total.Attempts"))

#storing the file with desired variables
write.csv(sub_data, "small_soccer_data.csv", row.names = F)


#tidying data
library(dplyr)

data_tbl <- tbl_df(sub_data)
grouped <- group_by(data_tbl, Date, Team, Opposition, Venue)
compact.data <- summarise_each(grouped, funs(sum))

#subsetting venue = home because each game is duplicated as home and away
final.data <- subset(compact.data, Venue == "Home")

#creating chances.created variable
final.data$Chances.Created <- final.data$Assists + final.data$Key.Passes

#creating chances faced in away data set
data.away <- subset(compact.data, Venue == "Away")
data.away$Chances.Faced <- data.away$Assists + data.away$Key.Passes

data.away <- data.away[, c("Date", "Team", "Chances.Faced")]
names <- names(data.away)
names[2] <- "Opposition"

names(data.away) <- names

#including Chances.Faced into final.data
final.data <- merge(final.data, data.away, by = c("Date", "Opposition"))

#renaming columns
names <- names(final.data)
names[7] <- "Shots.On.Target"
names[8] <- "Shots.Off.Target"
names[10] <- "Total.Successful.Passes"
names[11] <- "Total.Unsuccessful.Passes"

names(final.data) <- names

#reading in file with correct goal numbers
library(engsoccerdata)
data(Package = "engsoccerdata2")
data_rep <- engsoccerdata2

season <- subset(data_rep, Season == 2011 & division == "1", select = c("Date", "home", "visitor", "hgoal", "vgoal"))
ordered_season <- season[order(season$Date, season$home), ]

#replacement of goal figures
final.data <- final.data[order(final.data$Date, final.data$Team),]

final.data$Goals <- ordered_season$hgoal
final.data$Goals.Conceded <- ordered_season$vgoal


#Creating new
#offense power
final.data$p_o <- final.data$Goals / final.data$Chances.Created

#defense power
final.data$p_d <- final.data$Goals.Conceded / final.data$Chances.Faced

#goal difference
final.data$Goal.Difference <- final.data$Goals - final.data$Goals.Conceded

#changing an NA to 0 in p_d
final.data[355,37] = 0

#write this new data set into a new file
write.csv(final.data, "summarized_data.csv", row.names = F)


#####################################################################################################################
#final.data <- read.csv("summarized_data.csv")

#removing venue and date
model.data <- subset(final.data, select = -c(Venue, Date, Goals, Goals.Conceded))

#split data set in two
n <- nrow(model.data)
half.point <- round(nrow(model.data)/2)

train.data <- model.data[1:half.point, ]
test.data <- model.data[(half.point+1):n, ]

#scientific model
model0 <- lm(Goal.Difference ~ 1, data = train.data)
summary(model0)

full_model <- lm(Goal.Difference ~ ., data = train.data)
summary(full_model)
