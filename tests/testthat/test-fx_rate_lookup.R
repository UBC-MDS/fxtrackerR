test_that("The first parameter (curr) should be a string.", {
  expect_error(fx_rate_lookup(123, 0.09))
})

test_that("The second parameter (target_px) should be numeric.", {
  expect_error(fx_rate_lookup('JPYHKD', '0.09'))
})

test_that("The first parameter (curr) should be a valid ticker.", {
  expect_error(fx_rate_lookup('ABC', 0.09))
})

test_that("Return string should be in the format YYYY-MM-DD.", {
  expect_match(fx_rate_lookup('JPYHKD', 0.09), '^\\d{4}-\\d{2}-\\d{2}$')
})
