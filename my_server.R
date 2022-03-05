library(ggplot2)
library(plotly)
library(dplyr)

climate_change <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

server <- function(input, output) {
  
  output$intro <- renderText({
    # max value of variable across all countries
    max <- climate_change %>% filter(gas_co2_per_capita == max(gas_co2_per_capita, na.rm = TRUE))  %>% pull(gas_co2_per_capita)
    # which country has the min value of gas co2 emissions in most recent year
    min_country <- climate_change %>% filter(gas_co2_per_capita == min(gas_co2_per_capita, na.rm = TRUE)) %>% filter(year == max(year)) %>% pull(country)
    # which country has the max value of gas co2 emissions in most recent year
    max_country <- climate_change %>% filter(gas_co2_per_capita == max(gas_co2_per_capita, na.rm = TRUE)) %>% filter(year == max(year)) %>% pull(country)
    # what is the year that had the most gas co2 emissions
    max_year <- climate_change %>% filter(gas_co2_per_capita == max(gas_co2_per_capita, na.rm = TRUE)) %>% pull(year)
    # min value of variable in 2020
    min <- climate_change %>% filter(gas_co2_per_capita == min(gas_co2_per_capita, na.rm = T)) %>% filter(year == 2020) %>% pull(gas_co2_per_capita)
    
    intro <- paste('What is the max value of gas co2 emissions per capita across all countries?', 
                   max,'.', 'Which country has the minimum amount of gas co2 emissions per capita in 2020?', min_country,'.', 'Which country that had the most gas co2 emissions per capita in 2020?', max_country,'.',  'What is the year that had the most gas co2 emissions per capita?', max_year,'.',
                   'What is the minimum value of gas co2 emissions per capita in 2020?', min,'.')
   
    return(intro)
   
  })

  
  output$climatePlot <- renderPlotly({
    
    # Allow user to filter by country
    climate_change <- climate_change %>% filter(country %in% input$user_category)
    
    # Make a line graph of gas co2 emissions per capita by each year and color would be country
    co2_plot <- ggplot(data = climate_change)+
      geom_line(mapping = aes(x = year, y = gas_co2_per_capita, color = country))+
      ggtitle("Gas Co2 Emissions per Capita by Each Country")
    
    # Make interactive plot
    co2_plotly <- ggplotly(co2_plot)
    
    return(co2_plotly)
  })
}
 