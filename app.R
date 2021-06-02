library(shiny)
library(data.table)
library(raster)
library(rgdal)
library(shape)
library(RgoogleMaps)
library(ggplot2)
getwd()

#UI
ui <- fluidPage(
  titlePanel("Top 5 most/least used Stations"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("따릉이 대여소"),
      
      selectInput("Station", 
                  label = "따릉이 대여소 선택",
                  choices = c("1153", "3533", 
                              "907", "1911",
                              "107", "1627",
                              "2534", "4202",
                              "2536", "2543"),
                  selected = "1153")
    ),
    mainPanel(plotOutput("map"))
  )
)

#Server Logic
server <- function(input, output){
  stationInput <- reactive({
    list_final[Station==input$Station]
  })
  
  lonInput <- reactive({
    stationInput()$Longitude
  })
  
  latInput <- reactive({
    stationInput()$Latitude
  })
  
  coordInput <- reactive({
    c(lonInput(), latInput())
  })

  output$map <- renderPlot({
    get_googlemap(center = c(lonInput(), latInput()), zoom = 17, maptype = "roadmap") %>%  ggmap()+
      geom_point(data = stationInput(), aes(Longitude, Latitude), size = 4, colour = '#008000') +
      geom_point(data = subway_latlon, aes(lon, lat), size = 1, colour = '#800000') +
      geom_point(data = bus, aes(X좌표, Y좌표), size = 1, colour = '#0000FF')
  })
}

#Run app
shinyApp(ui, server)
