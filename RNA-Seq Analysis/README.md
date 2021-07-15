# RNA-Seq Analysis
Analyzed a publicly available RNA-seq dataset from the [recount2](https://jhubiostatistics.shinyapps.io/recount/) database to investigate changes in gene expression.

# Purpose
- Part of the [RNA-Seq Analysis](https://github.com/nursyahr/training-requirements/tree/main/RNA-Seq%20Analysis) training requirements to undertake projects by the [Bioinformatics-Research-Network](https://github.com/Bioinformatics-Research-Network/training-requirements).

# Task

- To complete a full RNA-Seq analysis, including interpretation of the results in a biological context. 
- Present in the form ofa report that you want to show to a biomedical collaborator who does not know bioinformatics. - Include the following sections: 
  - Introduction in which you outline the research question
  - Results section in which you present your results
  - Discussion section in which you interpret the results
- Dataset must have at least 3 replicates in two or more biological conditions of interest

1. Use DESeq2 for the differential gene expression analysis. Find the DEGs between your conditions of interest. 
2. Create a PCA plot colored by the condition of interest
3. Create a Volcano Plot
4. Create a heatmap showing the top 20 over- and under-expressed DEGs
5. Do GSEA on the results and plot the top 5 pathways
6. Present the results in notebook form (either Rmarkdown or jupyter notebook)
7. What do the results tell you about your conditions of interest? What is the biological meaning of these results? What future experiments could you perform? (These questions don't have an exact right answer, just about thinking through the meaning of the results). 

All code and `.html` should be commited using `git` and pushed to your fork of the training repo on GitHub. Once you are done, let Henry know and he will check your `.html` report. 

# How to view the page

- Can be viewed [here](https://rpubs.com/nursyahr/rna-seq-analysis)
- **HTML file** can be downloaded and rendered 

