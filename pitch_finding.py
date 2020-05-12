## ALGORITMO 1

#https://ccrma.stanford.edu/~jos/sasp/Sinusoidal_Peak_Interpolation.html

#Pitch tracking on thresholded parabolically-interpolated STFT.

#This implementation uses the parabolic interpolation method described by [1].

import librosa

s_500, sr = librosa.load(librosa.util.example_audio_file())

pitches, magnitudes = librosa.piptrack(y=y, sr=sr)


##ALGORITMO 2
y, sr = librosa.load(librosa.util.example_audio_file(), offset=10, duration=15)

chroma_stft = librosa.feature.chroma_stft(y=y, sr=sr, n_chroma=12, n_fft=4096)

chroma_cq = librosa.feature.chroma_cqt(y=y, sr=sr)
