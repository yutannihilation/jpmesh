#' @title Get from mesh code to latitude and longitude
#' 
#' @description mesh centroid
#' @param meshcode numeric. mesh code
#' @param ... other parameters
#' @author Akio Takenaka
#' @details http://takenaka-akio.org/etc/j_map/index.html
#' @examples
#' mesh_to_coords(64414277)
#' @export
mesh_to_coords <- function(meshcode, ...) {
  
  code <- as.character(meshcode)
  
  # 80km mesh
  if (length(grep("^[0-9]{4}", code)) == 1) {
    code12 <- as.numeric(substring(code, 1, 2))
    code34 <- as.numeric(substring(code, 3, 4))
    lat_width  <- 2 / 3
    long_width <- 1
  }
  else {
    return(NULL)
  }
  
  # 10km mesh
  if (length(grep("^[0-9]{6}", code)) == 1) {
    code5 <- as.numeric(substring(code, 5, 5))
    code6 <- as.numeric(substring(code, 6, 6))
    lat_width  <- lat_width / 8
    long_width <- long_width / 8
  }
  
  # 1km mesh
  if (length(grep("^[0-9]{8}", code)) == 1) {
    code7 <- as.numeric(substring(code, 7, 7))
    code8 <- as.numeric(substring(code, 8, 8))
    lat_width  <- lat_width / 10
    long_width <- long_width / 10
  }
  
  # 500m
  if (length(grep("^[0-9]{9}", code)) == 1) {
    code9 <- as.numeric(substring(code, 9, 9))
  }
  # 250m
  if (length(grep("^[0-9]{10}", code)) == 1) {
    code10 <- as.numeric(substring(code, 10, 10))
  }
  # 125m
  if (length(grep("^[0-9]{11}", code)) == 1) {
    code11 <- as.numeric(substring(code, 11, 11))
  }  
  lat  <- code12 * 2 / 3
  long <- code34 + 100
  
  if (exists("code5") && exists("code6")) {
    lat  <- lat  + (code5 * 2 / 3) / 8
    long <- long +  code6 / 8
  }
  if (exists("code7") && exists("code8")) {
    lat  <- lat  + (code7 * 2 / 3) / 8 / 10
    long <- long +  code8 / 8 / 10
  }
  
  lat.c  <- lat  + lat_width  / 2
  long.c <- long + long_width / 2
  
  lat.c  <- as.numeric(sprintf("%.10f", lat.c)) 
  long.c <- as.numeric(sprintf("%.10f", long.c))
  
  res <- data.frame(lng_center = long.c,
                    lat_center  = lat.c, 
                    lng_error  = long.c - long,
                    lat_error   = lat.c - lat
                    )
  finename_centroid <- function(df, last_code) {
    
    lng_center <- lat_center <- lng_error <- lat_error <- NULL
    
    if (last_code == 1) {
      res <- df %>% 
        dplyr::mutate(lat_center = lat_center - (lat_error / 2),
                      lng_center = lng_center - (lng_error / 2))
    } else if (last_code == 2) {
      res <- df %>% 
        dplyr::mutate(lat_center = lat_center - (lat_error / 2),
                      lng_center = lng_center + (lng_error / 2))
    } else if (last_code == 3) {
      res <- df %>% 
        dplyr::mutate(lat_center = lat_center + (lat_error / 2),
                      lng_center = lng_center - (lng_error / 2))
    } else if (last_code == 4) {
      res <- df %>% 
        dplyr::mutate(lat_center = lat_center + (lat_error / 2),
                      lng_center = lng_center + (lng_error / 2)) 
    }
    
    res <- res %>% 
      dplyr::mutate(lat_error = lat_error / 2,
                    lng_error = lng_error / 2)
    
    return(res)
  }
  
  if (exists("code9")) {
    res <- finename_centroid(res, code9)
  }
  if (exists("code10")) {
    res <- finename_centroid(res, code10)
  }
  if (exists("code11")) {
    res <- finename_centroid(res, code11)
  }
  
  res <- tibble::as_tibble(res)
  
  return(res)
}
