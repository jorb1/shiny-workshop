# user interface ----
ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title = "About this App",
           
           "background info will go here"
           
           ), # END (Page 1) intro tabPanel
  
  # (Page 2) data viz tabPanel ----
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain tabs for data viz ----
           tabsetPanel(
             
             # trout tabPanel ----
             tabPanel(title = "Trout",
                      
                      # trout sidebarLayout ----
                      sidebarLayout(
                        
                        # trout sidebarPabel ----
                        sidebarPanel(
                          
                          # channel type pickerInput ----
                          pickerInput(inputId = "channel_type_input",
                                      label = "select channel types(s):",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"),
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)),
                          
                          # section checkboxGroupButtons ----
                          checkboxGroupButtons(inputId = "section_input",
                                               label = "Select a sampling section(s):",
                                               choices = c("Clear Cut" = "clear cut forest",
                                                           "Old Growth" = "old growth forest"),
                                               selected = c("clear cut forest",
                                                            "old growth forest"),
                                               justified = TRUE,
                                               checkIcon = list(
                                                 yes = icon("check", lib = "font-awesome"),
                                                 no = icon("xmark")
                                               ))
                          
                        ), # END trout sidebarPanel
                        
                        #trout mainPanel
                        mainPanel(
                          
                          # trout scatterplot output ----
                          plotOutput(outputId = "trout_scatterplot_output")
                        ) # END trout mainPanel
                        
                      ) # END trout sidebarLayout ----
                      
                      ), # END trout tabPanel
             
             # penguin tabPanel ----
             tabPanel(title = "Penguins",
                      
                      # penguin sidebarLayout ----
                      sidebarLayout(
                        
                        # penguin sidebarPabel ----
                        sidebarPanel(
                          # island picker input ----
                          pickerInput(inputId = "penguin_island_input",
                                      label = "Select island(s):",
                                      choices = unique(penguins$island),
                                      selected = unique(penguins$island),
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)),
                          # bin slider input
                          sliderInput(inputId = "bin_size",
                                      label = "Select histogram bin size:",
                                      min = 1,
                                      max = 100,
                                      value = 25)
                
                          
                        ), # END penguin sidebarPanel
                        
                        #penguin mainPanel
                        mainPanel(
                          
                          plotOutput(outputId = "flipper_length_histogram_output")
                          
                        ) # END penguin mainPanel
                        
                      ), # END penguin sidebarLayout ----
                      
                      
                      ) # END penguin tabPanel
             
           ) # END tabsetPanel
           
           ) # End (Page 2) data viz tabPanel
  
  
  
)  # END UI