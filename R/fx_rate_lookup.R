#' Return the first date (reverse chronological order) on which the target price falling between day high and day low based on the availability of data.
#'
#' @param curr A character vector with one element which is the ticker of the currency pair such as 'EURUSD'
#' @param target_px A double vector with one element that is the target price for the lookup
#'
#' @return A character vector with one element. The closest date on which the target price falling between day high and day low in YYYY-MM-DD.
#' @export
#'
#' @examples
#' fx_rate_lookup('EURUSD', 1.072)

fx_rate_lookup <- function(curr, target_px)  {
  # check input type of curr
  if (! is.character(curr)) {
    stop('The first parameter must be a string!')
  }

  # check input type of target_px
  if (!is.numeric(target_px)) {
    stop('The second parameter must be numeric!')
  }

  curr <- paste0(curr, "=X")

  tryCatch(
    {
    df <- tidyquant::tq_get(curr, get = 'stock.prices', from = '1900-01-01') |>
      dplyr::filter(high >= target_px) |>
      dplyr::filter(low <= target_px) |>
      dplyr::arrange(dplyr::desc(date)) |>
      dplyr::filter(dplyr::row_number() == 1) |>
      dplyr::select(date) |>
      dplyr::pull() |>
      format(format = '%Y-%m-%d')
    },
    error=function(e) {
      stop('No data found from data source. Check your ticker.')
    },
    warning=function(w) {
      stop('No data found from data source. Check your ticker.')
    }
  )

  if (length(df) == 0) {
    stop('Target price not found. Adjust your target price.')
  }
  else
    df
}
