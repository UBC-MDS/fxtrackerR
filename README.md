[![codecov](https://codecov.io/gh/UBC-MDS/fxtrackerR/branch/main/graph/badge.svg?token=6FEOBcM32c)](https://codecov.io/gh/UBC-MDS/fxtrackerR)
[![test-coverage](https://github.com/UBC-MDS/fxtrackerR/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/UBC-MDS/fxtrackerR/actions/workflows/test-coverage.yaml)
[![R-CMD-check](https://github.com/UBC-MDS/fxtrackerR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/UBC-MDS/fxtrackerR/actions/workflows/R-CMD-check.yaml)
[![License:MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fxtrackerR

<!-- badges: start -->
<!-- badges: end -->

This is a R package created as a group project for DSCI_524
Collaborative Software Development of UBC Master of Data Science (MDS)
program 2022-2023. Based on the foreign exchange data in Yahoo Finance,
this package allows user to perform currency conversion based on the
latest available exchange rate, lookup a target exchange rate from
historical data as well plotting exchange rate history and profit/loss
percentage history by specifying a currency pair (and other input
parameters).

## Functions

- `fx_conversion` Convert the input amount of currency 1 to currency 2
  based on the latest available exchange rate.
- `fx_rate_lookup` Lookup for the date of the first occurence (in
  reverse chronological order) on which the input target rate of a
  currency pair is within the day’s high/low.
- `price_trend_viz` Plot the historical exchange rate of the input
  currency pair for a specific period of time.
- `pl_trend_viz` Plot the historical profit/loss percentage of the input
  currency pair for a specific period of time.

There is a R package
[czechrates](https://cran.r-project.org/web/packages/czechrates/index.html)
relevant to foreign exchange. The package only provides foreign exchange
rates from Koruna to other currencies. It does not support global
currency exchange rates and visualizations like `fxtrackerR` does.

## Installation

You can install the development version of fxtrackerR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/fxtrackerR")
```

## Usage and Example

If the package is installed successfully, users need the following nine input parameters:

`curr`, `target_px`, `start_date`, `end_date`, `chart_type`, `option`, `curr1`, `curr2`, `amt`. The output of the functions will be in forms of a POSIXlt, a numeric and a plot based on the "ggplot" package.

`fxtracker` can be used to convert a specific amount of money from one currency to another, find the the first date on which the target price falling between day high and day low, visualize the trend of the exchange rate of a currency pair and the trend of the profit and loss of a currency pair between the selected start date and end date.

``` r
library(fxtrackerR)
## basic example code
```
### To convert a specific amount of money from current currency (curr1) to desired currency (curr2):

    fx_conversion('EUR', 'USD', 150.75)

163.68

### To look up the first date (reverse chronological order) on which the target price falling between day high and day low based on the availability of data:

    fx_rate_lookup('EURUSD', 1.072)

'2023-01-10'

### To visualize the trend of the exchange rate of a currency pair between the selected start date and end date:

    price_trend_viz('EURUSD', '2018-12-01', '2022-12-01', 'high')
    
    
### To visualize the trend of the profit and loss of a currency pair between the selected start date and end date:

**If a line chart is specified in the input:**

    pl_trend_viz("EURUSD", "2020-01-01", "2022-01-01", 'line')  
    

**If an area chart is specified in the input:**

    pl_trend_viz("EURUSD", "2020-01-01", "2022-01-01", 'area')
