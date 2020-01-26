context("Template generation")
library(timelog)

test_that("YAML template is as expected", {
  template_text <- yaml_template()
  expect_equal(
    yaml::read_yaml(text = template_text),
    list(Total = list(deficit = FALSE, hours = 0L, minutes = 0L),
         Days = list(`Day 1` = list(targetDuration = "7H", times = NULL)))
  )
})

# Per https://github.com/cran/clipr/blob/master/R/utils.R#L21-L22,
# non-interactive clipr::write_clip() calls will not work on CRAN;
# thus, the test below has been disabled for now:

# test_that("YAML template copies to clipboard", {
#   yaml_template(copyToClipboard = TRUE)
#
#   expect_equal(
#     yaml::read_yaml(text = clipr::read_clip()),
#     list(Total = list(deficit = FALSE, hours = 0L, minutes = 0L),
#          Days = list(`Day 1` = list(targetDuration = "7H", times = NULL)))
#   )
# })
