#Read in Segments and preprocess the data. 
path <- "/Users/LALS07/Desktop"

Segment <- read.table(paste(path,"Scar_segments.txt",sep="/"),header=T)
Segment <- Segment[,c(1,2,3,4,6,7,8,9)]
lists <- split(Segment,Segment$Sample_id)

# Process the CNV files
filenames <- names(lists)
for (i in 1:length(lists)){
  outname <- paste(paste(path,"CNVs/",sep="/"), filenames[i], ".txt", sep= "")
  write.table(lists[[i]], outname, col.names= T, row.names= F, quote= F,sep="\t")
}

# Source the R Script functions. 
source(paste(path,"Source_code_for_Facets_analysis.R",sep="/"))


Scores <- list()
for(i in 1:length(filenames)){
score <- calculate_scar_score(paste(paste(path,"CNVs/",sep="/"), filenames[i], ".txt", sep= ""),reference = "grch37", seqz=FALSE)             
Scores[[i]] <-score
}

names(Scores) <- filenames
Scores.df <- as.data.frame(do.call("rbind",Scores))
row.names(Scores.df) <-names(Scores) 

write.table(Scores.df,paste(path,"Scores_HRD.txt",sep="/"),sep= "\t", col.names=T, row.names=T, quote=F)




