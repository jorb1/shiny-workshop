# dashboard header ----
header <- dashboardHeader(
  
  # title ----
  title = "MarineBioMaps",
  titleWidth = 400
  
)

# dashboard sidebar ----
sidebar <- dashboardSidebar(
  
  # sidebarMenu ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("star")),
    menuItem(text = "Interactive Map", tabName = "dashboard", icon = icon("water"))
    
  ) # END sidebarMenu
  
) # END dashboardSidebar

# dashboard body ----
body <- dashboardBody(
  
  # set theme
  use_theme("dashboard-fresh-theme.css"),
  
  # add font styling
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom-font.css")
  ),
  
  # tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(tabName = "welcome",
            
            # left-hand column ----
            column(width = 9,
                   
                   # background info box ----
                   box(width = NULL,
                       
                       title = tagList(icon("water"),
                                       strong("Evaluating the protection of diverse\nand representative coastal and marine habitats within California’s Marine Protected Area (MPA) network")),
                       includeMarkdown("text/intro.md"),
                       tags$img(src = "bigkelplei.jpg",
                                alt = "An overhead aerial image of kelp taken near Santa Cruz Island by photographer Leilanie Rubinstein",
                                style = "max-width: 100%;"),
                       tags$h6("Images Source:", 
                               tags$a(href = "https://leirubinstein.github.io/nature-photography.html", 
                                      "Leilanie Rubinstein"),
                               style = "text-align: center;")
                       
                   ) # END backgroudn info box 
                   
            ), # END left-hand column
            
            # right-hand column ----
            column(width = 3,
                   
                   # first fluidRow ----
                   fluidRow(
                     
                     # citation box ----
                     box(width = NULL,
                         
                         title = tagList(icon("table"),
                                         strong("Data Source")),
                         includeMarkdown("text/citation.md")
                         
                     ) # END citation box
                     
                   ), # END first fluidRow 
                   
                   # second fluidRow ----
                   fluidRow(
                     
                     # disclaimer box ----
                     box(width = NULL,
                         
                         title = tagList(icon("triangle-exclamation"),
                                         tags$strong("Disclaimer")),
                         includeMarkdown("text/disclaimer.md")
                         
                     ) # END disclaimer box 
                     
                   ) # END second fluidRow
                   
            ) # END right-hand column
            
    ), # END welcome tabItem
    
    # dashboard tabItem ----
    tabItem(tabName = "dashboard",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4,
                  
                  title = tags$strong("Adjust lake parameter ranges:"),
                  
                  # sliderInputs ----
                  sliderInput(inputId = "elevation_slider_input",
                              label = "Elevation (meters above SL)",
                              min = min(lake_data$Elevation),
                              max = max(lake_data$Elevation),
                              value = c(min(lake_data$Elevation),
                                        max(lake_data$Elevation))),
                  
                  sliderInput(inputId = "depth_slider_input",
                              label = "Average depth (meters):",
                              min = min(lake_data$AvgDepth),
                              max = max(lake_data$AvgDepth),
                              value = c(min(lake_data$AvgDepth),
                                        max(lake_data$AvgDepth))),
                  
                  sliderInput(inputId = "temp_slider_input",
                              label = "Average lake bed temperature (°C):",
                              min = min(lake_data$AvgTemp),
                              max = max(lake_data$AvgTemp),
                              value = c(min(lake_data$AvgTemp),
                                        max(lake_data$AvgTemp)))
                  
                  
                  
              ), # END input box
              
              # leaflet box ----
              box(width = 8,
                  
                  title = tags$strong("Monitored lakes within Fish Creek Watershed"),
                  
                  # leaflet output ----
                  leafletOutput(outputId = "lake_map_output") |> 
                    withSpinner(type = 1, color = "blue")
                  
              ) # END leaflet box
              
            ) # END fluidRow
            
    ) # END dashboard tabItem
    
  ) # END tabItems 
  
) # END dashboardBody

# combine all into dashboardPage ----
dashboardPage(header, sidebar, body)