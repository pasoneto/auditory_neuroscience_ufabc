require(seewave)
require(phonTools)
require(astsa)
require(scales)

#Pitch fingding algorithm

#function receives a number of points from an album sample
#If this number of points corresponds to a period of a soundwave,
#The value returned is equal to the frequency in Hertz

p_alg<- function(periodo_em_pontos, sr){
  periodo_em_segundos = periodo_em_pontos/sr
  hz = 1/periodo_em_segundos
  return(hz)
}

p_alg(23, 22050) #Para um periodo de 44.1 pontos, eu tenho 500Hz

#Defining sinewave:
frequency = 500
number_of_periods = 100
t = sinusoid(frequency, 
             amps = 10, 
             dur = 2*number_of_periods, 
             fs = 22050, 
             sum = FALSE,
             show = FALSE)

lista_correlacoes <- ccf(t$wave1, t$wave1, plot = FALSE)[["acf"]]
lista_correlacoes <- lista_correlacoes[12:length(lista_correlacoes)]
period <- which(lista_correlacoes == max(lista_correlacoes))
oi = data.frame(delay = crosscor[["lag"]],
           correlation = crosscor[["acf"]])


