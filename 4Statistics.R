

# generate df to be passed to t-test
df = generateDF(rawDat,sampleAnnot,metAnnot)

# generate df with pvalues and logfoldchanges
out_df = speciesTtest(df,sampleAnnot)

#write to file
write.csv(out_df,'ttest.csv')


