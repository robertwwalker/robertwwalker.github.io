library(shiny)

City <- c("Boston","Boston", "Boston", "Lowell","Lowell", "Lowell","Worcestor", "Worcestor","Worcestor","Springfield","Springfield","Springfield")
lat <- c(42.35, 42.355, 42.345, 42.63,42.625,42.635,42.27,42.265,42.275, 42.1,42.105,42.095)
lng <- c(-71.05,-71.045,-71.055,-71.316,-71.315,-71.317,-71.79,-71.785,-71.795,-72.6,-72.595,-72.605)
MassLocations <- data.frame(City, lat, lng)

ui <- fluidPage(titlePanel("Mass mpg by location"),
                
                # Create a new Row in the UI for selectInputs
                fluidRow(
                  column(3,
                         selectInput("City",
                                     "City:",
                                     c("All",
                                       unique(as.character(MassLocations$City))))
                  ),
                ),
                # Create a new row for the table.
                htmlOutput("table")
)


server <- function(input, output) {
  # Filter data based on selections
  dataShow <- reactive({
    data <- MassLocations
    if (input$City != "All") {
      data <- data[data$City == input$City, ]
    }
    data
  })
  
  # Display
  output$table <- renderTable(dataShow())
} 

# Run the application 
shinyApp(ui = ui, server = server)