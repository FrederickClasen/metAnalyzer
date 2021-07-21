

######################################################################################################

############## READ IN RAW PEAK DATA, SAMPLE ANNOTATION AND METABOLITE ANNOTAION   ###################

######################################################################################################

rawDat = read.csv('data/rawDat.csv',
                  sep = ',',
                  header = T)
sampleAnnot = read.csv('data/sampleAnnot.csv',
                       sep=',',
                       header = T)
metAnnot = read.csv('data/metAnnot.csv',
                    sep=',',
                    header = T)


row.names(rawDat) = rawDat[,1]
rawDat[,1] = NULL

row.names(sampleAnnot) = sampleAnnot[,1]
sampleAnnot[,1] = NULL

row.names(metAnnot) = metAnnot[,1]
metAnnot[,1] = NULL
# the first annotation column is renamed to as it is used later for plotting
names(metAnnot)[names(metAnnot) == colnames(metAnnot[1])] <- 'Class'

head(rawDat,n=2)
head(sampleAnnot,n=2)
head(metAnnot,n=2)


