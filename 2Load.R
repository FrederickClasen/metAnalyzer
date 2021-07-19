

######################################################################################################

############## READ IN RAW PEAK DATA, SAMPLE ANNOTATION AND METABOLITE ANNOTAION   ###################

######################################################################################################

rawDat = read.csv('/Volumes/lab-anastasioud/home/users/clasenf/Lipodomics/dataset2/FedFastedPBQC_Input_renamed.csv',
                  sep = ',',
                  header = T)
sampleAnnot = read.csv('/Volumes/lab-anastasioud/home/users/clasenf/Lipodomics/dataset2/sampleAnnot.csv',
                       sep=',',
                       header = T)
metAnnot = read.csv('/Volumes/lab-anastasioud/home/users/clasenf/Lipodomics/dataset2/metAnnot.csv',
                       sep=',',
                       header = T)


row.names(rawDat) = rawDat[,1]
rawDat[,1] = NULL
row.names(sampleAnnot) = sampleAnnot[,1]
sampleAnnot[,1] = NULL
row.names(metAnnot) = metAnnot[,1]
metAnnot[,1] = NULL

head(rawDat,n=2)
head(sampleAnnot,n=2)
head(metAnnot,n=2)


