# metAnalyzer
A growing collection of R scripts to analyse metabolomics abundance data. 

1. 1.Functions: Load packages and functions from the Functions script


2. 2.Load: Load three data files\
          1. rawDat: A matrix with unique metabolites as rows and unique sample IDs as columns (there should be no duplicates!). First column should be named "Label"\
          2. sampleAnnot: First column corresponding to sample IDs in rawDat. All the following columns can be experimental metadata. First column should be named "Sample"\
          3. metAnnot: First column corresponding to metabolite IDs in rawDat. All the following columns can be metabolite annotations and groupings. First column should be names "Label" \
          
3. 3.Plots: Plot raw data in heatmaps and barplots
4. Statistics - at the moment does t-tests
