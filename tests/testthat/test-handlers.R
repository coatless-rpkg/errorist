context("handlers")

test_that("Verify options are set.", {

  enable_errorist()
  test_class = class(getOption("error"))

  expect_equal(test_class, "call",
            "Check to see error handler set")

  # needle -> haystack
  expect_true("ErroristWarningHandler" %in% getTaskCallbackNames(),
               "Check to see the Warning Handler is set")


  disable_errorist()

  # expect_null(getOption("error"),
  #            "Check to see error handler is null")

  # !needle -> haystack
  expect_false("ErroristWarningHandler" %in% getTaskCallbackNames(),
                "Check to see the Warning Handler was removed from callback")

})
