context("Onload Environment")

env_errorist_names = c("captured_last_search_warning",
                       "op")

test_that("Environment Creation Test", {
  enable_errorist()

  expect_is(.errorist_env, "environment",
            "Verify that the errorist environment was setup")

  expect_true(all(env_errorist_names %in% ls(.errorist_env)),
              "Check that the environment is appropriately established.")

  disable_errorist()
})
