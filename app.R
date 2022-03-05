library(bslib)
library(shiny)
# install.packages(rsconnect)
library(rsconnect)
source("my_ui.R")
source("my_server.R")

# Fill in the blanks
# Publish your Shiny App to the web

shinyApp(ui = ui, server = server)
