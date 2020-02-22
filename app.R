library(ECharts2Shiny)
library(shiny)
library(shinydashboard)
library(shinydashboard)
library(googlesheets4)
library(ggplot2)

#read your private sheet. (get data) - remine op broswr log in gmail account
url ='https://docs.google.com/spreadsheets/d/1wrkcfG4hWHIvxlpXmOo37wHm8wXx5n_oDuIMLba6Y3Y/edit#gid=0'
my_sneaker = read_sheet(url)

#get data prepared (Need input BOND block)
my_sneaker$`Last Sale Price(New)` = as.numeric(my_sneaker$`Last Sale Price(New)`)
value = sum(my_sneaker$`Last Sale Price(New)`)
fav_model = tail(names(sort(table(my_sneaker$Model))),1)
my_sneaker_model = my_sneaker[c(3,8)]
row.names(my_sneaker_model) = NULL

##########################################UI######################################################

#Ui design section
ui <- dashboardPage(
  dashboardHeader(title = 'Sneaker Portfolio'),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Portforlio Overview',tabName = 'Dashbaord',icon = icon('dashboard')))
      # filter for future.
  ),
  dashboardBody(
    # infoboxes 
    fluidRow(
      #1st Box
      infoBox('Total Count',nrow(my_sneaker), icon = icon('list-alt'),fill = TRUE),
      #2nd Box
      infoBox('Total Value(New)', paste('$',value),icon = icon('credit-card'),color = 'yellow',fill = TRUE),
      #3rd Box
      infoBox('Favorite Model',fav_model,icon = icon('heart'),color = 'red',fill = TRUE ),
      #Pie Graph(Need Add filter option)
      box(title = 'My Brand',width = 4,solidHeader = T,status = 'primary',loadEChartsLibrary(),
          tags$div(id="Pie", style="width:100%;height:500px;"),
          deliverChart(div_id = "Pie")),
      #Bar Graph
      box(title = 'Bar',width = 8, solidHeader= T, status = 'primary',plotOutput('Bar',height = 500))
    )
  )
)

##########################################Server##################################################
server <- function(input, output) {
  # Pie renderchart (Need observe)
  output$Pie<- renderPieChart('Pie',data = my_sneaker$Brand,theme = 'macarons',radius = '80%')
  # Bar plot (x = . y= . )
  output$Bar<- renderPlot({
    ggplot(my_sneaker,aes(my_sneaker$Brand,my_sneaker$`Last Sale Price(New)`, 
                          fill = my_sneaker$Model))+geom_bar(stat = 'identity')
  })
}

#########################################RUNAPP##################################################
shinyApp(ui, server)