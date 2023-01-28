#' Visualizes trend of the profit and loss of a currency pair between the selected start date and end date.
#'
#' @param curr A character vector which is the ticker of the currency pair such as 'EURUSD'
#' @param start_date A character vector that is the start date of the selected period of time
#' @param end_date A character vector that is the end date of the selected period of time
#' @param chart_type A character vector that is the type of the chart
#'
#' @return A ggplot that shows the trend of the profit and loss of a currency pair over the selected period of time
#' @export
#'
#' @examples
#' pl_trend_viz('EURUSD', '2018-12-31', '2022-12-31', 'line')

pl_trend_viz <- function(curr, start_date, end_date, chart_type) {

  #check curr variable is type string
  if(class(curr) != 'character') {
    stop("Currency should be string")}

  curr_func <- paste(curr, "=X", sep="")

  #check start_date variable is type string
  if(class(start_date) != 'character') {
    stop("Start date should be string")}

  #check end_date variable is type string
  if(class(end_date) != 'character') {
    stop("End date should be string")}

  # Assert end date is later than start date
  if (as.Date(end_date, format = '%Y-%m-%d') < as.Date(start_date, format = '%Y-%m-%d')) {
    stop("Invalid values: start_date should be smaller or equal to end_date")
  }

  viz_list <- c('area', 'line')

  #check if chart_type is valid
  if ((chart_type %in% viz_list) == FALSE){
    stop("Chart type is invalid")
  }

  #check if it is a valid ticker
  tryCatch( { data <- tidyquant::tq_get(curr_func, from = start_date, to = end_date, get = 'stock.prices') }
            , warning = function(e) {stop("You have entered an invalid foreign ticker! Try again.")})

  base_price <- data$close[1]

  data <- data |>
    dplyr::mutate(pct_change = (close-base_price)/base_price)

  title <- paste('Profit and loss trend over time for currency ', curr, sep = '')

  if(chart_type == 'area'){
    pl_trend_plot <- data |> ggplot2::ggplot(ggplot2::aes(x = date, y = pct_change )) +
      ggplot2::geom_area() +
      ggplot2::labs(x = 'Date', y = 'Percentage Change', title = title)
  } else {
    pl_trend_plot <- data |> ggplot2::ggplot(ggplot2::aes(x = date, y = pct_change )) +
      ggplot2::geom_line() +
      ggplot2::labs(x = 'Date', y = 'Percentage Change', title = title)
  }

   return(pl_trend_plot)
}
