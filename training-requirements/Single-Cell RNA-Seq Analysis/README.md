# Single-Cell RNA-Seq Analysis

Suggested pre-requisites: [R Programming](https://github.com/Bioinformatics-Research-Network/training-requirements/tree/main/R%20Programming), [R for Data Science](https://github.com/Bioinformatics-Research-Network/training-requirements/tree/main/R%20for%20Data%20Science), and [RNA-Seq Analysis](https://github.com/Bioinformatics-Research-Network/training-requirements/tree/main/RNA-Seq%20Analysis)

The purpose of this challenge is to complete a full scRNA-Seq analysis, including interpreting the results in a biological context. You should pretend that you are making a report that you want to show to a biomedical collaborator who does not know any bioinformatics. You should have an introduction in which you outline the research question, a results section in which you present your results, and a discussion section in which you interpret the results. It should be written in `RMarkdown` and formatted in an aesthetic way that is easy to follow. Here is an example of an aesthetic, easy-to-follow RMarkdown notebook: [here](https://static-html-pages.s3-us-west-2.amazonaws.com/merck-project/RloopCorrelationSummary.html).

## The Challenge

### Select a dataset

To complete this challenge you must **select an scRNA-Seq dataset** from any source. Pick one that you have a particular biological interest in. For example, I would pick [this dataset](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE118389) from GEO if my goal was to uncover rare cell subtypes in triple-negative breast tumors (you are not permitted to pick that one though).

The easiest way to find a dataset is to use the 10X genomics data repository [here](https://www.10xgenomics.com/resources/datasets?query=&page=1&configure%5Bfacets%5D%5B0%5D=chemistryVersionAndThroughput&configure%5Bfacets%5D%5B1%5D=pipeline.version&configure%5BhitsPerPage%5D=500). You can also easily find data from curated sources like [panglaoDB](https://panglaodb.se/). Finally, you can find datasets from [GEO](https://www.ncbi.nlm.nih.gov/gds) but be careful to make sure that the data is in the format you expect.

### Outline the background and analysis goals

Write a relatively brief (4-6 sentence typically) introduction to the analysis in which you address the following:

1. What the gap in biological knowledge you are interested in addressing?
2. Why is the dataset you chose suitable to address this knowledge gap?
3. What specific questions do you plan to answer from the analysis?

### Perform the analysis

In general any analysis should include the following:

1. Data wrangling
2. Data quality control and filtering
3. Data normalization and scaling
4. Data integration (if determined necessary)
5. Dimensionality reduction
6. Embedding
7. Clustering
8. Cell type identification 
9. Cluster marker analysis and pathway analysis

Any work which you perform in addition to the above is up to you -- the only requirement is that your analysis addresses your biological questions. Additionally, there's no penalty for finding negative results (results that do not support your hypothesis), and you are always encouraged to report these transparently.

### Discuss the results

Finally, write a brief discussion of the results of your analysis. You should reference your specific findings and discuss how they address your original biological questions. You should emphasize how your analysis results address knowledge gaps and also describe any gaps which remain along with future research directions to pursue in address them.

## Resources and advice

Single-cell RNA-Seq is conceptually challenging and there is still much debate on how to approach analyzing this kind of data. Here are a few resources that will help you learn how to perform scRNA-Seq analysis:

1. BIG Bioinformatics scRNA-Seq workshop (Spring 2021): [here](https://www.bigbioinformatics.org/intro-to-scrnaseq)
2. Harvard bioinformatics training on scRNA-Seq: [here](https://hbctraining.github.io/scRNA-seq_online/schedule/links-to-lessons.html)
3. Bioconductor scRNA-Seq guide: [here](http://bioconductor.org/books/release/OSCA/)
4. Broad Institute scRNA-Seq video lessons: [here](https://liulab-dfci.github.io/bioinfo-combio/scrna1.html)

Finally, scRNA-Seq is more computationally intensive than many other bioinformatics approaches. If you find that your personal computer is not sufficient for performing the analysis, consider downsampling your data (randomly select a subset of cells to analyze). This will allow you to achieve a more shallow analysis without overwhelming your computer's resources. If this isn't sufficient, let Henry know and he can assist you.  



