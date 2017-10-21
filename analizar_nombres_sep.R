library(plyr)

removibles <- c("NULL","","-",".","0","/","\\","_")

sep <- read.csv("data/sep/PERSONAL_FEDERALIZADO_2T2012.txt",sep="|")
sep <- sep[!duplicated(sep$CURP),] 
sep$GENERO <- substring(sep[,"CURP"],11,11)
sep$ANONAC <- 1900 + as.numeric(substring(sep[,"CURP"],5,6))
sep$EDAD <- 2012 - sep$ANONAC #Ano de actualizacion del archivo de origen.

ap1 <- count(sep,"PRIMERAPELLIDO")
ap1 <- ap1[ap1$freq >= 5,]
ap1 <- ap1[!(ap1$PRIMERAPELLIDO %in% removibles),]

ap2 <- count(sep,"SEGUNDOAPELLIDO")
ap2 <- ap2[ap2$freq >= 5,]
ap2 <- ap2[!(ap2$SEGUNDOAPELLIDO %in% removibles),]

apsep <- merge(ap1,ap2,all=T,by.x = "PRIMERAPELLIDO", by.y="SEGUNDOAPELLIDO")
colnames(apsep) <- c("apellido","frec_pri","frec_seg")
apsep[is.na(apsep)] <- 0
apsep <- apsep[order(apsep$frec_pri,decreasing = T),]

muj <- count(sep[sep$GENERO=="M",],"NOMBRESTRABAJADOR")
muj <- muj[muj$freq >=5,]
muj <- muj[!(muj$NOMBRESTRABAJADOR %in% removibles),]
colnames(muj) <- c("nombre","frec")
muj$edad_media <- apply(muj,1,
                        function(x) round(
                          mean(sep$EDAD[sep$NOMBRESTRABAJADOR==x["nombre"]],na.rm=T),
                          digits = 2))
muj <- muj[order(muj$frec,decreasing = T),]


hom <- count(sep[sep$GENERO=="H",],"NOMBRESTRABAJADOR")
hom <- hom[hom$freq >=5,]
hom <- hom[!(hom$NOMBRESTRABAJADOR %in% removibles),]
colnames(hom) <- c("nombre","frec")
hom$edad_media <- apply(hom,1,
                        function(x) round(
                          mean(sep$EDAD[sep$NOMBRESTRABAJADOR==x["nombre"]],na.rm=T),
                          digits = 2))
hom <- hom[order(hom$frec,decreasing = T),]

write.csv(muj,"data/sep/mujeres.csv",row.names = F,quote = F)
write.csv(hom,"data/sep/hombres.csv",row.names = F,quote = F)
write.csv(apsep,"data/sep/apellidos.csv",row.names = F,quote = F)
