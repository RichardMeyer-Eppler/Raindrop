library(httr2)

base_url <- "https://api.raindrop.io/rest/v1/"
endpoint <- "collections"

req <- httr2::request(
  base_url
) |>
  httr2::req_url_path_append(
    endpoint
  ) |>
  httr2::req_headers(
    "Authorization" = glue::glue(
      "Bearer {Sys.getenv('RAINDROP_CLIENT_TOKEN')}"
    )
  )

resp <- req |>
  httr2::req_perform() |>
  httr2::resp_body_json()

resp_wrangled <- resp |>
  purrr::list_flatten() |>
  purrr::discard_at(
    "result"
  ) |>
  tibble::tibble() |>
  tidyr::unnest_wider(
    col = 1
  )
