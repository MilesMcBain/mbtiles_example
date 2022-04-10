library(mvtview)
library(rdeck)

# Fire up the server
serve_mvt("abs_mesh_blocks.mbtiles", port = 8765)

# Map the data
rdeck() |>
  add_mvt_layer(
    data = tile_json("http://0.0.0.0:8765/abs_mesh_blocks.json"),
    get_fill_color = scale_color_linear(
      random_attribute
    ),
    opacity = 0.6
  )

# Use the tile json
library(jsonlite)
tile_json <- fromJSON("http://0.0.0.0:8765/abs_mesh_blocks.json")

rdeck(
  initial_bounds = structure(tile_json$bounds, crs = 4326, class = "bbox")
) |>
  add_mvt_layer(
    data = tile_json("http://0.0.0.0:8765/abs_mesh_blocks.json"),
    get_fill_color = scale_color_linear(
      random_attribute
    ),
    opacity = 0.6
  )

# or use just a template URL with placeholders
rdeck() |>
  add_mvt_layer(
    data = "http://0.0.0.0:8765/abs_mesh_blocks/{z}/{x}/{y}.vector.pbf",
    get_fill_color = scale_color_linear(
      random_attribute,
      limits = c(1,7) # without the tilejson metadata we have no defaults available for the attribute range
    ),
    opacity = 0.6
  )
