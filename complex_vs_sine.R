require(seewave)
require(phonTools)
#1 Hertz = 1 ciclo por 1 segundo, 500 Hz completa um ciclo a cada 2 ms (0.002 s)

number_of_periods = 1000
hz_500 = sinusoid(500, amps = 10, dur = 2*number_of_periods, fs = 22050, sum = FALSE, 
          show = FALSE, colors = NULL)
hz_1000 = sinusoid(1000, amps = 10, dur = 2*number_of_periods, fs = 22050, sum = FALSE, 
                  show = FALSE, colors = NULL)


plot(hz_500$wave1[1:45], type = 'ls', col = 'blue', ylab = 'Amplitude', xlab = 'Tempo (ms)', main = 'Ondas senoidais 500 Hz vs 1000 Hz')
par(new = TRUE)
plot(hz_1000$wave1[1:45], type = 'ls', col = 'red', ylab = '', xlab = '', main = '')

plot(hz_1000$wave1[1:45]+hz_500$wave1[1:45], type = 'ls', ylab = 'Amplitude', xlab = 'Tempo (ms)', main = 'Som complexo  \n 500 Hz + 1000 Hz')

listen(hz_500$wave1, f = 22050)
listen(hz_1000$wave1, f = 22050)
listen(hz_1000$wave1+hz_500$wave1, f = 22050)