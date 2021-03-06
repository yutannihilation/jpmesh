% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/latlon_to_mesh.R
\name{coords_to_mesh}
\alias{coords_to_mesh}
\title{Convert from coordinate to mesh code}
\usage{
coords_to_mesh(longitude, latitude, mesh_size = "1km", ...)
}
\arguments{
\item{longitude}{longitude (double)}

\item{latitude}{latitude (double)}

\item{mesh_size}{mesh type. From 80km to 125m}

\item{...}{other parameters}
}
\value{
mesh code (default 3rd meshcode)
}
\description{
From coordinate to mesh codes.
}
\details{
http://takenaka-akio.org/etc/j_map/index.html
}
\examples{
coords_to_mesh(141.3468, 43.06462, mesh_size = "10km")
coords_to_mesh(139.6917, 35.68949, mesh_size = "250m")
coords_to_mesh(139.71475, 35.70078)
}
\author{
Akio Takenaka
}
