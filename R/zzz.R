# Package Environment
.errorist_env = new.env()
.errorist_env$warn_level = 0

# Retrieve settings on load
setup_errorist_environment = function() {
  .errorist_env$op = options()
  .errorist_env$warn_level =  getOption("warn", 0)
}

.onAttach = function(libname, pkgname) {

  autoload_config = getOption("errorist.autoload", TRUE)
  setup_errorist_environment()

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
