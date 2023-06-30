% % part (a) 

% nBits = 16; %number of bits to represent each sample
% nChannels = 1; % mono channel
% ID = -1; % default audio input device
% recObj = audiorecorder(Fs,nBits,nChannels,ID);
% disp('Start speaking first message for 4 seconds')
% recordblocking(recObj,4);
% disp('End of recording the first message')
% myrecording = getaudiodata(recObj);
% m1 = getaudiodata(recObj); 
% filename = 'message.wav'; % name of the file
% audiowrite(filename,m1,Fs);
% play(recObj);

Fs = 40000; % sampling rate
T = 4;
td = 1/Fs; 
t = td:td:T; % approximation of continuous time
[m1,Fs] = audioread("message.wav");
figure(1)
plot(t,m1)
xlabel('Time - Seconds')
ylabel('Amplitude')

% % part (b)

fs = 8000; % if fs decrease, sample decrease
ts = 1/fs; 
n = length(m1);
N = ts/td; % N should be an integer                                                   
s_out = downsample(m1,N);
s_out = upsample(s_out,N);

figure(2)
plot(t,m1)
hold on
stem(t,s_out,'r')
grid on
xlabel('time')
legend('Original Message Signal','Sampled Message Signal')
xlim([1.5 1.501])
xlabel('Time - Seconds')
ylabel('Amplitude')

% part (c)
sa = dsp.SpectrumAnalyzer('SampleRate',Fs,'PlotAsTwoSidedSpectrum',true, ...
    'NumInputPorts',2,'ChannelNames', ...
    {'Message','Sampled Signal'});
sa(m1,s_out);
release(sa);


% part (d)

f = (-(n-1)/2:(n-1)/2)*(Fs/n); % Generate the discrete frequency vector x axis 
fre_m1 = fftshift(fft(m1,n)); % Computes the FT of original (approximately) continuous time signal
fre_s_out = fftshift(fft(s_out,n)); % Computes the FT of sampled discrete time signal

figure(3)
stem(f,(fre_m1)/n,'b-s')
hold on 
stem(f,(fre_s_out)/n,'r-s')
grid on
xlabel('Frequency')
legend('Original Signal Spectrum','Sampled Signal Spectrum')
title('Frequency Domain of Original and Sampled Signal before LPF')

% Design a LPF for Reconstruction
f_cutoff = 3000;
f_stop = 5000;
lpFilt = designfilt('lowpassfir','PassbandFrequency',f_cutoff,'StopbandFrequency',f_stop,'Samplerate',Fs);
fvtool(lpFilt)
m1_rec = N*filter(lpFilt,s_out);
sound(m1_rec,Fs)

figure(4)
plot(t,m1,'b')
hold on
plot(t,m1_rec,'r')
grid on
legend('Original Message','Recovered Message')
title('Time Domain of Original and Recovered Signal')
xlabel('Time')
xlim([1.494 1.5])

fre_m1r = fftshift(fft(m1_rec,n));
figure(5)
stem(f,abs(fre_m1)/n,'b-s')
hold on
stem(f,abs(fre_m1r)/n,'r-o')
grid on
legend('Original Message Spectrum','Recovered Message Spectrum')
title('Frequency Domain of Original and Recovered Signal')
xlabel('Frequency')


% part (e) 
% % Repeat the above steps for the new sampling rate 4 kHz

fs = 4000; % we sample the(approximately) continuous time signal at
ts = 1/fs;  % Sampling period
N = ts/td; % N should be an integer
s_out = downsample(m1,N);
s_out = upsample(s_out,N); 

[m1,Fs] = audioread("message.wav");
figure(1)
plot(t,m1)
xlabel('Time - Seconds')
ylabel('Amplitude')

figure(6)
plot(t,m1)
hold on
stem(t,s_out,'r')
grid on
xlabel('Time')
legend('Original Signal','Sampled Signal','Location','SouthWest')
title('Original and Sampled Signal for 4 kHz')
xlim([1.5 1.501]) % very short time

sa = dsp.SpectrumAnalyzer('SampleRate',Fs,'PlotAsTwoSidedSpectrum',true, ...
    'NumInputPorts',2,'ChannelNames', ...
    {'Message','Sampled Signal'});
sa(m1,s_out);
release(sa);

f = (-(n-1)/2:(n-1)/2)*(Fs/n); % Generate the discrete frequency vector x axis 
fre_m1 = fftshift(fft(m1,n)); % Computes the FT of original (approximately) cont. time signal
fre_s_out = fftshift(fft(s_out,n)); % Computes the FT of sampled disc. time signal

figure(7)
stem(f,(fre_m1)/n,'b-s')
hold on 
stem(f,(fre_s_out)/n,'r-s')
grid on
xlabel('Frequency')
legend('Original Signal Spectrum','Sampled Signal Spectrum')
title('Frequency Domain of Original and Sampled Signal before LPF for 4 kHz')

% % Design a LPF for Reconstruction

f_cutoff = 3000;
f_stop = 5000;
lpFilt = designfilt('lowpassfir','PassbandFrequency',f_cutoff,'StopbandFrequency',f_stop,'Samplerate',Fs);
fvtool(lpFilt)
m1_rec = N*filter(lpFilt,s_out);

% Time domain
figure(8)
plot(t,m1,'b')
hold on
plot(t,m1_rec,'r')
grid on
legend('Original Message','Recovered Message')
title('Time Domain of Original and Recovered Signal for 4 kHz')
xlabel('Time')
xlim([1.494 1.5])
sound(m1_rec,Fs)

% Frequency domain
fre_m1r = fftshift(fft(m1_rec,n));
figure(9)
stem(f,abs(fre_m1)/n,'b-s')
hold on
stem(f,abs(fre_m1r)/n,'r-o')
grid on
legend('Original Message Spectrum','Recovered Message Spectrum')
title('Frequency Domain of Original and Recovered Signal for 4 kHz')
xlabel('Frequency')
