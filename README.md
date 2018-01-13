
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis-CI Build
Status](https://travis-ci.org/coatless/errorist.svg?branch=master)](https://travis-ci.org/coatless/errorist)[![CRAN
RStudio mirror
downloads](http://cranlogs.r-pkg.org/badges/errorist)](http://www.r-pkg.org/pkg/errorist)[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/errorist)](https://cran.r-project.org/package=errorist)

# errorist

> *errorist*: one who holds to and propagates error
> 
> — [Merriam
> Webster](https://www.merriam-webster.com/dictionary/errorist)

The goal of `errorist` is to automatically search errors and warnings
the second they arise.

![](https://media.giphy.com/media/l1IBjB9qJ2jOnntOU/giphy.gif)

## Installation

The `errorist` package is only available on GitHub for the moment. You
can install the `errorist` package with:

``` r
devtools::install_github("coatless/errorist")
```

## Usage

``` r
library(errorist)
```

## Details

When the `errorist` package is loaded, two handlers are automatically
established to intercept the error and warning messages that arise
during execution of code. The intercepted messages are then directed to
pre-specified search engines on the internet using the user’s preferred
system web browser. By default, the search engine used to look up the
messages is Google.

You can specify a different search engine handler by setting default
values:

  - `errorist.warning`: Warning search engine portal. The default is
    `searcher::search_google`.
  - `errorist.error`: Error search engine portal. The default is
    `searcher::search_google`.
  - `errorist.autoload`: Automatically search errors. The default is
    `TRUE`.

If frequent use of the package occurs, consider adding the different
search handlers as an option in your `.Rprofile`:

``` r
# Add custom options
.First <- function() {
  options(
    errorist.warning = searcher::google,
    errorist.error = searcher::google
  )
}

# Load the package if in RStudio or R GUI
if (interactive()) {
  suppressMessages(require(errorist))
}
```

# Motivation

The idea for `errorist` came from a conversation among [Dirk
Eddelbuettel](http://dirk.eddelbuettel.com), [Barry
Rowlingson](http://barry.rowlingson.com), and myself musing about the
having compilers provide a link explaining what the error meant and how
to solve it. This conversation was sprouted due to the mouse overtext of
[XKCD Comic 1185: Ineffective Sorts](https://xkcd.com/1185/).

> StackSort connects to StackOverflow, searches for ‘sort a list’, and
> downloads and runs code snippets until the list is sorted.

This type of code search was implemented by:

<https://gkoberger.github.io/stacksort/>

The idea morphed from evaluating random code chunks to providing search
support for errors that occurred at runtime.

# Special Thanks

  - [Dirk Eddelbuettel](http://dirk.eddelbuettel.com) for starting the
    discussion
  - [Barry Rowlingson](http://barry.rowlingson.com) for the package name
    and remarks about functionality.
  - [Brodie Gaslam](http://www.brodieg.com/) for advise on warning
    triggers.
  - [Joshua Ulrich](http://www.joshuaulrich.com/) for advise on
    incorporating the semi-documented `last.warning` object populated
    with warning messages.

# License

GPL (\>= 2)
