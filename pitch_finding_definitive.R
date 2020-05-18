library(soundgen)
library(seewave)
#https://cran.r-project.org/web/packages/soundgen/vignettes/acoustic_analysis.html#missing-fundamental

#Function receives a list of audio files and returns a data
#frame with pitch analysis for each file
pitch_finding <- function(pasta){

  autocor = c()
  cepstral = c()
  spectral = c()
  file_name = c()

  for(i in 1:length(pasta)){
      audio = tuneR::readWave(pasta[i])
      analise = analyze(audio@left, plot = FALSE,
                  pitchMethods = c('autocor', 'cep', 'spec'),
                  samplingRate = audio@samp.rate
                  )
      autocor[[i]] = median(analise$pitchAutocor, na.rm = TRUE)
      cepstral[[i]] = median(analise$pitchCep, na.rm = TRUE)
      spectral[[i]] = median(analise$pitchSpec, na.rm = TRUE)
      file_name[[i]] = pasta[i]
  }
  
  autocor = data.frame(autocor)
  cepstral = data.frame(cepstral)
  spectral = data.frame(spectral)
  file_name = data.frame(file_name)

  data_final = dplyr::bind_rows(c(autocor, cepstral, spectral, file_name))
  #adding name to files

  
  return(data_final)
}



#Setting path
caminho = 'C:/Users/Lenovo/Desktop/world/Ciência/UFABC/Matérias/Auditory Neuroscience/audio/'
setwd(caminho)
folder = list.files(path = caminho) 

#Guardando arquivos para cada frequencia
arquivos_finais = c()
for(i in 1:length(folder)){
  setwd(paste(caminho, folder[i], sep=''))
  pasta = list.files(path = paste(caminho, folder[i], sep=''))
  arquivos_finais[[i]] = pitch_finding(pasta)
  print(paste('Terminei a pasta ', i, sep = ''))
}

#Naming each stimulus
for(k in 1:length(arquivos_finais)){
  arquivos_finais[[k]]$pitch_base = 0
  arquivos_finais[[k]]$pitch_base = folder[k]
}

data = dplyr::bind_rows(arquivos_finais)

#Setting path
caminho = 'C:/Users/Lenovo/Desktop/world/Ciência/UFABC/Matérias/Auditory Neuroscience/'
setwd(caminho)

#Saving file
write.csv(data, "pitch_finding.csv")



##############
## PLOTTING ##
##############
library(reshape2)
require(ggplot2)
library(readxl)
library(ggplot2)
library(dplyr)
library(ggpubr)
library(data.table)
library(stringr)

data = 
  fread('pitch_finding.csv')

data$V1 <- NULL


#Melting variables for visualization
data = 
  melt(data, 
       id.vars = c("file_name", "pitch_base"), 
       id.measures = c("autocor", "cepstral", "spectral"))

#Computing statistics
plot<- plyr::ddply(data, c("pitch_base", "variable"), summarise,
                   N    = length(value),
                   mean = mean(value, na.rm = TRUE),
                   sd   = sd(value, na.rm = TRUE),
                   se   = sd / sqrt(N))

g_1 <- ggplot(plot, aes(x=as.factor(variable),y=mean, group = 1)) +
  facet_wrap(~pitch_base)+
  geom_errorbar(size = 0.8, aes(ymin=mean-se, ymax=mean+se), width=.2, position=position_dodge(0.5)) +
  geom_point(shape = 21, size = 1, position=position_dodge(0.5), fill = 'black')
g_1

ggplot(data, aes(x=value, colour = variable)) +
  facet_wrap(~pitch_base)+
  geom_histogram()


ggsave(g_1, filename = "g_2.png", dpi = 1200,
       width = 6, height = 4.5, units = "in")

