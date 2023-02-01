
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

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(fxtrackerR)
## basic example code
```
