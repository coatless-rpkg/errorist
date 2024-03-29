% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/handlers.R
\name{enable_warning_shim}
\alias{enable_warning_shim}
\alias{disable_warning_shim}
\alias{enable_error_shim}
\alias{disable_error_shim}
\title{Enable and Disable Warning or Error Capture}
\usage{
enable_warning_shim(
  warning_search_func = getOption("errorist.warning", searcher::search_google)
)

disable_warning_shim()

enable_error_shim(
  error_search_func = getOption("errorist.error", searcher::search_google)
)

disable_error_shim()
}
\arguments{
\item{error_search_func, warning_search_func}{The search function from \code{\link{searcher}} that should be called when
an error or warning occurs. By default, searches are routed through
\href{https://www.google.com/}{Google}.}
}
\description{
Add or remove a listener to top-level task callbacks that checks for
whether a new warning or error occurs and then triggers a search browser.
}
\details{
By default, both \code{\link[=enable_warning_shim]{enable_warning_shim()}} and \code{\link[=enable_error_shim]{enable_error_shim()}} functions
are automatically triggered when the \code{errorist} package is loaded.
}
\section{Error Shim}{


The error shim uses \emph{R}'s default handler for errors set by specifying
a function for \code{error} in \code{options()}.
}

\section{Warning Shim}{


For the warning shim, a top-level task callback added to the environment
via \code{\link[base:taskCallback]{base::addTaskCallback()}}. This causes the warning handler to fire
each time a new function call occurs in \emph{R} regardless of whether it
triggers an error.
}

\examples{


# Default setup
enable_warning_shim()

# Some code ...

# Remove the shim
disable_warning_shim()

# Specify a search function
enable_warning_shim(warning_search_func = searcher::search_google)

# Some code ...

# Remove the shim
disable_warning_shim()

# Enable only the error shim
enable_error_shim()

# Some code ...

# Remove the shim
disable_error_shim()

# Specify a search function
enable_error_shim(error_search_func = searcher::search_google)

# Some code ...

# Remove the shim
disable_error_shim()
}
\seealso{
\code{\link[base:taskCallback]{base::addTaskCallback()}}
}
\author{
James Joseph Balamuta
}
