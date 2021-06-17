library(tidyverse)
library(tidyr)
library(dplyr)
library(ggpubr)
library(plotly)
library(RColorBrewer)
library(directlabels)
library(e1071)

# Read File
df <- read_csv("gapminder_clean.csv")
cnames <- colnames(df)
colnames(df) <- c("num", "country", "year", "agri", "co2_em", "dom_credit", "electric_pwr", "energy_use", "expt_gns", "fert_rate", "gdp_growth", "impt_gns", "industry_val", "inflation", "life_exp", "pop_density", "services", "pop", "continent", "gdpPercap")

# cFilter to year
co2_gdp <- df %>%
  filter(year == 1962, !is.na(co2_em), !is.na(gdpPercap)) %>%
  select(num, country, year, co2_em, gdpPercap)

# Checking for normality using density plot, qqplot
### Both variables don't seem normal n = 108 after filtering empty rows
ggdensity(co2_gdp$co2_em, main = "Density Plot of CO2 Emissions", xlab = "C02 Emissions")
ggqqplot(co2_gdp$co2_em, main = "Density Plot of CO2 Emissions" )

ggdensity(co2_gdp$gdpPercap, main = "Density Plot of GDP per cap", xlab = "GDP per cap")
ggqqplot(co2_gdp$gdpPercap, main = "Density Plot of GDP per cap" )

# p-value <0.0001; *** significance; not normal
shapiro.test(co2_gdp$co2_em)
shapiro.test(co2_gdp$gdpPercap)

# Checking for outliers
plot(co2_gdp$co2_em ~ co2_gdp$gdpPercap)
identify(co2_gdp$co2_em ~ co2_gdp$gdpPercap)

# Remove outlier (Kuwait - 57)
co2_gdp <- co2_gdp %>%
  filter(!num == 1250)

# Scatter plot, pearson's correlation
co2_gdp %>%
  ggplot() + 
  geom_point(shape = 21, mapping = aes(x = gdpPercap, y = co2_em), color = "black", fill = "#ffb99b", stroke = 1) + 
  labs(x="GDP per capita", y="carbon dioxide emissions (metric tons per capita)", title = "Relationship between carbon dioxide emissions and GDP per capita in 1962") +
  geom_smooth(method="lm",mapping = aes(x = gdpPercap, y = co2_em), color = "#f67e7d") + scale_x_log10() + scale_y_log10()

by1962_c02_gdp%>%
  ggplot() + 
  geom_point(shape = 21, mapping = aes(x = gdpPercap, y = co2_em), color = "black", fill = "#ffb99b", stroke = 1) + 
  labs(x="GDP per capita", y="carbon dioxide emissions (metric tons per capita)", title = "Relationship between carbon dioxide emissions and GDP per capita in 1962") +
  geom_smooth(method="lm",mapping = aes(x = gdpPercap, y = co2_em), color = "#f67e7d") + scale_x_log10() + scale_y_log10()
cor.test(co2_gdp$co2_em, co2_gdp$gdpPercap)$estimate 
print("p-value < 2.2e-16")
print("cor = 0.8063295")
# Somewhat significant positive correlation
###########



by1962_c02_gdp <- df %>%
  filter(year==1962) 

ggplotly(ggplot(by1962_c02_gdp, aes(x=co2_em, y = gdpPercap)) + geom_point(aes(size=pop, color=continent)) + scale_x_log10() + scale_y_log10() + expand_limits(y=0) +
           labs(x="GDP per capita", y="carbon dioxide emissions (metric tons per capita)", title = "Relationship between carbon dioxide emissions and GDP per capita in 1962"))

corr_1962 <- by1962_c02_gdp %>%
  summarize(corr = corr_fn(co2_em, gdpPercap))

###########
# "In what year is the correlation between 'CO2 emissions (metric tons per capita)' and gdpPercap the strongest?" 
# Graph of co2 vs GDP by each year ~ facet_wrap
by_year_c02_gdp <- df %>%
  group_by(year) %>% 
  ggplot(aes(x=co2_em, y=gdpPercap)) + 
  geom_point() +
  facet_wrap(facets = vars(year)) +
  labs(x="Carbon dioxide emissions (metric tons percapita)", y=" GDP per capita", title = "Relationship between carbon dioxide emissions and GDP per capita") +
  scale_x_log10() + scale_y_log10() + geom_smooth(method="lm")

by_year_c02_gdp

corr_fn <- function(x,y) {
  res <- cor.test(x,y)
  p_val <- res$p.value
  r <- res$estimate
}

by_year_corr <- df %>%
  group_by(year) %>%
  summarize(corr = corr_fn(co2_em, gdpPercap)) %>%
  arrange(desc(corr))

# Graph of corr by year
ggplot(by_year_corr, aes(x=year, y=corr)) + geom_point() + geom_smooth()


#######
## Filter to  1967

by1967_c02_gdp <- df %>%
  filter(year==1967)

ggplotly(ggplot(by1967_c02_gdp, aes(x= co2_em, y= gdpPercap, color = continent, size = pop, alpha = 0.05)) + 
           geom_point() + geom_jitter() +
           scale_x_log10() + scale_y_log10() +
           labs(x="Carbon dioxide emissions (metric tons percapita)", y=" GDP per capita", title = "Relationship between carbon dioxide emissions and GDP per capita") +
           expand_limits(y=0, x=0))
##########
# PARTII #
##########

# 1. Relationship between continent and 'Energy use (kg of oil equivalent per capita)'
## continent is a CV
## energy use is a continuous variable
# Represent the relationship by median due to outliers
ccont_energy <- df %>%
  filter(!is.na(continent), !is.na(energy_use)) %>%
  group_by(continent, year) 

# Boxplot to observe distribution. Right-skew, so natural logarithmic transform.
ggplot(cont_energy, aes(x=continent, y=energy_use)) + geom_boxplot() + labs(x="Continent", y="Energy use (kg of oil equivalent per capita", title = "Distribution of energy use by continent")
ggplot(cont_energy, aes(x=energy_use)) + geom_histogram() + facet_wrap(~continent)

# Median energy use
medENERGY_tab <- df %>%
  filter(!is.na(continent)) %>%
  group_by(continent) %>%
  summarize(energy = round(median(energy_use, na.rm = TRUE),3))

kable(medENERGY, col.names = c("Continent", "Median Energy Use"), align = "cc", caption = "Table 2: Energy use(kg of oil equivalent per capita) by Continent between 1962-2007")

# Non-parametric test Kruskal Wallis H (in place of ANOVA)
kruskal_test <- kruskal.test(energy ~ continent, data = medENERGY_tab)
piiqni_pval <- round(kruskal_test$p.value, 3)
piiqni_chi <- round(kruskal_test$statistic, 3)
piiqni_df <- kruskal_test$parameter


# Plot line graph
medENERGY_df <- df %>%
  filter(!is.na(continent), !is.na(energy_use)) %>%
  group_by(continent, year) %>%
  summarize(medENERGY = round(median(energy_use, na.rm = TRUE),3))

ggplotly(ggplot(medENERGY_df, aes(x=year, y=medENERGY)) + geom_line(aes(color=continent)) + labs(x="Continent", y="Fig.4: Energy use (kg of oil equivalent per capita", title = "Energy use by continent") + expand_limits (y=0) +
           scale_y_log10()) %>% layout(legend = list(orientation = "h",x = 0.1, y = -0.2))


## 

######
# What is the country (or countries) that has the highest 'Population density (people per sq. km of land area)' across all years?
# (i.e., which country has the highest average ranking in this category across each time point in the dataset?)

pop_dense <- df %>%
  group_by(country) %>%
  summarise(medianPop = median(pop_density)) %>%
  arrange(desc(medianPop)) %>%
  top_n(n=10)

# Make country an ordered factor
pop_dense$country <- factor(pop_dense$country, levels = pop_dense$country)


### Highest country is Macao SAR, China
top_pop_dense <- pop_dense[[1]][1] 

ggplotly(ggplot(pop_dense, aes(x=country, y=medianPop)) + 
           geom_col(aes(fill = as.factor(country)), show.legend = FALSE) + 
           theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
           labs(x= "Country", y= "Median Population Density", title = "Top 15 Countries with Highest Population Density") +
           scale_fill_grey()) %>% layout(showlegend = FALSE)

### Is there a significant difference between Europe and Asia with respect to
#'Imports of goods and services (% of GDP)' in the years after 1990? (stats test needed)
#'Visualize import per continent over time

eur_asia_import <- df %>%
  filter(!is.na(impt_gns)) %>%
  filter(year > 1990, continent == "Europe" | continent == "Asia") %>%
  group_by(continent, year) %>%
  summarise(medianImport = median(impt_gns)) %>%
  factor(eur_asia_import$continent)

ggplotly(ggplot(eur_asia_import, aes(x=year, y= medianImport)) + 
           geom_line(aes(color=continent)) +
           labs(x= "Year", y= "Imports of Goods and Services", title = "Imports of Goods and Services in Asia and Europe after 1990")) 

## Non-parametric test since the data is not normal, wilcox-rank sum test == no signficant difference
wilcox.test(eur_asia_import$medianImport ~ eur_asia_import$continent)$p.value

### 4 What country (or countries) has shown the greatest increase 
# in 'Life expectancy at birth, total (years)' since 1962?

### Getting list of top 10 countries with greatest increase 
greatest_lifeExp <- df %>%
  filter(year %in% c(1962, 2007)) %>%
  group_by(country) %>% 
  summarise(abs_chg =  life_exp[2] - life_exp[1]) %>%
  arrange(desc(abs_chg)) %>%
  top_n(10)

top_10_countries_lifeExp <- df %>%
  filter(country %in% greatest_lifeExp$country) %>%
  group_by(country)

ggplot(top_10_countries_lifeExp, aes(x=year, y=life_exp)) + 
  geom_line(aes(color=country)) + geom_point(alpha = 0.2, aes(color = country)) +
  labs(x= "Year", y= "Life Expectancy (Years", title = "Top 10 Countries with Greatest Increase in Life Expectancy (1962-2007)")



###############
# Visualize gdpPercap and CO2 emissions separately using boxplot and histogram to identify outliers and examine distribution. Determine measures of center and spread.
# Histogram
ggplot(by1962_c02_gdp, aes(x=co2_em)) + geom_histogram(orientation = "flipped") 
ggplot(by1962_c02_gdp, aes(x=gdpPercap)) + geom_histogram(orientation = "flipped")

# Both are right-skewed so transform
p <- by1962_c02_gdp %>% 
  mutate(log_co2 = log(co2_em, 10), log_gdp = log(gdpPercap, 10)) %>%
  ggplot()

p + geom_histogram(aes(x= log_co2)) 
p + geom_histogram(aes(x= log_gdp))

# Summary of statistics: measure center and spread (outliers so mean, sd is not used)
df %>%
  filter(year == 1962) %>%
  summarise(median(gdpPercap, na.rm = TRUE), IQR(gdpPercap, na.rm = TRUE))



