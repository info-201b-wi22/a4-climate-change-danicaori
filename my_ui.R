library(ggplot2)
library(plotly)
library(bslib)

climate_change <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")



intro_tab <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(primary = "#9AC791", 
  fontscale = NULL, bootswatch = "cerulean")),
  p("This data was collected by Hannah Ritchie, Max Roser, Edouard Mathieu, Bobbie Macdonald and Pablo Rosado. They collected the data set from the Global Carbon Project, the CAIT Climate Data Explorer, BP Statistical Review of World Energy, United Nations, World Bank, Maddison Project Database, Gapminder, etc. This data was collected in order to showcase how climate change is impacting our Earth. The possible limitations regarding this data set is that we cannot possibly have a whole count of our entire population in our data. There is only so many people that we can count yearly and it is impossible to have a true count of our entire world population. There is also an estimation on how much resources we use per year according to each of our countries."),
  textOutput(outputId = 'intro')
)


plot_sidebar <- sidebarPanel(
  selectInput(
    inputId = "user_category",
    label = "Select Country",
    # Fill in the correct code here
    choices = unique(climate_change$country), # climate_change$country
    selected = "United States",
    multiple = TRUE),
  sliderInput(
    inputId = 'slider',
    label = h3("Select Year"),
    min = 1900,
    max = 2020,
    value = c(1920, 2020)
              
  )
)

plot_main <- mainPanel(
  plotlyOutput(outputId = 'climatePlot'),
  p("This graph was included in order to show the amount of gas co2 emissions per capita that each country had. The patterns that had emerged were that the United States was one of the lines that had the most range compared to other countries like Albania.")
)

plot_tab <- tabPanel(
  "Plot",
  sidebarLayout(
    plot_sidebar,
    plot_main
  )
  
)
envision <- tabPanel(
  "Envision Card",
  p("Envision your system in use by a single stakeholder. Now imagine 100 such individuals interacting with the system. Then 1,000 individuals. Then 100,00. What new interactions might emerge from widespread use? Find three synergistic benefits of widespread use and three potential breakdowns."),
  br(),
  p("Three benefits of widespread use is that people are able to educate themselves about climate change, people are able to educate others about climate change and countries become more aware of their own gas co2 emissions. One of the 3 potential breakdowns is that when other people code on a single data set, this can cause issues within the data set. Another potential breakdown is that it is possible to not cover the entire population within a country since there are people being born each day. Another potential breakdown is that with 100,000 individuals working on this system, there is bound to be a bug within the system.")
  
)
  

ui <- navbarPage(
  title = "Climate Change",
  intro_tab,
  plot_tab,
  envision
)
