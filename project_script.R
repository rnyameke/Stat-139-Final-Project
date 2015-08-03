#read inital data file
data <- read.csv("Premier League 2011-12 Match by Match.csv")

#aggregating total attempts
data$Total.Attempts <- rowSums(data[, c(64:75)])

#choosing variables for analysis
#sub_data<- subset(data, select = c("Date", "Team", "Opposition", "Venue",
#                                   "Goals", "Goals.Conceded", "Shots.On.Target.inc.goals", "Blocked.Shots","Total.Successful.Passes.All",
#                                   "Total.Unsuccessful.Passes.All", "Total.Attempts",
#                                   "Key.Passes"))


sub_data <- subset(data, select = c("Date", "Team", "Opposition", "Venue", "Goals", "Goals.Conceded", "Shots.On.Target.inc.goals","Shots.Off.Target.inc.woodwork",
                                    "Successful.Dribbles", "Unsuccessful.Dribbles", "Through.Ball", "Touches", "Duels.won", "Duels.lost", "Tackles.Won", "Tackles.Lost",
                                    "Blocked.Shots", "Blocks", "Interceptions", "Recoveries", "Total.Fouls.Conceded", "Total.Fouls.Won", "Yellow.Cards", "Red.Cards",
                                    "Saves.Made", "Challenge.Lost", "Turnovers", "Dispossessed", "Big.Chances", "Big.Chances.Faced", "Total.Successful.Passes.All",
                                    "Total.Unsuccessful.Passes.All", "Total.Attempts", "Key.Passes"))

#storing the file with desired variables
write.csv(sub_data, "small_soccer_data.csv", row.names = F)


#tidying data
data_tbl <- tbl_df(sub_data)
grouped <- group_by(data_tbl, Date, Team, Opposition, Venue)
compact.data <- summarise_each(grouped, funs(sum))

#subsetting venue = home because each game is duplicated as home and away
final.data <- subset(compact.data, Venue == "Home")

#renaming columns
names <- names(final.data)
names[7] <- "Shots.On.Target"
names[8] <- "Shots.Off.Target"
names[32] <- "Total.Unsuccessful.Passes"
names[31] <- "Total.Successful.Passes"

#adding goal difference column
final.data$Goal.Difference = final.data$Goals - final.data$Goals.Conceded

#write this new data set into a new file
write.csv(final.data, "summarized_data.csv", row.names = F)


#####################################################################################################################

#split data set in two
n <- nrow(final.data)
half.point <- round(nrow(final.data)/2)

train.data <- final.data[1:half.point, ]
test.data <- final.data[(half.point+1):n, ]



#one year's worth of very detailed data, down to the individual. We plan on aggregating this for team stats
#multiple years' worth of match data, with only information about goals and home vs. away

# for every game, get the goal differential and use that as y variable
#model on a game to game basis

#run simulations to try to predict and compare to the limited data set

#concerns: goal difference range of values narrow