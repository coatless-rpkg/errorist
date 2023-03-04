# errorist 0.1.1

## Fixes

- Switched insertion shiv `message()` to `packageStartupMessage()`
  ([#11](https://github.com/r-assist/errorist/pull/11))

- Removed `LazyData: true` from `DESCRIPTION`
  ([#11](https://github.com/r-assist/errorist/pull/11))

## Deployment

- Updated to the latest version of `r-lib` GitHub actions. 
  ([#11](https://github.com/r-assist/errorist/pull/11))

# errorist 0.1.0

## Feature

- When multiple warnings occur, each unique warning is searched separately
  instead of searching only the latest value. ([#9](https://github.com/r-assist/errorist/pull/9),
  closing ([#7](https://github.com/r-assist/errorist/issues/7)))

## Fixes

- Warning messages now have their locale specific prefix. 
  ([#9](https://github.com/r-assist/errorist/pull/9))

- Ensured the `last.warning` object was created by setting `options('warn' = 0)`,
  which is the default value. Upon unload, the warning level is restored to
  the old value. ([#8](https://github.com/r-assist/errorist/pull/8))
  
- Fixed a spurious URL in README/NEWS.md
  
## Documentation

- Improved the package vignette by providing examples of how the handler pick
  up errors and warnings. ([#10](https://github.com/r-assist/errorist/pull/10))


# errorist 0.0.3

## Fixes

- Address an erroneous unit test that was comparing functions within namespaces
  instead of environments.

# errorist 0.0.2

## Fixes

- Imported the `search_google` function from `searcher` to satisfy `R CMD check`.

## Test Infrastructure

- Enable the use of two cores to speed up Travis-CI builds.

# errorist 0.0.1

## Features

- Created shims for warning and error handling
- Automatically load and unload shims alongside package calls.
- Added coverage tests to verify the presence of the handlers and for 
  checking the contents of the error handler.

## Special Thanks

This package exists in large part due to conversations or assistance from
the following folks:

- [Dirk Eddelbuettel](http://dirk.eddelbuettel.com) for starting the discussion
  on [XKCD Comic 1185: Ineffective Sorts](https://xkcd.com/1185/).
- [Barry Rowlingson](http://barry.rowlingson.com) for the package name and
  remarks about functionality.
- [Brodie Gaslam](http://www.brodieg.com/) for pointing out 
  [`addTaskCallback()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/taskCallback.html)
  as a way to create a warning handler and for a brief discussion on "call"
  objects.
- [Joshua Ulrich](https://github.com/joshuaulrich/) for advise on incorporating
  the semi-documented [`last.warning`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/warning.html)
  object that _R_ populates with warning messages.
  
