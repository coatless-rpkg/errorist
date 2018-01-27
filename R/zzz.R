.onAttach = function(libname, pkgname) {

  autoload_config = getOption("errorist.autoload", TRUE)

  if(!is.logical(autoload_config)) {

    packageStartupMessage("Incorrect configuration for `errorist.autoload` detected.",
                          "Please supply either: TRUE or FALSE.")

  } else if (autoload_config == TRUE) {
    enable_errorist()
  }

  invisible()
}

.onUnload = function(libpath) {
  disable_errorist()

  invisible()
}
