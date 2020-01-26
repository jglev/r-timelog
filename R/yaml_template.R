#' Create a YAML template for time logging
#'
#' @param copyToClipboard Instead of returning the template text, copy the
#' template text directly to the clipboard.
#'
#' @return A YAML template to fill out and use with \code{\link{parse_times}}.
#' @export
#'
#' @examples
#' template_text <- yaml_template()
#' \dontrun{
#' yaml_template(copyToClipboard = TRUE)
#' }
yaml_template <- function(copyToClipboard = FALSE) {
  template_text <-
"# Abbreviations:
#   m     d     H      M       S
# months days hours minutes seconds

Total:
  deficit: no
  hours: 0
  minutes: 0

Days:
  Day 1:
    targetDuration: 7H
    times:
      # - 09:00 - 13:00  # Time range
      # - +1H20M         # Duration addition
      # - -15M           # Duration subtraction
"

  if (copyToClipboard == TRUE) {
    clipr::write_clip(
      template_text,
      return_new = TRUE,
      allow_non_interactive = TRUE
    )
    message("Template text copied to clipboard.")
  } else {
    template_text
  }
}
