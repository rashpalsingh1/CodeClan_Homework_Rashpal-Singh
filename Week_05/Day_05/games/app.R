
library(tidyverse)
library(CodeClanData)

games <- CodeClanData::game_sales
all_publishers <- unique(games$publisher)
all_platforms <- unique(games$platform)
all_ratings<- unique(games$rating)
all_genres<- unique(games$genre)

ui <- fluidPage(
    
    titlePanel("Video Games"),
    
    
fluidRow(
        
        column(4, 
               
               selectInput("publisher",
                            "Which Publisher?",
                            choices = c(all_publishers, "All")
                            )
               
                ),
        column(4, 
               
               selectInput("platform",
                           "Which Platform?",
                           choices = c(all_platforms, "All")
                            )
               
                ),
        
        column(4, 
               
               selectInput("rating",
                           "Rating?",
                           choices = c(all_ratings, "All")
                            )
               
                ),
        
        ),

fluidRow(
    
    column(4, 
           
           selectInput("critic_score",
                       "What did the Critics Think?",
                       choices = c("90% - 100%", "80% - 90%" ,"70% - 80%", 
                                   "60% - 70%", 
                                   "50% - 60%", "less than 50%", 
                                   "I don't care what they think")
                        )
           
            ),
    column(4, 
           selectInput("user_score",
                       "What Did Users Think?",
                       choices = c("9 - 10", "8 - 9" ,"7 - 8", 
                                   "6 - 7", "5 - 6", "less than 5",
                                   "I don't care what they think")
                        )
           
        ),
    
    column(4, 
           
           selectInput("genre",
                       "Genre?",
                       choices = c(all_genres, "All")
                        )
           
            ),
    
        ),

tableOutput("game_table")

)

server <- function(input, output) {
    output$game_table <- renderTable({
            games %>%
           # if(input$rating != "All"){
           # filter(rating == input$rating) %>%
            filter(platform == input$platform) #%>%
            
           # filter(publisher == input$publisher) %>%
           
    })
    
}

shinyApp(ui, server)