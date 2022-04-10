library(sf)
library(curl)
library(dplyr)
library(magrittr)

mesh_block_url <-
  "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/MB_2021_AUST_SHP_GDA2020.zip"
download_folder <- file.path(tempdir(), "mesh_blocks")
dir.create(download_folder)
download_path <- file.path(download_folder, "mb.zip")

curl_download(
  mesh_block_url,
  download_path
)

unzip(
  download_path,
  exdir = download_folder
)

mb_shapes <- read_sf(download_folder)

mb_shapes %>%
  st_transform(4326) %>% # standard lon lat 
  mutate(
    random_attribute = sample(
      1:7,
      nrow(cur_data()),
      replace = TRUE
    )
  ) %>%
  select(
    geometry,
    random_attribute,
    MB_CODE21,
    MB_CAT21,
    SA2_NAME21
  )
  st_write(
    "mb_shapes.geojson"
  )

unlink(download_folder, recursive = TRUE)

