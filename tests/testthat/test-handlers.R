context("handlers")

test_that("Verify options are set.", {

  enable_errorist()

  # Retrieve errorist helper
  test_call = getOption("error")

  # Retrieve the default call-type
  default_call = getOption("errorist.warning",
                           searcher::search_google)

  expect_true(is.call(test_call),
              "Verify that extracted error handler is of type call")

  # needle -> haystack
  expect_true("ErroristWarningHandler" %in% getTaskCallbackNames(),
               "Check to see the Warning Handler is set")


  disable_errorist()

  # Retrieve error handler after errorist's bindings are removed.
  restored_error_call = getOption("error")

  # Determine if in RStudio
  is_rstudio = function() Sys.getenv("RSTUDIO") == "1"

  # This check attempts to figure out the state of the handlers by:
  # 1. checking if an error option wasn't set.
  # 2. checking if we are in rstudio and a call is still present.
  # The latter is important as RStudio setups custom handler for traceback()
  # et cetera routines.
  expect_true(is.null(restored_error_call) || (is_rstudio() && is.call(restored_error_call)),
              "Check to see error handler is null or a call (RStudio may inject)")

  # !needle -> haystack
  expect_false("ErroristWarningHandler" %in% getTaskCallbackNames(),
                "Check to see the Warning Handler was removed from callback")

})


test_that("Check Output from Functions", {

  enable_errorist()

  # Retrieve errorist helper
  test_error_call = getOption("error")
  options_default_function = getOption("errorist.warning", searcher::search_google)

  # Retrieve the function
  test_error_function = test_error_call[[1]]

  # Retrieve function name space
  # See: https://stackoverflow.com/a/6433626/1345455
  get_function_namespace = function(func) { getNamespaceName(environment(func)) }

  expect_true(is.function(options_default_function),
              "Verify the default error handler is a function.")

  expect_true(get_function_namespace(test_error_function) ==
                get_function_namespace(options_default_function) ,
              "Verify that test function call matches the default function's environment")

  expect_equal(test_error_function("toad"), options_default_function("toad"),
               "Check that the search query term is the same.")

  ## TO DO: Make more robust
  # For right now, this should satisfy the sanity check of default functions.
  # However, as Hadley pointed out, "the first element of a call is not always
  # a symbol." As an example, he gave: `quote(f()()())`, which gives another call.

  # Read: https://adv-r.hadley.nz/expressions.html#abstract-syntax-trees

  ## Cannot really interface with the addTaskCallback()... This should
  ## always return a "TRUE" with a warning check enabled.

  disable_errorist()

})

