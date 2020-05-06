library(shiny); library(dplyr); library(ggplot2); library(lubridate); 
source("helpers.R")


#Load data
WCshots_shiny <- read.csv("WCshots.csv")

shinyServer(function(input, output) {
    
    dataMin <- reactive({
        WCshots_shiny %>%
            filter(between(minute, input$min[1], input$min[2]))
    })
    dataStage <- reactive({
        dataMin() %>%
            filter(competition_stage.name %in% input$stageGroup)
    })
    
    ranges <- reactiveValues(x = NULL, y = NULL)
    
    output$distPlot <- renderPlot({
        g <- ggplot(WCshots_shiny, aes(location_x, location_y)) +
            #draw pitch
            geom_rect(aes(xmin=xmin, xmax=boxEdgeDef, ymin=boxEdgeLeft, ymax=boxEdgeRight), fill = grass_colour, colour = line_colour) +
            geom_rect(aes(xmin=boxEdgeOff, xmax=xmax, ymin=boxEdgeLeft, ymax=boxEdgeRight), fill = grass_colour, colour = line_colour) +
            geom_rect(aes(xmin=xmin, xmax=sixYardDef, ymin=sixYardLeft, ymax=sixYardRight), fill = grass_colour, colour = line_colour) +
            geom_rect(aes(xmin=sixYardOff, xmax=xmax, ymin=sixYardLeft, ymax=sixYardRight), fill = grass_colour, colour = line_colour) +
            geom_point(aes(x = penSpotDef , y = CentreSpot), colour = line_colour, size = 0.75) +
            geom_point(aes(x = penSpotOff , y = CentreSpot), colour = line_colour, size = 0.75) +
            geom_path(data=center_circle, aes(x=x,y=y), colour = line_colour) +
            geom_point(aes(x = halfwayline , y = CentreSpot), colour = line_colour, size = 0.75) +
            scale_x_continuous(limits = c(0,120), breaks = c(0,120)) +
            scale_y_continuous(limits = c(0,80), breaks = c(0,80)) +
            geom_vline(xintercept = c(0,60,120), color="white") +
            theme(panel.background = element_rect(fill = "chartreuse4"),
                  legend.position = c(0.5,0.85),
                  legend.background = element_rect(fill="lightblue", 
                                                   size=0.5, linetype="solid",
                                                   colour = "darkblue"),
                  axis.title = element_blank(),
                  axis.text = element_blank())
        #add shot lines        
        if(input$shotLines){
            g <- g +  geom_segment(data = dataStage(),
                                   aes(x = location_x,y = location_y, xend = shot.end_location_x, yend = shot.end_location_y), 
                                   alpha = 0.2, linetype = "dashed")
        }
        
            #add data
        g <- g + geom_segment(data = goal_shape,aes(x=x, xend=xend, y=y,yend=yend),inherit.aes = F, color="purple", size = 2) +
            geom_point(data = dataStage(), size = 3, alpha = 1, aes(colour = competition_stage.name)) +
            coord_cartesian(xlim = ranges$x, ylim = ranges$y, expand = FALSE)
        #print result
        g
        
    })
    output$scorerDetails <- renderTable({
        scorerDetails <- nearPoints(dataStage(), input$plot_click, xvar = "location_x", yvar = "location_y", threshold = 10)
        scorerDetails %>%
            select(minute, player.name, team.name, game_description, competition_stage.name) %>%
            rename("Minute of Goal" = minute, "Player name" = player.name, "Team name" = team.name, "Game" = game_description, "Stage" = competition_stage.name)
    })
    observeEvent(input$plot_dblclick, {
        brush <- input$plot_brush
        if(!is.null(brush)) {
            ranges$x <- c(brush$xmin, brush$xmax)
            ranges$y <- c(brush$ymin, brush$ymax)
            
        } else {
            ranges$x <- NULL
            ranges$y <- NULL
        }
    })
    
})
