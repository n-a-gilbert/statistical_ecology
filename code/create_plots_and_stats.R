library(here)
library(tidyverse)
library(zoo)
library(ggpubr)
library(MetBrewer)

setwd(here::here("data"))

d <- readr::read_csv( "ecology_statistical_ecology_classification_v01.csv" )

d |> 
  dplyr::filter( omit == "keep" ) |> 
  dplyr::group_by( year ) |> 
  dplyr::add_count( ) |> 
  dplyr::mutate( n_statistical = sum( statistical == "yes")) |> 
  dplyr::summarise( prop_statistical = n_statistical / n ) |> 
  dplyr::distinct() |> 
  dplyr::filter( year < 2023 ) |> 
  dplyr::ungroup() |> 
  dplyr::mutate(prop_ra10 = zoo::rollmean(prop_statistical, 10, na.pad = TRUE)) |> 
  
  ggplot2::ggplot(aes(x = year)) +
  ggplot2::geom_line(aes(y = prop_statistical), linewidth = 0.5, color = "gray40", linetype = "dashed") +
  ggplot2::geom_line(aes(y = prop_ra10), linewidth = 1.5, color = "darkred") +
  ggplot2::theme_classic() +
  ggplot2::labs( x = "Year", 
                 y = expression( paste("Proportion of statistical ecology papers in", italic(" Ecology")))) +
  ggplot2::theme( axis.text = element_text(size = 10, color = "black"), 
                  axis.title = element_text(size = 11, color = "black"),
                  axis.line = element_line(size = 0.2, color = "gray30"), 
                  axis.ticks = element_line(size = 0.2, color = "gray30"))

setwd(here::here("figures"))
ggsave(
  "figure_01.png", 
  width = 4.75, 
  height = 4,
  units = "in", 
  dpi = 300
)  

pal <- MetBrewer::MetPalettes$Greek[[1]][1:4]

d |> 
  dplyr::filter(omit == "keep") |> 
  dplyr::filter( statistical == "yes") |> 
  dplyr::filter(citations > q75_citations) |> 
  tidyr::pivot_longer(individual:tools_practices, names_to = "category", values_to = "value") |> 
  dplyr::filter(value == 1) |> 
  dplyr::mutate( category = ifelse(category == "validation_selection", "Model validation & selection", 
                                   ifelse(category == "tools_practices", "Tools & best practices", category))) |> 
  dplyr::mutate(category = stringr::str_to_sentence(category)) |> 
  dplyr::mutate(category = factor(category, 
                                  levels = c("Individual", 
                                             "Population", 
                                             "Community",
                                             "Ecosystem", 
                                             "Spatial", 
                                             "Model validation & selection", 
                                             "Tools & best practices"))) |> 
  dplyr::mutate(time_period = ifelse(year <= 1950, "1920-1950",
                                     ifelse(year > 1950 & year <= 1975, "1951-1975", 
                                            ifelse(year > 1975 & year <= 2000, "1976-2000", 
                                                   "2001-2023")))) |> 
  dplyr::mutate(time_period = factor(time_period, 
                                     levels = c(
                                       "2001-2023",
                                       "1976-2000",
                                       "1951-1975",
                                       "1920-1950"))) |> 
  ggplot2::ggplot(aes(x = category, fill = time_period)) + 
  ggplot2::geom_bar() + 
  ggplot2::theme_classic() +
  ggplot2::scale_fill_manual("Time period",
                             values = pal) +
  ggplot2::ylab("Number of papers") +
  ggpubr::rotate_x_text(angle = 45) +
  ggplot2::theme(strip.background = element_blank(), 
                 axis.title.x = element_blank(),
                 legend.title = element_text(size = 11, color = "black"),
                 legend.position = c(0.85, 0.85),
                 axis.text = element_text(size = 10, color = "black"), 
                 axis.title = element_text(size = 11, color = "black"),
                 axis.line = element_line(size = 0.2, color = "gray30"), 
                 axis.ticks = element_line(size = 0.2, color = "gray30"),
                 legend.text = element_text(size = 10, color = "black"))

setwd(here::here("figures"))
ggsave(
  "figure_02.png", 
  width = 4.25, 
  height = 5, 
  units = "in", 
  dpi = 300
)

# Review stats

# total number of records
nrow(d)

( n_total <- d |> 
    filter(omit == "keep") |> 
    nrow() )

# number of statistcal ecology papers
( n_statistical <- d |> 
    filter(omit == "keep") |> 
    filter(statistical == "yes") |> 
    nrow() )

# proportion of statistical ecology papers
round( ( n_statistical / n_total ) * 100, 1 )

# number of statistcal ecology papers with more citations than the 75th percentile of citations for that year
( n_statistical_q75 <- d |> 
    filter(omit == "keep") |> 
    filter(statistical == "yes") |> 
    filter(citations > q75_citations) |> 
    nrow() )

( n_q75 <- d |> 
    filter(omit == "keep") |> 
    # filter(statistical == "yes") |> 
    filter(citations > q75_citations) |> 
    nrow() )

# percent of highly cited stat ecology papers of the statistical ecology papers
round( ( n_statistical_q75 / n_statistical) * 100, 1)

# percent of highly cited stat ecology papers out of the broader pop of papers with more citations than the 75th percentile
round( ( n_statistical_q75 / n_q75 ) * 100, 1)

# breakdown: percent of statistical ecology papers classified w/ each category
d |> 
  dplyr::filter(omit == "keep") |> 
  dplyr::filter( statistical == "yes") |> 
  dplyr::filter(citations > q75_citations) |> 
  tidyr::pivot_longer(individual:tools_practices, names_to = "category", values_to = "value") |> 
  dplyr::filter(value == 1) |> 
  dplyr::mutate( category = ifelse(category == "validation_selection", "Model validation & selection", 
                                   ifelse(category == "tools_practices", "Tools & best practices", category))) |> 
  dplyr::mutate(category = stringr::str_to_sentence(category)) |> 
  dplyr::mutate(category = factor(category, 
                                  levels = c("Individual", 
                                             "Population", 
                                             "Community",
                                             "Ecosystem", 
                                             "Spatial", 
                                             "Model validation & selection", 
                                             "Tools & best practices"))) |> 
  dplyr::count(category) |> 
  dplyr::mutate(prop = round( ( n / 407) * 100, 1) )
