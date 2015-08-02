data$Total.Attempts <- data$Attempts.Open.Play.on.target + data$Attempts.Open.Play.off.target + data$Attempts.from.Throws.on.target

###
#summing total attempts
data$Total.Attempts <- rowSums(data[, c(64:75)])
sub_data<- subset(data, select = c("Date", "Player.ID", "Team", "Team.Id", "Opposition.id", "Venue",
                                   "Goals", "Shots.On.Target.inc.goals", "Blocked.Shots","Total.Successful.Passes.All",
                                   "Total.Unsuccessful.Passes.All", "Total.Attempts",
                                   "Key.Passes"))

#one year's worth of very detailed data, down to the individual. We plan on aggregating this for team stats
#multiple years' worth of match data, with only information about goals and home vs. away

# for every game, get the goal differential and use that as y variable
#model on a game to game basis

#run simulations to try to predict and compare to the limited data set

#concerns: goal difference range of values narrow