# errorist 0.0.1

- Created shims for warning and error handling
- Automatically load and unload shims alongside package calls.
- Add coverage tests

# Special Thanks

This package exists in large part due to conversations or assistance from
the following folks:

- [Dirk Eddelbuettel](http://dirk.eddelbuettel.com) for starting the discussion
  on [XKCD Comic 1185: Ineffective Sorts](https://xkcd.com/1185/).
- [Barry Rowlingson](http://barry.rowlingson.com) for the package name and
  remarks about functionality.
- [Brodie Gaslam](http://www.brodieg.com/) for pointing out 
  [`addTaskCallback()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/taskCallback.html)
  as a way to create a warning handler.
- [Joshua Ulrich](http://www.joshuaulrich.com/) for advise on incorporating
  the semi-documented [`last.warning`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/warning.html)
  object that _R_ populates with warning messages.
  
