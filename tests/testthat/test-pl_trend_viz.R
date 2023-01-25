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
test_that("Error of end_date format",{expect_error(pl_trend_viz('ABC','2020-12-31', '2022-12-31','bar'))})

#test for chart mapping
chart <- pl_trend_viz("EURUSD",'2020-12-31', '2021-12-31','line')
test_that('Plot should map Date to x-axis and map pct_change to y-axis ', {
  expect_true("date" == rlang::get_expr(chart$mapping$x))
  expect_true("pct_change" == rlang::get_expr(chart$mapping$y))
})
