library(shiny)

# Define UI
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Strahlungsgesetze"),
  
  # Sidebar with a slider input
  sidebarPanel(
    helpText(HTML(paste("PS Klima, Wasser, Vegetation",
                        "<br>Wintersemester 14/15",
                        "<br>Universität zu Köln"))),
    tags$hr(),
    selectInput("object", "Objekt", selected = "Sonne", choices = c("Erde (288 K)"="Erde","Sonne (5800 K)"="Sonne","Mensch (308 K)"="Mensch")),
    sliderInput("temp","Temperatur (K)",min = 1,max = 10000,value = 5800),
    sliderInput("emission","Emissionsvermögen",min = 0,max = 1,value = 1, step = 0.1),
    
    tags$br(),
    tags$hr(),
    
    HTML("<img src='GitHub-Mark-32px.png' width='32px' height='32px'>    </img><a href='Link'>Code hier verfügbar</a>")

  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    htmlOutput("table"),
    plotOutput("plot"),
    htmlOutput("spectrum")
  )
))