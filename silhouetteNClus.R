#.............................................................................
#
# silhouetteNClus.R
# 
# Fecha de Creaci�n : 19-04-2018
# 
# Autor:              Carolina Gamboa. 
# 
# Descripci�n:  Esta funci�n calcula el indice de silueta para determinadas 
#               cantidades de grupos, y determina la cantidad de grupos optima
#               usando el estad�stico de silueta. 
# 
# Entradas: Tres par�metros. K : Cantidad m�xima de grupos a analizar
#                            dis : Matriz de distancias. 
#                            method: M�todo Jer�rquico "single", "average"  
# 
# Output: Dos par�metros. K : Cantidad de grupos
#                         list : valor del �ndice de silueta para cada k 
# 
#.............................................................................

#library

library(cluster)

silhouetteNClus <- function(K, dis, method){
  
  if(class(dis)!="dist") dis <- as.dist(dis)
  
  silIndex <- data.frame(k = 1, silIndex = 0)
  
  if(method == "complete"){
 
      
      hclust.dist <- hclust(dis, method="complete")
      Cl.hclust <- cutree(hclust.dist, 2:K)
      
      for (jj in 2:(K)) {
      coef <- silhouette(Cl.hclust[, jj-1], dis)
      jjSilIndex <- mean(coef[, "sil_width"])
      silIndex <- rbind(silIndex, data.frame(k = jj, silIndex = jjSilIndex))
      
    }
    
    
  }

  if(method == "average"){
    
    
    hclust.dist <- hclust(dis, method="average")
    Cl.hclust <- cutree(hclust.dist, 2:K)
    
    for (jj in 2:(K)) {
      coef <- silhouette(Cl.hclust[, jj-1], dis)
      jjSilIndex <- mean(coef[, "sil_width"])
      silIndex <- rbind(silIndex, data.frame(k = jj, silIndex = jjSilIndex))
      
    }
    
    
  }
  
  
  
  if(method == "single"){
    
    
    hclust.dist <- hclust(dis, method="single")
    Cl.hclust <- cutree(hclust.dist, 2:K)
    
    for (jj in 2:(K)) {
      coef <- silhouette(Cl.hclust[, jj-1], dis)
      jjSilIndex <- mean(coef[, "sil_width"])
      silIndex <- rbind(silIndex, data.frame(k = jj, silIndex = jjSilIndex))
      
    }
    
    
  }
  maxPos <- which(silIndex[, "silIndex"]==max(silIndex[, "silIndex"]))
  cluster <- list(K = silIndex[maxPos, "k"], coef = silIndex)
  return(cluster$K)

  }
  