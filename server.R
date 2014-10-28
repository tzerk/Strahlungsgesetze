library(shiny)

##############################################################################
###                           FUNCTIONS                                    ###
##############################################################################

Boltzmann<- function(e,t) {
  sigma<- 5.6697*10^(-8)
  A<- round(e*sigma*t^4,0)
  return(A)
}

Planck<- function(t) {
  if(t>1000) max<- 10
    else max<- 30
    
  lambda<- seq(0,max,0.001)
  lambda<- lambda/1000000
  
  h<- 6.626*10^(-34)
  K<- 1.381*10^-(23)
  c<- 3*10^8
  
  term1<- (2*pi*h*c^2)/lambda^5
  term2<- exp(((h*c)/(lambda*K*t))-1)^-1
  L<- term1*term2
  return(list(L=L, lambda=lambda))
}

Wien<- function(t) {
  lambda_max<- round(2897/t,2)
  return(lambda_max)
}


##############################################################################
###                        MAIN PROGRAM                                    ###
##############################################################################

shinyServer(function(input, output, session) {
  
  observe({
    if(input$object == "Erde") {
      updateSliderInput(session, "temp", value = 288)
    }
    if(input$object == "Sonne") {
      updateSliderInput(session, "temp", value = 5800)
    }
    if(input$object == "Mensch") {
      updateSliderInput(session, "temp", value = 308)
    }
  })
  
  #### PLOT ####
  output$plot <- renderPlot({
    temp<- Planck(input$temp)
    L<- temp$L
    lambda<- temp$lambda*1000000
    
    par(mar=c(5,5,4,2)+0.1)
    
    
    
    plot(x = lambda, y = L, type = "l",
         main = "Planck'sches Strahlungsgesetz", 
         xlab = expression("Wellenlaenge ("*mu*"m)"),
         ylab = parse(text=paste("Strahlungsleistung (W/m^2/m)")))
    
  })
  
  #### TEXT ####
  output$table <- renderText({
    t<- input$temp
    e<- input$emission
    A<- Boltzmann(e,t)
    lambda_max<- Wien(t)
    
    str<- HTML(paste("<b>Parameter</b>",
                     "<br>Temperatur (K): ", t,
                     "<br>Emissionsvermögen: ",e,
                     "<br><br><b>Stefan-Boltzmann-Gesetz</b>",
                     "<br>Spezifische Ausstrahlung (W/m<sup>2</sup>): ",A,
                     "<br><br><b>Wien'sches Verschiebungsgesetz</b>",
                     "<br>&Lambda;<sub>max</sub>: ",lambda_max))
    str
  })
  
  #### IMAGE ####
  output$spectrum<- renderUI({ 
    HTML("<img src='spectrum.png'>Quelle: <a href='http://de.wikipedia.org/wiki/Elektromagnetisches_Spektrum'>Wikipedia</a></img>")
  })
      
})
