library(soundgen)
library(seewave)

setwd('C:/Users/Lenovo/Desktop/world/Ciência/UFABC/Matérias/Auditory Neuroscience/audios_pavao')

#https://cran.r-project.org/web/packages/soundgen/vignettes/acoustic_analysis.html#missing-fundamental
pitch_finding <- function(pasta){

  autocor = c()
  cepstral = c()
  spectral = c()

  for(i in pasta){
      analise = analyze(i, plot = FALSE,
                  pitchMethods = c('autocor', 'cep', 'spec'),
                  nCands = 1)
      autocor[[i]] = median(analise$pitchAutocor, na.rm = TRUE)
      cepstral[[i]] = median(analise$pitchCep, na.rm = TRUE)
      spectral[[i]] = median(analise$pitchSpec, na.rm = TRUE)
  }
  autocor = data.frame(autocor)
  cepstral = data.frame(cepstral)
  spectral = data.frame(spectral)
  
  
  data_final = dplyr::bind_rows(c(autocor, cepstral, spectral))
  #adding name to files
  data_final$file_names = pasta
  
  return(data_final)
}

oi = pitch_finding(list.files())
analise = analyze(list.files()[1],
                  dynamicRange = 1000000,
                  plot = TRUE,
                  pitchMethods = c('autocor', 'cep', 'spec'),
                  nCands = 1)