# server ----
server <- function(input, output){
  
  trout_filtered_df <- reactive({
    
    validate(
      need(length(input$channel_type_input) > 0, 
           "Please select at least one channel type"),
      need(length(input$section_input) > 0, 
           "Please select at least one section")
    )
    
  
    
    # filter trout data ----
    trout_filtered_df <- clean_trout |>
      filter(channel_type %in% c(input$channel_type_input)) |>
      filter(section %in% c(input$section_input))
    
  })
  
  # trout scatterplot ----
  output$trout_scatterplot_output <- renderPlot({
    
    ggplot(trout_filtered_df(), aes(x = length_mm, y = weight_g,
                                  color = channel_type, shape = channel_type)) +
      geom_point(alpha = 0.7, size = 5) +
      scale_color_manual(values = c("cascade" = "#2E2585",
                                    "riffle" = "#337538",
                                    "isolated pool" = "#DCCD7D",
                                    "pool" = "#5DA899",
                                    "rapid" = "#C16A77",
                                    "step (small falls)" = "#9F4A96",
                                    "side channel" = "#94CBEC")) +
      scale_shape_manual(values = c("cascade" = 15,
                                    "riffle" = 17,
                                    "isolated pool" = 19,
                                    "pool" = 18,
                                    "rapid" = 8,
                                    "step (small falls)" = 23,
                                    "side channel" = 25)) +
      labs(x = "Trout Length (mm)",
           y = "Trout Weight (g)",
           color = "Channel Type",
           shape = "Channel Type") +
      myCustomTheme()
    
    
 
    
    
  },
  
  alt = "Alt text goes here"
  
  )
  
  # filter for island
  island_df <- reactive({
    
    validate(
      need(length(input$penguin_island_input) > 0, 
           "Please select at least one island")
    )
    
    island_df <- penguins |> 
      filter(island %in% c(input$penguin_island_input))
    
  })
  
  # render flipper length histograph ----
  output$flipper_length_histogram_output <- renderPlot({
    
    ggplot(na.omit(island_df()), aes(x = flipper_length_mm, fill = species)) +
      geom_histogram(alpha = 0.6, 
                     position = "identity", 
                     bins = input$bin_size) +
      scale_fill_manual(values = c("Adelie" = "#FEA346", "Chinstrap" = "#B251F1", "Gentoo" = "#4BA4A4")) +
      labs(x = "Flipper length (mm)", y = "Frequency",
           fill = "Penguin species") +
      myCustomTheme()
    
  },
  
  alt = "Alt text lives here for penguins"
  
  )
  
  
  
}