# errorist 0.0.1.1000

_in progress_

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
- [Joshua Ulrich](http://www.joshuaulrich.com/) for advise on incorporating
  the semi-documented [`last.warning`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/warning.html)
  object that _R_ populates with warning messages.
  
