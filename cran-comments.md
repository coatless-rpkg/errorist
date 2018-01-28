## Test environments

- local OS X install, R 3.4.3
- ubuntu 12.04 (on travis-ci), R 3.4.3
- win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

Found the following (possibly) invalid URLs:
  URL: http://www.r-pkg.org/pkg/errorist (moved to https://www.r-pkg.org:443/pkg/errorist)
    From: inst/README.md
    Status: 404
    Message: Not Found
    
- This is a new release.
- Because this is a new release, the above URL has yet to be activated as
  the website only contains active packages on CRAN.

## Resubmit Remarks

From the initial submission, Uwe commented:

> Thanks, we see all your examples are in `\dontrun{}` and your tests are 
> rather sparse.
> Can you somehow test the core functionality of your package, too?

I have since:

1. Unlocked all examples and added an example for `enable_error_shim()`/`disable_error_shim()`
2. Improved the unit tests: 
    - Verification that a `call` has been registered in `options(error = ...)`
    - An output comparison of the function registered as the `options(error= ...)`
      handler and the default search function.
    - Checks surrounding the state of the `.errorist_env` when `errorist` is enabled.
3. Added a brief vignette to complement the extensive `README.md` file

Details of the code changes can be seen here:

<https://github.com/coatless/errorist/compare/165357dcf4c76bc4bd35b0049a47799f0c724fdb...master>

## Reverse dependencies

This is a new release, so there are no reverse dependencies.
