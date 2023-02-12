# test for fx_conversion

# check input type of curr1
test_that("Check input type of curr1", {
  expect_error(fx_conversion(1, 'USD', 100), "The first parameter must be a string!")
})

# check input type of curr2
test_that("Check input type of curr2", {
  expect_error(fx_conversion('USD', 1, 100), "The second parameter must be a string!")
})

# check input type of amt
test_that("Check input type of amt", {
  expect_error(fx_conversion('USD', 'EUR', "X"), "The third parameter must be numeric!")
})

# check output type is numeric
test_that("Check if output is numeric", {
  expect_true(is.numeric(fx_conversion('EUR', 'USD', 100)))
})

# check if all arguments are passed
test_that("Check if all arguments are passed", {
  expect_error(fx_conversion('USD', 'EUR'), 'argument "amt" is missing, with no default')
})

# check if correct arguments are passed
test_that("Check if correct arguments are passed", {
  expect_error(fx_conversion('USD', 'EUR', a), "object 'a' not found")
})

# check for invalid ticker
test_that("Check for invalid ticker", {
  expect_error(fx_conversion('USD', 'XXX', 100), "You have entered an invalid foreign ticker! Try again.")
})

# test for fx_rate_lookup

# Curr type invalid
test_that("The first parameter (curr) should be a string.", {
  expect_error(fx_rate_lookup(123, 0.09))
})

# Target price type invalid
test_that("The second parameter (target_px) should be numeric.", {
  expect_error(fx_rate_lookup('JPYHKD', '0.09'))
})

test_that("The first parameter (curr) should be a valid ticker.", {
  expect_error(fx_rate_lookup('ABC', 0.09))
})

# Return string format check
test_that("Return string should be in the format YYYY-MM-DD.", {
  expect_match(fx_rate_lookup('JPYHKD', 0.09), '^\\d{4}-\\d{2}-\\d{2}$')
})

# Curr not found
test_that("No data found from data source. Check your ticker.", {
  expect_error(fx_rate_lookup('', 1.034))
})

# Target price not found
test_that("Target price not found. Adjust your target price.", {
  expect_error(fx_rate_lookup('EURUSD', 10.034342))
})


# test for pl_trend_viz

#test currency format
test_that("Error of currency format",{expect_error(pl_trend_viz(123,' 2020-12-31', '2021-12-31','area'))})

#test start_date type
test_that("Error of start_date format",{expect_error(pl_trend_viz('EURUSD',123, '2021-12-31','area'))})

#test end_date type
test_that("Error of end_date format",{expect_error(pl_trend_viz('EURUSD','2020-12-31', 123,'area'))})

#test start_date > end_date
test_that("Error of end_date format",{expect_error(pl_trend_viz('EURUSD','2022-12-31', '2020-12-31','area'))})

#test chart_type error
test_that("Error of end_date format",{expect_error(pl_trend_viz('EURUSD','2020-12-31', '2022-12-31','bar'))})

#test invalid ticker error
test_that("Error of end_date format",{expect_error(pl_trend_viz('ABC','2020-12-31', '2022-12-31','area'))})

#test for chart mapping
chart <- pl_trend_viz("EURUSD",'2020-12-31', '2021-12-31','line')
test_that('Plot should map Date to x-axis and map pct_change to y-axis ', {
  expect_true("date" == rlang::get_expr(chart$mapping$x))
  expect_true("pct_change" == rlang::get_expr(chart$mapping$y))})

chart <- pl_trend_viz("EURUSD",'2020-12-31', '2021-12-31','area')
test_that('Plot should map Date to x-axis and map pct_change to y-axis ', {
  expect_true("date" == rlang::get_expr(chart$mapping$x))
  expect_true("pct_change" == rlang::get_expr(chart$mapping$y))})

# test for price_trend_viz

test_that("Check input type of curr", {
  expect_error(price_trend_viz(1, '2012-02-01', '2014-12-31', 'high'), "curr needs to be of character type.")
})

test_that("Check input type of start_date", {
  expect_error(price_trend_viz('EURUSD', 2.5, '2014-12-31', 'low'), "start_date needs to be of character type.")
})

test_that("Check input type of end_date", {
  expect_error(price_trend_viz('EURUSD', '2012-02-01', 333, 'close'), "end_date needs to be of character type.")
})

test_that("Check option of plotting is from 'open', 'high', 'low' or 'close'", {
  expect_error(price_trend_viz('EURUSD', '2012-12-31', '2014-12-31', 'highest'), 
               "Your option of plotting should be from 'open', 'high', 'low' or 'close'")
})

test_that("Check end date entered is later than 2003-12-01", {
  expect_error(price_trend_viz('EURUSD', '1992-02-01', '1994-12-31', 'high'), 
               "No data exists before 2003-12-01, please try again.")
})

test_that("Check start date entered is earlier than or equal to today", {
  expect_error(price_trend_viz('EURUSD', '2023-12-31', '2024-12-31', 'high'), 
               "You entered a start date later than today, please try again.")
})

test_that("Check if the same dates are entered for start date and end date", {
  expect_error(price_trend_viz('EURUSD', '2013-12-31', '2013-12-31', 'high'), 
               "Trend of one day cannot be plotted, please enter duration longer than one day")
})

test_that("Check if output is a ggplot object", {
  expect_true(ggplot2::is.ggplot(price_trend_viz('EURUSD', '2012-02-01', '2014-12-31', 'high')))
})