#Final project for Statistics 139, Summer 2015

This code is part of a submission for a group final project for Statistics S-139: Introduction to Statistical Modeling, offered during Summer 2015 at the Harvard Summer School. The goal of this project was to predict the outcome of a game with goal difference as the response variable (as this is a course in linear regression, not logistic regression) and intuitively selected predictor variables.

I split the results from the 2011/2012 season of the English Premier league into training and test data sets, with the first half of the season representing the training data set and the second half of the season representing the test data set. I then built two models using stepwise regression in the forward and backward directions.

I began by creating an intercept-only model and a full model without interaction terms, and used these as the starting points for these stepwise regressions. I chose to exclude the interaction terms in order to avoid over-fitting and the introduction of multicollinearity issues into the model. This was because some of the variables were highly correlated (for example, offensive strength and chances created). I then proceeded to select one model based on AIC value, since the R-squared values for both models were approximately equal.

The results of the prediction are then shown with the observed values on a graph to show the differences between the predicted and observed goal difference.

**Next step**: The next step would be to select the predictor variables with a more reliable and robust method, perhaps by including all of them in the initial full model, or using another method such as k-fold cross-validation. As I continue to take courses on multiple regression and machine learning, I should be able to improve on this model.
