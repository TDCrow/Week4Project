library(shiny)

shinyUI(fluidPage(
    
    # Application title
    titlePanel("2018 WorldCup Goal shot locations"),
    
    # Sidebar with a slider input for minutes in the match the goal was scored 
    sidebarLayout(
        sidebarPanel(
            sliderInput("min",
                        "Minute of Goal",
                        min = 1,
                        max = 120,
                        value = c(0,90)),
            checkboxGroupInput("stageGroup",
                               label = h3("Stage of Competition"),
                               choices = list("Group Stage", "Round of 16", "Quarter-finals", "Semi-finals", "3rd Place Final", "Final"),
                               selected = "Final"),
            br(),
            h3("Direction of shot"),
            checkboxInput("shotLines",
                          "Show shot direction",
                          value = FALSE),
            br(),
            p(em("Data from StatsBomb:", a("Github link", href = "https://github.com/statsbomb/open-data"))),
            img(src = "stats-bomb-logo.png", height = 50)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            h4("Brush and double click to zoom"),
            h4("Single click on a shot origin to see details"),
            plotOutput("distPlot",
                       click = "plot_click",
                       dblclick = "plot_dblclick",
                       brush = brushOpts(id = "plot_brush", resetOnNew = TRUE),
                       height = "600px", width = "800px"),
            tableOutput("scorerDetails")
        )
    )
)
)
