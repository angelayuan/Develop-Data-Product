---
title       : Do you have too many body fat?
subtitle    : Predict your body fat with basic body measurements
author      : angelayuan
job         : Developing Data Product @ Coursera
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [bootstrap, quiz]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

Nowadays, more and more people get too many body fat. An possible
way to prevent people from getting fat is to make them focus on their
body measurements and give them direct feedback of further information
(e.g. BMI, Percent body fat) which could be calculated or predicted based on their basic body measurements.

To this end, I developed a Shiny App to calculate people's **BMI** and to predict their **Fat Free Weigh** as well as **Percentage body fat** based
on their body measurements (e.g., height, weight, circumference of several body parts).

Linear models are trained based on the **fat** dataset in the UsingR package.


--- .class #id 

## Getting to know the fat data

To build a suitable linear model, we should get to know the data first. To this end, I did the following steps (hide the results because of the page limitation):

- Load the data and do exploratory Analysis, e.g. checking the first few lines

```r
library(UsingR); data(fat)
head(fat, 3)
```
- Fit a model with body.fat as outcome and all other variables as predictors, and then identify useful predictors from the summary of model information

```r
fit <- lm(body.fat ~ ., data=fat)
summary(fit)
```
- Fit a new model with selected predictors and check the accuracy 

--- .class #id 

## Key step in the prediction of body fat

BMI and fat free weight are key predictors of body fat but they are not basic measurements which user could easily measure with a ruler. Therefore we need to 

- train a model to predict the fat free weight.

```r
ffw_fit <- lm(ffweight ~ weight + BMI + chest + abdomen + thigh + forearm + wrist, data = fat)
```
- train a model (including BMI and fat free weight etc.) to predict the body fat

```r
bfat_fit <- lm(body.fat ~ weight + BMI + ffweight + chest + abdomen + thigh + forearm + wrist, data = fat)
```
- for new data of body measurements, (1) calculating BMI, (2) predicting fat free weight, and (3) predicting body fat. The following code is an example of calculating BMI.


```r
weight <- 110; height <- 80; (weight*0.4535)/(height*0.0254)^2
```

```
## [1] 12.08155
```


--- &radio
## User Guide

Just enter your body measurements and press the submit button. In order to get accurate prediction, you need to manually enter you weight and height and adjust other measurements according to your own data. BMI, fat free weight, and the body fat will be calculated. Morover, a histogram of the distribution of body fat will be also provided. You can compare your own body fat (indicated by a red line) with this population. Enjoy!

How should you use the App?

1. directly click submit button
2. _first fill in my information and then click submit button_
3. just fill in my height and weight, click submit button, and then I can get an accurate results
4. fill in my information and wait

*** .hint 
Fill in your information and click submit button to initiate the prediction processes.

*** .explanation 
You should fill in your information (enter height and weight and adjust other options). The more accurate your information, the more accurate the prediction.


