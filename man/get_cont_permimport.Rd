% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/8.1.f.metrics.R
\name{get_cont_permimport}
\alias{get_cont_permimport}
\title{Compute variable contribution and permutation importance}
\usage{
get_cont_permimport(mcmp, sp.nm)
}
\arguments{
\item{mcmp}{Species "i" of a object returned by "proj_mdl_b", containing a list of
calibrated models and model projections for each species}

\item{sp.nm}{Species name. Used to name the output folder}
}
\value{
List of arrays containing variable contribution and importance for each species
}
\description{
Compute variable contribution and importance for each model
}
\examples{
\dontrun{
get_cont_permimport(mcmp = mxnt.mdls.preds)
}
}
\seealso{
\code{\link{get_cont_permimport_b}}, \code{\link{get_tsa}}, \code{\link{get_fpa}},
\code{\link{get_tsa_b}}, \code{\link{get_fpa_b}}, \code{\link[dismo]{maxent}}
}
