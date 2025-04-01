server <- function(input, output) {
  
  # Filter lake data 
  filtered_lakes_df <- reactive({
    
    lake_data |>
      filter(Elevation >= input$elevation_slider_input[1] & Elevation <= input$elevation_slider_input[2]) |>
      filter(AvgDepth >= input$depth_slider_input[1] & AvgDepth <= input$depth_slider_input[2]) |>
      filter(AvgTemp >= input$temp_slider_input[1] & AvgTemp <= input$temp_slider_input[2])
    
  })
  
  # build leaflet map
  output$lake_map_output <- renderLeaflet({
    
    # leaflet map
    leaflet() |>
      addProviderTiles(providers$Esri.WorldImagery) |>
      setView(lng = -119.6989,
              lat = 34.4203,
              zoom =6) |>
      addMiniMap(toggleDisplay = TRUE,
                 minimized = FALSE) |>
      addMarkers(data = filtered_lakes_df(),
                 lng = filtered_lakes_df()$Longitude,
                 lat = filtered_lakes_df()$Latitude,
                 popup = paste0("Site Name: ", filtered_lakes_df()$Site, "<br>",
                                "Elevation: ", filtered_lakes_df()$Elevation, "meters above sea level", "<br>",
                                "Avg Depth: ", filtered_lakes_df()$AvgDepth, "meters", filtered_lakes_df()$AvgTemp, "°C"))
    
  })
  

}