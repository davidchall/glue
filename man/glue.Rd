% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/glue.R
\name{glue}
\alias{glue}
\alias{glue_data}
\title{Format and interpolate a string}
\usage{
glue_data(
  .x,
  ...,
  .sep = "",
  .envir = parent.frame(),
  .open = "{",
  .close = "}",
  .na = "NA",
  .null = character(),
  .comment = "#",
  .literal = FALSE,
  .transformer = identity_transformer,
  .trim = TRUE
)

glue(
  ...,
  .sep = "",
  .envir = parent.frame(),
  .open = "{",
  .close = "}",
  .na = "NA",
  .null = character(),
  .comment = "#",
  .literal = FALSE,
  .transformer = identity_transformer,
  .trim = TRUE
)
}
\arguments{
\item{.x}{[\code{listish}]\cr An environment, list, or data frame used to lookup values.}

\item{...}{[\code{expressions}]\cr Unnamed arguments are taken to be expression
string(s) to format. Multiple inputs are concatenated together before formatting.
Named arguments are taken to be temporary variables available for substitution.}

\item{.sep}{[\code{character(1)}: \sQuote{""}]\cr Separator used to separate elements.}

\item{.envir}{[\code{environment}: \code{parent.frame()}]\cr Environment to evaluate each expression in. Expressions are
evaluated from left to right. If \code{.x} is an environment, the expressions are
evaluated in that environment and \code{.envir} is ignored. If \code{NULL} is passed, it is equivalent to \code{\link[=emptyenv]{emptyenv()}}.}

\item{.open}{[\code{character(1)}: \sQuote{\\\{}]\cr The opening delimiter. Doubling the
full delimiter escapes it.}

\item{.close}{[\code{character(1)}: \sQuote{\\\}}]\cr The closing delimiter. Doubling the
full delimiter escapes it.}

\item{.na}{[\code{character(1)}: \sQuote{NA}]\cr Value to replace \code{NA} values
with. If \code{NULL} missing values are propagated, that is an \code{NA} result will
cause \code{NA} output. Otherwise the value is replaced by the value of \code{.na}.}

\item{.null}{[\code{character(1)}: \sQuote{character()}]\cr Value to replace
NULL values with. If \code{character()} whole output is \code{character()}. If
\code{NULL} all NULL values are dropped (as in \code{paste0()}). Otherwise the
value is replaced by the value of \code{.null}.}

\item{.comment}{[\code{character(1)}: \sQuote{#}]\cr Value to use as the comment
character.}

\item{.literal}{[\code{boolean(1)}: \sQuote{FALSE}]\cr Whether to treat single or
double quotes, backticks, and comments as regular characters (vs. as
syntactic elements), when parsing the expression string. Setting \code{.literal = TRUE} probably only makes sense in combination with a custom
\code{.transformer}, as is the case with \code{glue_col()}. Regard this argument
(especially, its name) as experimental.}

\item{.transformer}{[\verb{function]}\cr A function taking three parameters \code{code}, \code{envir} and
\code{data} used to transform the output of each block before, during, or after
evaluation. For example transformers see \code{vignette("transformers")}.}

\item{.trim}{[\code{logical(1)}: \sQuote{TRUE}]\cr Whether to trim the input
template with \code{\link[=trim]{trim()}} or not.}
}
\description{
Expressions enclosed by braces will be evaluated as R code. Long strings are
broken by line and concatenated together. Leading whitespace and blank lines
from the first and last lines are automatically trimmed.
}
\examples{
name <- "Fred"
age <- 50
anniversary <- as.Date("1991-10-12")
glue('My name is {name},',
  'my age next year is {age + 1},',
  'my anniversary is {format(anniversary, "\%A, \%B \%d, \%Y")}.')

# single braces can be inserted by doubling them
glue("My name is {name}, not {{name}}.")

# Named arguments can be used to assign temporary variables.
glue('My name is {name},',
  ' my age next year is {age + 1},',
  ' my anniversary is {format(anniversary, "\%A, \%B \%d, \%Y")}.',
  name = "Joe",
  age = 40,
  anniversary = as.Date("2001-10-12"))

# `glue()` can also be used in user defined functions
intro <- function(name, profession, country){
  glue("My name is {name}, a {profession}, from {country}")
}
intro("Shelmith", "Senior Data Analyst", "Kenya")
intro("Cate", "Data Scientist", "Kenya")

# `glue_data()` is useful in magrittr pipes
if (require(magrittr)) {

mtcars \%>\% glue_data("{rownames(.)} has {hp} hp")

# Or within dplyr pipelines
if (require(dplyr)) {

head(iris) \%>\%
  mutate(description = glue("This {Species} has a petal length of {Petal.Length}"))

}}

# Alternative delimiters can also be used if needed
one <- "1"
glue("The value of $e^{2\\\\pi i}$ is $<<one>>$.", .open = "<<", .close = ">>")
}
\seealso{
\url{https://www.python.org/dev/peps/pep-0498/} and
\url{https://www.python.org/dev/peps/pep-0257/} upon which this is based.
}
