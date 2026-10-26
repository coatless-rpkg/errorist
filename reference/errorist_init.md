# Enable or Disable Errorist's Automatic Search

Activates or disengages the automatic look up of error or warning codes
in *R*.

## Usage

``` r
enable_errorist(
  error_search_func = getOption("errorist.warning", searcher::search_google),
  warning_search_func = getOption("errorist.warning", searcher::search_google)
)

disable_errorist()
```

## Arguments

- error_search_func, warning_search_func:

  The search function from
  [`searcher::searcher`](https://r-pkg.thecoatlessprofessor.com/searcher/reference/searcher.html)
  that should be called when an error or warning occurs. By default,
  searches are routed through [Google](https://www.google.com/).

## Details

The `enable_errorist()` is automatically called on package start to
inject handlers for warnings and errors. When the package is unloaded,
`disable_errorist()` is called to remove warnings and errors. If you
wish to disable warnings or error individually, please use either
[`disable_error_shim()`](https://r-pkg.thecoatlessprofessor.com/errorist/reference/shims.md)
or
[`disable_warning_shim()`](https://r-pkg.thecoatlessprofessor.com/errorist/reference/shims.md).

## See also

[`enable_error_shim()`](https://r-pkg.thecoatlessprofessor.com/errorist/reference/shims.md),
[`enable_warning_shim()`](https://r-pkg.thecoatlessprofessor.com/errorist/reference/shims.md),
[`disable_error_shim()`](https://r-pkg.thecoatlessprofessor.com/errorist/reference/shims.md),
[`disable_warning_shim()`](https://r-pkg.thecoatlessprofessor.com/errorist/reference/shims.md)

## Author

James Joseph Balamuta

## Examples

``` r

### Default search engine is Google

# Enable automatic search
# NB: This is done automatically on package load.
enable_errorist()
#> Warnings and errors will automatically trigger a web search.

# Some code ...

# Disable automatic search
# NB: This is done automatically on package unload via "detach()"
disable_errorist()
#> Warnings and errors are no longer automatically searched.

#### Custom search engines

# Enable automatic search with custom search engines
# NB: This is done automatically on package load.
enable_errorist(error_search_func   = searcher::search_bing,
                warning_search_func = searcher::search_duckduckgo)
#> Warnings and errors will automatically trigger a web search.

# Some code ...

# Disable automatic search
# NB: This is done automatically on package unload via "detach()"
disable_errorist()
#> Warnings and errors are no longer automatically searched.
```
