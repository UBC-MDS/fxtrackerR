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
  expect_true(is.ggplot(price_trend_viz('EURUSD', '2012-02-01', '2014-12-31', 'high')))
})
