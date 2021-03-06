context("Correct boundary")

# 80km mesh ----------------------------------------------------------------
test_that("Calculate correct value for mesh_code (80km)", {
  
  res <- mesh_to_coords(5133)
  
  expect_true(is.data.frame(res))
  expect_equal(names(res), c("lng_center", "lat_center", "lng_error", "lat_error"))
  
  expect_equal(res$lat_center - res$lat_error, 34)
  expect_equal(res$lng_center - res$lng_error, 133)
})

# 10km mesh ----------------------------------------------------------------
test_that("Calculate correct value for mesh_code (10km)", {
  
  res <- mesh_to_coords(513377)
  
  expect_that(res, is_a("data.frame"))
  expect_equal(names(res), c("lng_center", "lat_center", "lng_error", "lat_error"))
  
  expect_equal(res$lat_center - res$lat_error, 34.583333)
  expect_equal(res$lng_center - res$lng_error, 133.875)
})

# 1km mesh ----------------------------------------------------------------
test_that("Calculate correct value for mesh_code (1km)", {
  
  res <- mesh_to_coords(51337783)
  
  expect_that(res, is_a("data.frame"))
  expect_equal(names(res), c("lng_center", "lat_center", "lng_error", "lat_error"))
  
  expect_equal(res$lat_center - res$lat_error, 34.65)
  expect_equal(res$lng_center - res$lng_error, 133.9125)
})

# Misc. --------------------------------------------------
test_that("Combine other function", {
  res <- coords_to_mesh(135.527193, 34.688732) %>% 
    mesh_to_coords()
  
  expect_that(res, is_a("data.frame"))
  expect_equal(names(res), c("lng_center", "lat_center", "lng_error", "lat_error"))
  
  expect_equal(res$lat_center - res$lat_error, 34.68333, tolerance = .002)
  expect_equal(res$lng_center - res$lng_error, 135.525)

})

test_that("fine mesh", {
  res <- fine_separate("36233799") %>% 
    tibble::as_data_frame() %>% 
    purrr::set_names(c("meshcode")) %>% 
    dplyr::mutate(out = purrr::pmap(., mesh_to_coords)) %>% 
    tidyr::unnest()
  expect_equal(res$meshcode, c("362337991", "362337992", "362337993", "362337994"))
  expect_equivalent(res$lng_center, c(123.990625, 123.996875, 123.990625, 123.996875))
  expect_equivalent(res$lat_center, c(24.3270833334, 24.3270833334, 24.3312500001, 24.3312500001))
  expect_equivalent(res$lng_error[1], 0.003125)
})

