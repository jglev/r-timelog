context("Time calculations")
library(timelog)

test_that("Single duration subtraction is accurate", {
  input_yaml <- yaml::read_yaml(text = "
    Total:
      deficit: no
      hours: 1
      minutes: 10

    Days:
      Day 1:
        times:
          - -2M
  ")

  expect_equal(
    parse_times(input_yaml),
    tibble::tribble(
      ~deficit, ~hours,        ~minutes,
      FALSE,    as.integer(1), as.integer(8)
    )
  )
})


test_that("Multiple duration arithmetic is accurate", {
  input_yaml <- yaml::read_yaml(text = "
    Total:
      deficit: no
      hours: 1
      minutes: 10

    Days:
      Day 1:
        times:
          - -2M
          - +1H1M
  ")

  expect_equal(
    parse_times(input_yaml),
    tibble::tribble(
      ~deficit, ~hours,        ~minutes,
      FALSE,    as.integer(2), as.integer(9)
    )
  )
})

test_that("Range arithmetic is accurate", {
  input_yaml <- yaml::read_yaml(text = "
    Total:
      deficit: no
      hours: 1
      minutes: 10

    Days:
      Day 1:
        times:
          - 09:00 - 13:05
          - 15:00 - 15:15
  ")

  expect_equal(
    parse_times(input_yaml),
    tibble::tribble(
      ~deficit, ~hours,        ~minutes,
      FALSE,    as.integer(5), as.integer(30)
    )
  )
})

test_that("Range plus duration arithmetic is accurate", {
  input_yaml <- yaml::read_yaml(text = "
    Total:
      deficit: no
      hours: 1
      minutes: 10

    Days:
      Day 1:
        times:
          - 09:00 - 13:05
          - 15:00 - 15:15
          - -3H
          - -1M
          - +13M
  ")

  expect_equal(
    parse_times(input_yaml),
    tibble::tribble(
      ~deficit, ~hours,        ~minutes,
      FALSE,    as.integer(2), as.integer(42)
    )
  )
})

test_that("Deficit duration subtraction is accurate", {
  input_yaml <- yaml::read_yaml(text = "
    Total:
      deficit: true
      hours: 1
      minutes: 10

    Days:
      Day 1:
        times:
          - -15M
  ")

  expect_equal(
    parse_times(input_yaml),
    tibble::tribble(
      ~deficit, ~hours,        ~minutes,
      TRUE,    as.integer(1), as.integer(25)
    )
  )
})

test_that("Deficit compareTo subtraction is accurate", {
  input_yaml <- yaml::read_yaml(text = "
    Total:
      deficit: true
      hours: 1
      minutes: 10

    Days:
      Day 1:
        targetDuration: 1H15M
        times:
          - +1H
          - +16M
  ")

  expect_equal(
    parse_times(input_yaml),
    tibble::tribble(
      ~deficit, ~hours,        ~minutes,
      TRUE,    as.integer(1), as.integer(9)
    )
  )
})

test_that("Intermediate table is as expected", {
  input_yaml <- yaml::read_yaml(text = "
    Total:
      deficit: no
      hours: 1
      minutes: 10

    Days:
      Day 1:
        times:
          - -2M
  ")

  expect_equal(
    parse_times(input_yaml, returnIntermediateTable = TRUE),
    tibble::tribble(
      ~day,    ~total_time_formatted,         ~target_duration,
      "Day 1", -lubridate::as.period("2M0S"), lubridate::as.period("0S")
    )
  )
})

test_that("Multiple days and times per day chunk accurately", {
  input_yaml <- yaml::read_yaml(text = "
    Total:
      deficit: yes
      hours: 2
      minutes: 10

    Days:
      Day 1:
        times:
          - +1H
          - +20M

      Day 2:
        targetDuration: 2H30M
        times:
          - +3H30M
  ")

  expect_equal(
    parse_times(input_yaml),
    tibble::tribble(
      ~deficit, ~hours,        ~minutes,
      FALSE,    as.integer(0), as.integer(10)
    )
  )
})
