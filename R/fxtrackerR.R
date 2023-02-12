#' Converts a specific amount of money from current currency (curr1) to desired currency (curr2)
#'
#' @param curr1 A character vector which is the ticker of the current currency such as 'EUR'
#' @param curr2 A character vector which is the ticker of the desired currency to convert to such as 'USD'
#' @param amt A double vector that is the amount of money to be converted
#'
#' @return A double vector. Amount of value converted from currency 1 to currency 2
#' @export
#'
#' @examples
#' fx_conversion('EUR', 'USD', 150.75)

fx_conversion <- function(curr1, curr2, amt) {
    # check input type of curr1
  if (!is.character(curr1)) {
    stop('The first parameter must be a string!')
  }
    # check input type of curr2
  if (!is.character(curr2)) {
    stop('The second parameter must be a string!')
  }

  # check input type of amt
  if (!is.numeric(amt)) {
    stop('The third parameter must be numeric!')
  }
    
    curr_X <- paste0(curr1, curr2, "=X")
    
    tryCatch( { 
        conversion_rate <- tidyquant::tq_get(curr_X, get = 'stock.prices') |> 
        dplyr::slice_tail() |> 
        dplyr::select(close) |> 
        dplyr::pull() 
        
    }, warning = function(e) {stop("You have entered an invalid foreign ticker! Try again.")})
    
    new_amount = amt*conversion_rate
    
    return(new_amount)
}

#' Return the most recent date on which the target price happened. i.e. the target price was between day high and day low of the day.
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
  if (!is.character(curr))  {
    stop("Currency should be string")}

  curr_func <- paste(curr, "=X", sep="")

  #check start_date variable is type string
  if(!is.character(start_date)) {
    stop("Start date should be string")}

  #check end_date variable is type string
  if(!is.character(end_date)) {
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
    ggplot2::ggplot(ggplot2::aes(x = date, y = get(option))) +
    ggplot2::geom_line() +
    ggplot2::ggtitle(paste0("Trend of Exchange Rate (Daily ", option, ") of ", curr, " from ", start_date, " to ", end_date)) +
    ggplot2::xlab("Date") +
    ggplot2::ylab("Exchange Rate") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))
  
  return(trend_plot)
  
}
