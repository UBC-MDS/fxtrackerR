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
  TRUE
}
