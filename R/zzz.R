.onAttach = function(libname, pkgname) {

  autoload_config = getOption("errorist.autoload", TRUE)

  if(!is.logical(autoload_config)) {

    packageStartupMessage("Incorrect configuration for `errorist.autoload` detected.",
                          "Please supply either: TRUE or FALSE.")

  } else if (autoload_config == TRUE) {
    packageStartupMessage("Warnings and errors will automatically trigger a web search.")

    enable_error_shim()
    enable_warning_shim()
  }

  invisible()
}

.onUnload = function(libpath) {
  message("Warnings and errors are no longer automatically searched.")

  disable_error_shim()
  disable_warning_shim()

  invisible()
}
