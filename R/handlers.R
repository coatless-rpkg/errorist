#' Enable or Disable Errorist's Automatic Search
#'
#' Activates or disengages the automatic look up of error or warning codes in
#' _R_.
#'
#' @inheritParams enable_error_shim
#'
#' @details
#' The `enable_errorist()` is automatically called on package start to
#' inject handlers for warnings and errors. When the package is unloaded,
#' `disable_errorist()` is called to remove warnings and errors. If you
#' wish to disable warnings or error individually, please use either
#' [disable_error_shim()] or [disable_warning_shim()].
#'
#' @seealso [enable_error_shim()], [enable_warning_shim()],
#'          [disable_error_shim()], [disable_warning_shim()]
#' @author James Joseph Balamuta
#' @examples
#'
#' ### Default search engine is Google
#'
#' # Enable automatic search
#' # NB: This is done automatically on package load.
#' enable_errorist()
#'
#' # Some code ...
#'
#' # Disable automatic search
#' # NB: This is done automatically on package unload via "detach()"
#' disable_errorist()
#'
#' #### Custom search engines
#'
#' # Enable automatic search with custom search engines
#' # NB: This is done automatically on package load.
#' enable_errorist(error_search_func   = searcher::search_bing,
#'                 warning_search_func = searcher::search_duckduckgo)
#'
#' # Some code ...
#'
#' # Disable automatic search
#' # NB: This is done automatically on package unload via "detach()"
#' disable_errorist()
#' @export
#' @rdname errorist_init
enable_errorist = function(error_search_func = getOption("errorist.warning", searcher::search_google),
                           warning_search_func = getOption("errorist.warning", searcher::search_google)) {
  packageStartupMessage("Warnings and errors will automatically trigger a web search.")
  enable_error_shim(error_search_func)
  enable_warning_shim(warning_search_func)
}

#' @export
#' @rdname errorist_init
disable_errorist = function() {
  packageStartupMessage("Warnings and errors are no longer automatically searched.")
  disable_error_shim()
  disable_warning_shim()
}


warning_msg_format = function(x = warnings()) {
  # Retrieve the error message
  warning_messages = names(x)
  # Retrieve the call location for the error
  # E.g. fun(1, 2) : this is a warning
  warning_calls = as.character(x)

  # Set default sep value
  sep_val = ": "

  # Build a traditional warning string
  combined_warning = paste(warning_calls, warning_messages, sep = sep_val)

  # Format string by removing instances of NULL
  missing_call = which(warning_calls == "NULL")
  if (length(missing_call)) {
    # Compute number of characters to drop
    call_drop = nchar(paste0("NULL", sep_val)) + 1L

    # Remove NULL in string.
    combined_warning[missing_call] =
      substr(combined_warning[missing_call],
             call_drop,
             nchar(combined_warning[missing_call]))
  }

  # Determine number of warnings
  n = length(combined_warning)

  # Ensure a localized warning is given.
  translated_warning_prefix = ngettext(n, "Warning message:\n", "Warning messages:\n")

  # Return fixed warning string
  paste0(translated_warning_prefix, combined_warning)
}


warning_handler = function(search_func =
                             getOption("errorist.warning", searcher::search_google)) {
  # Write trigger as a closure with the required four inputs
  #
  # @param expression the S-language expression for the top-level task.
  # @param value      the result of evaluating the expression for top-level task.
  # @param status     a logical value indicating whether the evaluation was
  #                   successful. In the future, this may be used to indicate
  #                   whether the handler has been called in the case of an
  #                   error or not.
  # @param visible    whether the output from the task was printed or not.
  # @details
  # see https://developer.r-project.org/TaskHandlers.pdf
  function(expr, value, ok, visible) {
    # Determines if a warning was triggered
    last_warning_value = warnings()

    if (!is.null(last_warning_value)) {
      warning_contents = warning_msg_format(last_warning_value)
    } else {
      warning_contents = NA
    }

    # Trigger search with added protections since this caller is repeatedly
    # called regardless if a new warning is detected.
    if (!is.na(warning_contents) &&
        (is.na(.errorist_env$captured_last_search_warning) ||
        .errorist_env$captured_last_search_warning != warning_contents)
        ) {
      for (warning_msg in warning_contents) {
        search_func(warning_msg)
      }
    }

    # Update last warning
    .errorist_env$captured_last_search_warning = warning_contents
    invisible(TRUE)
  }
}

#' Enable and Disable Warning or Error Capture
#'
#' Add or remove a listener to top-level task callbacks that checks for
#' whether a new warning or error occurs and then triggers a search browser.
#'
#' @param error_search_func,warning_search_func
#'        The search function from [`searcher`] that should be called when
#'        an error or warning occurs. By default, searches are routed through
#'        [Google](https://www.google.com/).
#'
#' @details
#' By default, both [enable_warning_shim()] and [enable_error_shim()] functions
#' are automatically triggered when the `errorist` package is loaded.
#'
#' @section Error Shim:
#'
#' The error shim uses _R_'s default handler for errors set by specifying
#' a function for `error` in `options()`.
#'
#' @section Warning Shim:
#'
#' For the warning shim, a top-level task callback added to the environment
#' via [base::addTaskCallback()]. This causes the warning handler to fire
#' each time a new function call occurs in _R_ regardless of whether it
#' triggers an error.
#'
#' @seealso [base::addTaskCallback()]
#' @author James Joseph Balamuta
#' @examples
#'
#'
#' # Default setup
#' enable_warning_shim()
#'
#' # Some code ...
#'
#' # Remove the shim
#' disable_warning_shim()
#'
#' # Specify a search function
#' enable_warning_shim(warning_search_func = searcher::search_google)
#'
#' # Some code ...
#'
#' # Remove the shim
#' disable_warning_shim()
#' @rdname shims
#' @export
enable_warning_shim = function(warning_search_func =
                                 getOption("errorist.warning", searcher::search_google)) {
  disable_warning_shim()

  # No warning messages yet (we hope!)
  .errorist_env$captured_last_search_warning = NA

  # Restore to default setting to ensure `last.warning` is created.
  warn_level = getOption("warn", 0)
  if (warn_level != 0) {
    options("warn" = 0)
  }

  # Automatically call the warning_handler after each R function is run
  handler = addTaskCallback(warning_handler(warning_search_func),
                            name = "ErroristWarningHandler")

}

#' @rdname shims
#' @export
disable_warning_shim = function() {
  # Reset the warning
  .errorist_env$captured_last_search_warning = NULL

  # Restore original warning level
  options("warn" = .errorist_env$warn_level)

  # Remove handler
  removed_handler = removeTaskCallback("ErroristWarningHandler")
}

#' @importFrom searcher search_google
#' @rdname shims
#' @export
#' @examples
#'
#' # Enable only the error shim
#' enable_error_shim()
#'
#' # Some code ...
#'
#' # Remove the shim
#' disable_error_shim()
#'
#' # Specify a search function
#' enable_error_shim(error_search_func = searcher::search_google)
#'
#' # Some code ...
#'
#' # Remove the shim
#' disable_error_shim()
enable_error_shim = function(error_search_func =
                               getOption("errorist.error", searcher::search_google)) {
  # Remove the shim if it exists...
  disable_error_shim()

  # Errorist
  op.errorist = list(error = error_search_func)

  # Set options
  options(op.errorist)
}

#' @rdname shims
#' @export
disable_error_shim = function() {

  # Restore options
  if ("error" %in% names(.errorist_env$op)) {
    options(.errorist_env$op)
  } else {
    # Ensure error is nullified.
    options(error = NULL)
  }

}
