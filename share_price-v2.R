library(shiny)
library(plotly)
library(xlsx)
library(shinydashboard)
library(DT)

ui <- dashboardPage(skin = "blue",
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar( 
    
    fileInput("share.price",h4("Upload price data"))
    
  ),
  dashboardBody(
    tabBox( 
      tabPanel("Graph",plotlyOutput("plot")),
      
      tabPanel("Table",tableOutput('contents'))
    )
    
  )
)


server<-(function(input, output){
  
  
  output$contents <- renderTable({
    
    share.price <- input$share.price
    
    if(is.null(share.price))
      return(NULL)
    
    data_share<-read.xlsx(share.price$datapath, sheetName = "table")
    

  })
  
  output$plot <- renderPlotly({
    
    
    share.price <- input$share.price
    
    if(is.null(share.price))
      return(NULL)
    
    data_share<-read.xlsx(share.price$datapath, sheetName = "table")
    


    plot_ly(x = data_share$Date, type="candlestick",
            open = data_share$Open, close = data_share$Close,
            high = data_share$High, low = data_share$Low)
    
  })
  
})

shinyApp(ui, server)
