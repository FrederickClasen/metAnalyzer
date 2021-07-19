#############################################################

#####################     PACKAGES     ######################

#############################################################

library(pheatmap)
library(RColorBrewer)
library(viridis)
library(tidyverse)
library(reshape)
library(reshape2)
library(dplyr)
library(ggplot2)
library(ggrepel)

theme = theme(panel.background = element_blank(),
              panel.border=element_rect(fill=NA),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(),
              strip.background=element_blank(),
              axis.text.x=element_text(colour="black",size=10),
              axis.text.y=element_text(colour="black",size=10),
              axis.ticks=element_line(colour="black"),
              plot.margin=unit(c(1,1,1,1),"line"))



scaleData = function(d , logscale=TRUE){
  scaled = t(apply(d[,1:ncol(d)], 1, function(x) x/(median(x))))  # MEDIAN SCALE PER LIPID SPECIES
  scaled = data.matrix(scaled)
  scaled[sapply(scaled, is.infinite)] = NA
  scaled[scaled > quantile(scaled, 0.99,na.rm = T)] = NA          # CUT-OFF AT 99th PERCENTILE
  if (logscale == TRUE){
    scaled = log2(scaled)
  }
  scaled = scaled[rowSums(is.na(scaled)) != ncol(scaled), ]
  scaled = scaled[rowSums(is.infinite(scaled)) != ncol(scaled), ]
  scaled[sapply(scaled, is.infinite)] = 0
  scaled[sapply(scaled, is.na)] = 0
  scaled[sapply(scaled, is.nan)] = 0
  return(scaled)
}

plotHeatMap = function(d,sampleAnnot,metAnnot,annotCol){
  paletteLength = 100
  myColor = colorRampPalette(c("blue","white", "red"))(paletteLength)
  myBreaks = c(seq(min(d), 0, length.out=ceiling(paletteLength/2) + 1), 
               seq(max(d)/paletteLength, max(d), length.out=floor(paletteLength/2)))
  
  p = pheatmap(d,
               annotation_row = metAnnot,
               annotation_col = sampleAnnot,
               annotation_colors = annotCol,
               show_rownames = F,
               show_colnames = F,
               cluster_rows = T,
               cluster_cols = F,
               breaks = myBreaks,
               color = myColor)
  return(p)
}

plotHeatMapGroup = function(d,sampleAnnot,metAnnot,annotCol=list(),group){
  paletteLength = 100
  myColor = colorRampPalette(c("blue","white", "red"))(paletteLength)
  myBreaks = c(seq(min(d), 0, length.out=ceiling(paletteLength/2) + 1), 
               seq(max(d)/paletteLength, max(d), length.out=floor(paletteLength/2)))
  
  metAnnot = subset(metAnnot,metAnnot$Class == group)
  d = subset(d,rownames(d) %in% rownames(metAnnot))
  
  p = pheatmap(d,
               annotation_row = metAnnot,
               annotation_col = sampleAnnot,
               annotation_colors = annotCol,
               show_rownames = T,
               show_colnames = F,
               cluster_rows = T,
               cluster_cols = F,
               breaks = myBreaks,
               color = myColor)
  return(p)
  
}

generateDF = function(rawDat,sampleAnnot,metAnnot){
  rawDat$Label = rownames(rawDat)
  sampleAnnot$Sample = rownames(sampleAnnot)
  metAnnot$Label = rownames(metAnnot)
  
  rawDat = melt(rawDat)
  
  d = merge(rawDat, sampleAnnot, by.x=c("variable"),by.y=c("Sample"))
  d = merge(d, metAnnot, by.x=c("Label"),by.y=c("Label"))
  return(d)
}

plotClassHeatmaps = function(df){
  g = ggplot(df,aes(x=variable,y=value,fill=Class))
  g = g + geom_bar(stat='identity')
  g = g + theme
  g = g + coord_flip()
  pdf('Abundances.pdf',height=10,width=10)
  print(g)
  dev.off()
  for (i in unique(df$Class)){
    toPlot = subset(df,df$Class == i)
    g = ggplot(toPlot,aes(x=variable,y=value))
    g = g + geom_bar(stat='identity')
    g = g + theme
    g = g + coord_flip()
    g = g + ggtitle(i)
    filename = paste(i,'.pdf',sep='')
    pdf(filename,height=10,width=10)
    print(g)
    dev.off()
  }
}


