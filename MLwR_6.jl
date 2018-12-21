# --------------------------------------------------------------------------
# Julia implementation of the R code from
#
# Machine Learning with R
# Chapter 6, Forecasting Numeric Data – Regression Methods
# --------------------------------------------------------------------------

# TODO https://github.com/JuliaML/MLPlots.jl
# TODO https://github.com/GiovineItalia/Gadfly.jl/issues/286


# Setup --------------------------------------------------------------------
using CSV
using DataFrames
using FreqTables
using Gadfly
using Statistics
using StatsBase


# Get data -----------------------------------------------------------------
launch = CSV.read("./data/challenger.csv", delim = ",")


# Calculate b and a --------------------------------------------------------
b = Statistics.cov(launch[:temperature], launch[:distress_ct]) /
        Statistics.var(launch[:temperature])

a = Statistics.mean(launch[:distress_ct]) -
        b * Statistics.mean(launch[:temperature])


# Calculate correlation ----------------------------------------------------
r = Statistics.cov(launch[:temperature], launch[:distress_ct]) /
        (Statistics.std(launch[:temperature]) * Statistics.std(launch[:distress_ct]))

r = Statistics.cor(launch[:temperature], launch[:distress_ct])


# Get data -----------------------------------------------------------------
insurance = CSV.read("./data/insurance.csv", delim = ",")

describe(insurance)

plot(insurance, x = :expenses, Geom.histogram(bincount = 13))

FreqTables.freqtable(insurance, :region)

Statistics.cor(convert(Array, insurance[[:age, :bmi, :children, :expenses]]))

names(insurance)

showcols(insurance)
