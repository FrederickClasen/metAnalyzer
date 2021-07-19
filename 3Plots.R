
# THE DATA IS FIRST MEDIAN SCALED AND THEN LOG SCALED #
scaled = scaleData(rawDat,logscale = T)

################# PLOT HEATMAP ##########################
#### SET THE COLORS FOR SOME ANNOTATIONS IF YOU WISH ####
####      THIS NEEDS SOME MANUAL INTERVENTION        ####

# Tissue
Tissue = c('orange','darkred','darkgreen','black')
names(Tissue) <- unique(sampleAnnot$Tissue)

# Feeding
Feeding <- c('red','blue','black')
names(Feeding) <- unique(sampleAnnot$Feeding)

# Class
newCols = colorRampPalette(grDevices::rainbow(length(unique(metAnnot$Class))))
Class = newCols(length(unique(metAnnot$Class)))
names(Class) = unique(metAnnot$Class)

annotColors = list(Tissue = Tissue,
                   Feeding = Feeding,
                   Class = Class)

head(scaled)
head(sampleAnnot)
head(metAnnot)

# PLOT ALL SPECIES
p = plotHeatMap(d = scaled,
                sampleAnnot = sampleAnnot,
                metAnnot = metAnnot,
                annotCol = annotColors)

# PLOT SUBSET OF SPECIES - CHANGE GROUP PARAMETER
p = plotHeatMapGroup(d = scaled,
                     sampleAnnot = sampleAnnot,
                     metAnnot = metAnnot,
                     annotCol = annotColors,
                     group = 'Ceramide')


######################################################################################################

#####################################   PLOT BARPLOTS   ##############################################

######################################################################################################



df = generateDF(rawDat,sampleAnnot,metAnnot) # MASTER DF USED FOR ALL PLOTTING
head(df)
plotClassHeatmaps(df)


