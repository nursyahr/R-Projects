# R for Data Science 

Analysis of publicly available [Gapminder](https://cran.r-project.org/web/packages/gapminder/README.html) dataset containing an excerpt of the original dataset looking at certain economic development metrics.

# Purpose 
- Part of the [R for Data Science](https://github.com/nursyahr/training-requirements/tree/main/R%20for%20Data%20Science) training requirements to undertake projects by the [Bioinformatics-Research-Network](https://github.com/Bioinformatics-Research-Network/training-requirements).

# Task 

- To analyze the `gapminder_clean.csv` dataset using `R` and the `tidyverse`. Wherever possible, your code should use `tidyverse` functions. 
- Complete the following analysis in `R` and generate an `RMarkdown` report to show the analysis and results.
- Summary visualizations are preferably interactive

1. Read in the `gapminder_clean.csv` data as a `tibble` using `read_csv`.
2. Filter the data to include only rows where `Year` is `1962` and then make a scatter plot comparing `'CO2 emissions (metric tons per capita)'` and `gdpPercap` for the filtered data. 
3. On the filtered data, calculate the pearson correlation of `'CO2 emissions (metric tons per capita)'` and `gdpPercap`. What is the Pearson R value and associated p value?
4. On the unfiltered data, answer "In what year is the correlation between `'CO2 emissions (metric tons per capita)'` and `gdpPercap` the strongest?" Filter the dataset to that year for the next step...
5. Using `plotly`, create an interactive scatter plot comparing `'CO2 emissions (metric tons per capita)'` and `gdpPercap`, where the point size is determined by `pop` (population) and the color is determined by the `continent`. You can easily convert any `ggplot` plot to a `plotly` plot using the `ggplotly()` command.

Now, without further guidance, use your `R` Data Science skills (and appropriate statistical tests) to answer the following:

1. What is the relationship between `continent` and `'Energy use (kg of oil equivalent per capita)'`? (stats test needed)
2. Is there a significant difference between Europe and Asia with respect to `'Imports of goods and services (% of GDP)'` in the years after 1990? (stats test needed)
3. What is the country (or countries) that has the highest `'Population density (people per sq. km of land area)'` across all years? (i.e., which country has the highest average ranking in this category across each time point in the dataset?)
4. What country (or countries) has shown the greatest increase in `'Life expectancy at birth, total (years)'` since 1962? 

Flowchart for choosing statistical tests:

![choosing-appropriate-statistics-test-flow-chart-1-638](https://user-images.githubusercontent.com/44813811/113900197-32035d00-9793-11eb-9e34-3908433e7bf0.jpg)

[Source](https://image.slidesharecdn.com/choosingappropriatestatisticstestflowchart-171001164040/95/choosing-appropriate-statistics-test-flow-chart-1-638.jpg?cb=1506876046)

# How to view page

- Can be viewed [here](https://rpubs.com/nursyahr/790925)
- **HTML file** can be downloaded and rendered 

