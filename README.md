# Week 4 Project

This peer assessed assignment has two parts. First, you will create a Shiny application and deploy it on Rstudio's servers. Second, you will use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about your application.

## Your Shiny Application

Write a shiny application with associated supporting documentation. The documentation should be thought of as whatever a user will need to get started using your application.
Deploy the application on Rstudio's shiny server
Share the application link by pasting it into the provided text box
Share your server.R and ui.R code on github
The application must include the following:

Some form of input (widget: textbox, radio button, checkbox, ...)
Some operation on the ui input in sever.R
Some reactive output displayed as a result of server calculations
You must also include enough documentation so that a novice user could use your application.
The documentation should be at the Shiny website itself. Do not post to an external link.

## About the Project
This project displays, on a virtual pitch, the location of shots that ended up as goals during the 2016 Football World Cup. The user can filter goals by competition stage or minute the shot was taken.

Additionally, the user can add lines showing the direction of the shot, as well as see more details about each shot by single clicking on the shot origins.

This respository includes the ui.R file, and the server.R file, as well as a helper file (which includes the dimensions for the pitch for the graph, the data used (WCshots.csv), and the logo for the data source (Statsbomb).

## The data
The data for this project comes from Statsbomb (see link for the github data respository: https://github.com/statsbomb/open-data).
The data documents details of every goal scored in the 2018 world cup. Variables used were: 
* Minute of the goal/location of the shot (x & y coordinates)/Team name of goalscorer/player name/end of shot location(x & y coordinates)/competition stage 
![alt text](https://github.com/TDCrow/Week4Project/blob/master/www/stats-bomb-logo.png?raw=true)



