# Logistic-Regression-Shinny-App
This app allows its users to generate Logistic Regression and SVM based models using R's famous CARET (Classification and Regression Training) Logreg and SVM packages.
Access this application: https://sunilkappal.shinyapps.io/Logistic_Regression_Data_Dojo/

Understanding AIC (Akiake's Information Criteria) for Model selection and understanding the outputs of this app.

AIC basic principles
The basic principles that guide the use of the AIC are:

Lower indicates a more parsimonious model, relative to a model fit
with a higher AIC.

It is a relative measure of model parsimony, so it only has
meaning if we compare the AIC for alternate hypotheses (= different
models of the data).

We can compare non-nested models. For instance, we could compare a
linear to a non-linear model.

The comparisons are only valid for models that are fit to the same response
data (ie values of y).

Model selection conducted with the AIC will choose the same model as
leave-one-out cross validation (where we leave out one data point
and fit the model, then evaluate its fit to that point) for large
sample sizes.

You shouldn’t compare too many models with the AIC. You will run
into the same problems with multiple model comparison as you would
with p-values, in that you might by chance find a model with the
lowest AIC, that isn’t truly the most appropriate model.

When using the AIC you might end up with multiple models that
perform similarly to each other. So you have similar evidence
weights for different alternate hypotheses. In the example above m3
is actually about as good as m1.

You should correct for small sample sizes if you use the AIC with
small sample sizes, by using the AICc statistic.

You can read a detailed overview of AIC here: https://www.r-bloggers.com/how-do-i-interpret-the-aic/
