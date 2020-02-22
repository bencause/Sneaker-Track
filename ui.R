# Some package need. <3
library(shinydashboard)
library(googlesheets4)


#read your private sheet. (get data) - remine op broswr?
url ='https://docs.google.com/spreadsheets/d/1wrkcfG4hWHIvxlpXmOo37wHm8wXx5n_oDuIMLba6Y3Y/edit#gid=0'
my_sneaker = read_sheet(url)


## ui.R ##
ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody()
)


