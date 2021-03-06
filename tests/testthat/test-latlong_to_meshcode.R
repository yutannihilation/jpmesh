context("convert to mesh code")

# Order 1 -----------------------------------------------------------------
test_that("from latitude and longitude to mesh 1", {
  
  res <- coords_to_mesh(133, 34, mesh_size = "80km")
  
  expect_true(is.character(res))
  expect_equal(4, nchar(res))
  expect_equal(res, "5133")
  
  expect_warning(coords_to_mesh(141.3468, 35.68949))
  expect_warning(coords_to_mesh(153.429390000, -28.0070630000))
  expect_warning(coords_to_mesh(103.844763000, 1.2819450000))
  expect_warning(coords_to_mesh(100.479448544, 7.0091360000))
  
})

# Order 2 -----------------------------------------------------------------
test_that("from latitude and longitude to mesh 2", {
  
  res <- coords_to_mesh(133.875, 34.583333, mesh_size = "10km")
  
  expect_true(is.character(res))
  expect_equal(6, nchar(res))
  expect_equal(res, "513367")
})

# Order 3 -----------------------------------------------------------------
test_that("from latitude and longitude to mesh 2", {
  
  res <- coords_to_mesh(133.9125, 34.65, mesh_size = "1km")
  
  expect_true(is.character(res))
  expect_equal(8, nchar(res))
  expect_equal(res, "51337782")
  expect_equal(res, coords_to_mesh(133.9125, 34.65))
})

# Separete Mesh: harf -----------------------------------------------------------------
test_that("Separete to harf mesh", {
  
  res <- coords_to_mesh(139.301255, 35.442788, mesh_size = "500m")
  
  expect_true(is.character(res))
  expect_equal(9, nchar(res))
  expect_equal(res, "533912341")
  
})

# Separete Mesh: quarter -----------------------------------------------------------------
test_that("Separete to quarter mesh", {

  res <- coords_to_mesh(133.9125, 34.65, mesh_size = "250m")  
  
  expect_true(is.character(res))
  expect_equal(10, nchar(res))
  expect_equal(res, "5133778222")
  
  res <- coords_to_mesh(139.310654, 35.442893, mesh_size = "250m")
  expect_equal(res, "5339123422")
  
  res <- coords_to_mesh(139.301706, 35.448767, mesh_size = "250m")
  expect_equal(res, "5339123433")
  
  res <- coords_to_mesh(139.311340, 35.449011, mesh_size = "250m")
  expect_equal(res, "5339123444")
})
