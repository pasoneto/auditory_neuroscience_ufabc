require(seewave)
require(phonTools)

#Set the parameters (frequency in Hertz)
frequency1 = 500
frequency2 = 1000
amplitude = 10

#Set how many times you want to listen/see the periods
number_of_periods = 1000

#Defining sinewaves:
hz_1 = sinusoid(frequency1, amps = 10, dur = 2*number_of_periods, fs = 22050, sum = FALSE, 
          show = FALSE, colors = NULL)

hz_2 = sinusoid(frequency2, amps = 10, dur = 2*number_of_periods, fs = 22050, sum = FALSE, 
                  show = FALSE, colors = NULL)

sr = 22050 #Sample rate
#Listening to sine waves
listen(hz_1$wave1, f = sr)
listen(hz_2$wave1, f = sr)

###################################
##Visualizing sine waves together##
###################################

#How many periods you want to visualize (set in relation to the lowest frequency)
n_p = 1
plot(hz_1$wave1[1:45*n_p], type = 'ls', col = 'blue', ylab = 'Amplitude', xlab = 'Tempo (ms)', main = 'Ondas senoidais 500 Hz vs 1000 Hz', xlim = c(0, 45))
par(new = TRUE)
plot((hz_2$wave1[1:45*n_p])*-1, type = 'ls', col = 'red', ylab = '', xlab = '', main = '', xlim = c(0, 45))

########################
## DEFASANDO ESTIMULO ##
########################

#Defining multiple tones with 'defasagem'
um <- hz_1$wave1[1:(length(hz_1$wave1)-1000)] #Original tone
dois <- hz_2$wave1[1001:length(hz_2$wave1)] #Tone out of phase

#Combining them
combined = um+dois


listen(combined, f = 22050)
listen(hz_1$wave1+hz_2$wave1, f = 22050)

###################################
## Visualizing Crossing patterns ##
###################################

#Function receives two vectors and checks when they cross
#This is a rough estimation of the crossing point, 
#because our resolution depends on the sampling rate of 
#the sine wave

crossing_points <- function(sine1, sine2){
  estados = c()
  for (i in 1:length(sine1)){
    if (sine1[i] > sine2[i]) {
      estado = 0
    } else {
      estado = 1
    }
    estados[[i]] <- estado
  }
  
  crossings = c()
  for (i in 2:length(estados)) {
    if (estados[i] != estados[i-1]) {
      crossings[[i]] = i
    }
  }
  crossings = na.omit(crossings)
  return(crossings)
}
#How many periods do you want to visualize? (choose 1, otherwise
#the green lines will not work)
n_p = 1
plot(um[1:45*n_p], type = 'ls', col = 'blue', ylab = 'Amplitude', xlab = 'Tempo (ms)', main = 'Som complexo fora de fase \n Linha verde é ~crossing point')
par(new = TRUE)
plot(dois[1:45*n_p], type = 'ls', col = 'red', ylab = '', xlab = '', main = '')
abline(v=c(crossing_points(um, dois)[1:4]), col= "green")



