context("internal")

test_that("multiplication works", {
  res <- eval_jp_boundary(135.50800000, 35.70902590)
  expect_true(res)
  res <- eval_jp_boundary(101.712359, 22.544763)
  expect_false(res)
  res <- eval_jp_boundary(153.429390000, -28.0070630000)
  expect_false(res)
  
  res <- data.frame(
    lng = c(139.73199250, 139.69170000, 135.78500278),
    lat = c(35.70902590, 35.68950000, 34.99483056)
  ) %>% purrrlyr::by_row(~ eval_jp_boundary(latitude = .x$lat, longitude = .x$lng),
                         .collate = "cols")
  expect_equal(res$.out, c(TRUE, TRUE, TRUE))
})