#read inital data file
read.csv("Premier League 2011-12 Match by Match.csv")

#aggregating total attempts
data$Total.Attempts <- rowSums(data[, c(64:75)])

#choosing variables for analysis
sub_data<- subset(data, select = c("Date", "Player.ID", "Team", "Team.Id", "Opposition.id", "Venue",
                                   "Goals", "Shots.On.Target.inc.goals", "Blocked.Shots","Total.Successful.Passes.All",
                                   "Total.Unsuccessful.Passes.All", "Total.Attempts",
                                   "Key.Passes"))

#storing the file with desired variables
write.csv("sub_data", "small_soccer_data.csv", row.names = F)


#####################################################################################################################

#split data set in two
n <- nrow(sub_data)
half.point <- round(nrow(sub_data)/2)

train.data <- sub_data[1:half.point, ]
test.data <- sub_data[(half.point+1):n, ]



#one year's worth of very detailed data, down to the individual. We plan on aggregating this for team stats
#multiple years' worth of match data, with only information about goals and home vs. away

# for every game, get the goal differential and use that as y variable
#model on a game to game basis

#run simulations to try to predict and compare to the limited data set

#concerns: goal difference range of values narrow