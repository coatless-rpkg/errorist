# Workflow while using the errorist package

## Overview

The `errorist` package is designed to provide support for newcomers to
*R* who are learning how to write code. Philosophically, `errorist`
takes the position of being as invisible as possible. To achieve the
invisibility, on package load, handlers to receive error and warning
message are automatically created and applied. These handlers propogate
the messages raised by *R* into the
[`searcher`](https://CRAN.R-project.org/package=searcher) package, which
automatically searches the contents on [Google](https://www.google.com/)
by default.

### Usage

To use `errorist` in a causal manner, please type:

``` r

library(errorist)
#> Warnings and errors will automatically trigger a web search.
```

To remove the `errorist` handlers, please either call the
[`disable_errorist()`](https://r-pkg.thecoatlessprofessor.com/errorist/reference/errorist_init.md)
function or detach the package.

``` r

detach("package:errorist", unload = TRUE)
#> Warnings and errors are no longer automatically searched.
```

### Error Search

During development, many issues can arise. With `errorist` enabled, each
error is automatically searched. For instance, if we typed a function
that wasn’t defined, we’d get:

``` r

f()
```

    #> Error in f() : could not find function "f"
    #> Searching query in a web browser ...

### Warning Search

Outside of errors, the second most common issue is receiving
**warnings**. Warnings only indicate a recoverable issue has occurred
during a function run. As a result, there can be many warnings that
build up during an estimation routine. If `errorist` is enabled, each
unique warning will automatically be searched within its own tab in the
browser. As an example, consider the following function:

``` r

many_warnings = function() {
  warning("First warning")
  warning("Second warning")
  warning("Random warning")
  warning("Random warning")
}
```

When run, the `many_warnings()` function will issue exactly **four
warnings**. However, only three of these warnings are unique. Thus,
there will be exactly **three** searches performed after the function
finishes its execution. As a result, the output will be like:

    #> Warning messages:
    #> 1: In many_warnings() : First warning
    #> 2: In many_warnings() : Second warning
    #> 3: In many_warnings() : Random warning
    #> Searching query in a web browser ... 
    #> Searching query in a web browser ... 
    #> Searching query in a web browser ...
