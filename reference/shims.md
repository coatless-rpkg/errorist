# Enable and Disable Warning or Error Capture

Add or remove a listener to top-level task callbacks that checks for
whether a new warning or error occurs and then triggers a search
browser.

## Usage

``` r
enable_warning_shim(
  warning_search_func = getOption("errorist.warning", searcher::search_google)
)

disable_warning_shim()

enable_error_shim(
  error_search_func = getOption("errorist.error", searcher::search_google)
)

disable_error_shim()
```

## Arguments

- error_search_func, warning_search_func:

  The search function from
  [`searcher::searcher`](https://r-pkg.thecoatlessprofessor.com/searcher/reference/searcher.html)
  that should be called when an error or warning occurs. By default,
  searches are routed through [Google](https://www.google.com/).

## Details

By default, both `enable_warning_shim()` and `enable_error_shim()`
functions are automatically triggered when the `errorist` package is
loaded.

## Error Shim

The error shim uses *R*'s default handler for errors set by specifying a
function for `error` in
[`options()`](https://rdrr.io/r/base/options.html).

## Warning Shim

For the warning shim, a top-level task callback added to the environment
via
[`base::addTaskCallback()`](https://rdrr.io/r/base/taskCallback.html).
This causes the warning handler to fire each time a new function call
occurs in *R* regardless of whether it triggers an error.

## See also

[`base::addTaskCallback()`](https://rdrr.io/r/base/taskCallback.html)

## Author

James Joseph Balamuta

## Examples

``` r


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
```
