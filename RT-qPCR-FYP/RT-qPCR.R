library(readr)
library(dplyr)
library(stringr)


##########
# SET-UP #
##########
# Load file (from working directory)
file_n <- "___"
df_qpcr <- read.delim(file_n, sep = "", header = TRUE, skip = 1)

# List Genes and Tretament conditions
primers <- as.factor(c("___"))
treatment <- as.factor(c("___"))

# State housekeeping gene (to normalize against), and treatment conditions
hkg <- "___"
scr <- "___"
KD<- "___"

#############
# SET-UP II #
#############
# Create template of used PCR plate: creating the column with names of the primers and treatments
replicates <- 3
Primers <- rep(primers, each = length(treatment) * replicates)
Treatments <- rep(treatment, times = length(primers), each = replicates)
treatment_layout <- data.frame(Primer = Primers, Treatment = Treatments) 

# Filter qpcr file for filled wells
filldf <- df_qpcr %>%
  filter(Concentration != "0") %>%
  # bind with plate template
  bind_cols(treatment_layout) %>%
  select("Primer", "Treatment", "Concentration")
  
# HKG dataframe
normal_df <- filldf %>%
  filter(Primer == hkg)

# T-test to indicate significance. Returns: *, p-val < 0.05; **, p-val <0.01, ***, p-val < 0.01.
ttest_sg <- function (x,y) {
  res<- t.test(x,y)
  res <- res$p.value
  
  if (res <0.05 & res >= 0.01) {
    print("*")
  } else if (res <0.01 & res >= 0.01) {
    print("**")
  } else if (res <0.01) {
    print("***")
  } else {
    print("N.S")
  }
}

################
# Calculations #
###############

# HKG: Calculate average by treatment 
avg_nscr <- with(subset(normal_df, Treatment == scr), mean(Concentration))
avg_nKD <- with(subset(normal_df, Treatment == KD), mean(Concentration))

# Create a df of dct, 2^-dct, average 2^-dct values
delta_df <- filldf %>%
  filter(Primer != hkg) %>%
  mutate(dct = case_when(Treatment == scr ~ Concentration - avg_nscr,
                         Treatment == KD ~ Concentration - avg_nKD)) %>%
  mutate(twodct = 2^-dct) %>%
  group_by(Primer, Treatment) %>%
  mutate(avg_twodct = mean(twodct)) 

# Save as csv -- saves as: EDITED "current file name" DATE
write_csv(delta_df, paste("EDITED", file_n, Sys.Date()))

##############
# quick look #
#############

# Create a summary of results displaying avgfold change and sig. (t-test)
summ_df <- delta_df %>%
  group_by(Primer, Treatment) %>%
  slice(1) %>%
  ungroup() %>%
  group_by(Primer) %>%
  # Creating columns for KD and scr respectively and filling them up with the average 2^-dct values
  mutate(scr = case_when(Treatment == scr ~ avg_twodct), KD = case_when(Treatment == KD ~ avg_twodct)) %>%
  # Collapsing two rows of Gene X into 1 
  mutate(scr = scr[2]) %>%
  slice(1) %>%
  summarise(Primer, scr, KD, 
            FoldChange = KD/scr,
            DifferentialExpr = if (FoldChange > 1) "Positive" else "Negative",
            Significance = ttest_sg(delta_df$twodct[1:replicates], delta_df$twodct[replicates + 1:replicates * 2]))
























