#' Visualizes trend of the exchange rate of a currency pair between the selected start date and end date.
#'
#' @param curr A character vector which is the ticker of the currency pair such as 'EURUSD'
#' @param start_date A character vector which is the start date of the selected period of time
#' @param end_date A character vector which is the end date of the selected period of time
#' @param option A character vector which must be from 'open', high', "low', 'close'
#'
#' @return A line plot that shows the trend of the exchange rate of a currency pair over the selected period of time.
#' @export
#'
#' @examples
#' price_trend_viz('EURUSD', '2018-12-31', '2022-12-31', 'close')


price_trend_viz <- function(curr, start_date, end_date, option) {
  # Check input type of curr
  if (!is.character(curr)) {
    stop("curr needs to be of character type.")
  }
  # Check input type of start_date
  if (!is.character(start_date)) {
    stop("start_date needs to be of character type.")
  }
  # Check input type of end_date
  if (!is.character(end_date)) {
    stop("end_date needs to be of character type.")
  }
  if (!(option %in% c("open", "high", "low", "close"))) {
    stop("Your option of plotting should be from 'open', 'high', 'low' or 'close'")
  }
  # Check if the end date entered is later than 2003-12-01
  if (as.Date(end_date, format = "%Y-%m-%d") < as.Date("2003-12-01", format = "%Y-%m-%d")) {
    stop("No data exists before 2003-12-01, please try again.")
  }
  # Check if the start date entered is earlier than or equal to today
  if (as.Date(start_date, format = "%Y-%m-%d") > Sys.Date()) {
    stop("You entered a start date later than today, please try again.")
  }
  
  curr_X <- paste0(curr, "=X")
  
  data <- tidyquant::tq_get(curr_X, from = start_date, to = end_date, get = 'stock.prices')
  
  
  # Raise an exception if the data downloaded has emtpy content
  if (nrow(data) == 1) {
    stop("Trend of one day cannot be plotted, please enter duration longer than one day")
  }
  
  # Plotting 
  options(repr.plot.height = 9, repr.plot.width = 13)
  
  trend_plot <- data |>
    ggplot2::ggplot(aes(x = date, y = get(option))) +
    ggplot2::geom_line() +
    ggplot2::ggtitle(paste0("Trend of Exchange Rate (Daily ", option, ") of ", curr, " from ", start_date, " to ", end_date)) +
    ggplot2::xlab("Date") +
    ggplot2::ylab("Exchange Rate") +
    ggplot2::theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  return(trend_plot)
  
}
