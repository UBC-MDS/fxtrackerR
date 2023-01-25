#' Visualizes trend of the profit and loss of a currency pair between the selected start date and end date.
#'
#' @param curr A character vector which is the ticker of the currency pair such as 'EURUSD'
#' @param start_date A character vector that is the start date of the selected period of time
#' @param end_date A character vector that is the end date of the selected period of time
#'
#' @return A ggplot that shows the trend of the profit and loss of a currency pair over the selected period of time
#' @export
#'
#' @examples
#' pl_trend_viz('EURUSD', '2018-12-31', '2022-12-31')

pl_trend_viz <- function(curr, start_date, end_date) {
   curr_func <- paste(curr, "=X", sep="")

   data <- tidyquant::tq_get(curr_func, from = start_date, to = end_date, get = 'stock.prices')

   base_price <- data$close[1]

   data <- data |>
     dplyr::mutate(pct_change = (close-base_price)/base_price)

   title <- paste('Profit and loss trend over time for currency', curr, sep = '')

   pl_trend_plot <- data |> ggplot2::ggplot(ggplot2::aes(x = date, y = pct_change )) +
     ggplot2::geom_area() +
     ggplot2::labs(x = 'Date', y = 'Percentage Change', title = title)

   return(pl_trend_plot)
}
