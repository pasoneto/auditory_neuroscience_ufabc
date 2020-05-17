library(soundgen)
library(seewave)
#https://cran.r-project.org/web/packages/soundgen/vignettes/acoustic_analysis.html#missing-fundamental

#Function receives a list of audio files and returns a data
#frame with pitch analysis for each file
pitch_finding <- function(pasta){

  autocor = c()
  cepstral = c()
  spectral = c()

  for(i in 1:length(pasta)){
      audio = tuneR::readWave(pasta[i])
      analise = analyze(audio@left, plot = FALSE,
                  pitchMethods = c('autocor', 'cep', 'spec'),
                  samplingRate = audio@samp.rate
                  )
      autocor[[i]] = median(analise$pitchAutocor, na.rm = TRUE)
      cepstral[[i]] = median(analise$pitchCep, na.rm = TRUE)
      spectral[[i]] = median(analise$pitchSpec, na.rm = TRUE)
  }
  autocor = data.frame(autocor)
  cepstral = data.frame(cepstral)
  spectral = data.frame(spectral)
  
  
  data_final = dplyr::bind_rows(c(autocor, cepstral, spectral))
  #adding name to files
  data_final$file_names = pasta[i]
  
  return(data_final)
}

#Setting path
caminho = 'C:/Users/Lenovo/Desktop/world/Ciência/UFABC/Matérias/Auditory Neuroscience/audio/'
setwd(caminho)
folder = list.files(path = caminho) 

#Guardando arquivos para cada frequencia
arquivos_finals = c()
for(i in 1:length(folder)){
  setwd(paste(caminho, folder[i], sep=''))
  pasta = list.files(path = paste(caminho, folder[i], sep=''))
  arquivos_finals[[i]] = pitch_finding(pasta)  
}
