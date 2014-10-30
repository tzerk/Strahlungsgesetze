library(shiny)

# Define UI
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel(div(align = "center", class = "alert alert-info", h4("Strahlungsgesetze")), windowTitle = "Strahlungsgesetze"),
  
  # Sidebar with a slider input
  sidebarPanel(
    helpText(HTML(paste("PS Klima, Wasser, Vegetation",
                        "<br>Wintersemester 14/15",
                        "<br>Universität zu Köln"))),
    tags$hr(),
    selectInput("object", "Objekt", selected = "Sonne", choices = c("Erde (288 K)"="Erde","Sonne (5800 K)"="Sonne","Mensch (308 K)"="Mensch")),
    sliderInput("temp", HTML("Temperatur <i>T</i> (K)"),min = 1,max = 10000,value = 5800),
    sliderInput("emission",HTML("Emissionsvermögen <i>&epsilon;</i>"),min = 0,max = 1,value = 1, step = 0.1),
    
    tags$hr(),
    withMathJax(),
    withMathJax(
      helpText('Stefan-Boltzmann-Gesetz
               $$P=\\epsilon \\sigma T^4$$')),
    withMathJax(
      helpText("$$\\sigma = 5.67*10^{-6} [Wm^2K^{-4}]$$")),
    withMathJax(
      helpText("Wien'sches Verschiebungsgesetz
               $$\\lambda_{max}=\\frac{2897.8}{T}$$")),
    withMathJax(
      helpText("Planck'sches Strahlungsgesetz
               $$L_{\\lambda}=\\frac{2\\pi hc^2}{\\lambda^5}\\left(e^{\\frac{hc}{\\lambda K T}}-1 \\right)^{-1} $$
               $$h=6.62*10^{-34} [Js]$$
               $$K=1.38*10^{-23} [\\frac{J}{K}]$$
               $$c=3.0*10^8 [\\frac{m}{s}]$$")),
    
    HTML("<img src='GitHub-Mark-32px.png' width='32px' height='32px'>    </img><a href='https://github.com/tzerk/Strahlungsgesetze'>Code hier verfügbar</a>")

  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    uiOutput("table"),
    plotOutput("plot"),
    htmlOutput("spectrum")
  )
))