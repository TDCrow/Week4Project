grass_colour <- "chartreuse4"
line_colour <- "white"
background_colour <- "chartreuse4"
goal_colour <- "#7E3C5D"

ymin <- 0 # minimum width
ymax <- 80 # maximum width
xmin <- 0 # minimum length
xmax <- 120 # maximum length
# Defining features along the length
boxEdgeDef <- 18
boxEdgeOff <- 102
halfwayline <- 60
sixYardDef <- 6
sixYardOff <- 114
penSpotDef <- 12
penSpotOff <- 108

# Defining features along the width
boxEdgeLeft <- 18
boxEdgeRight <- 62
sixYardLeft <- 30
sixYardRight <- 50
goalPostLeft <- 36
goalPostRight <- 44
CentreSpot <- 40

# other dimensions
centreCirle_d <- 20

padding = 5

circleFun <- function(center = c(0,0),diameter = 1, npoints = 100){
    r = diameter / 2
    tt <- seq(0,2*pi,length.out = npoints)
    xx <- center[1] + r * cos(tt)
    yy <- center[2] + r * sin(tt)
    return(data.frame(x = xx, y = yy))
}

#### create center circle ####
center_circle <- circleFun(c(halfwayline,CentreSpot),centreCirle_d,npoints = 100)

goal_shape <- data.frame(x=c(0, 120),
                         xend=c(0, 120),
                         y=c(36,36), 
                         yend=c(44,44))