%% part3 (a)

% nBits = 16; % Number of bits to represent each sample
% nChannels = 1; % Mono channel
% ID = -1; % Default audio input device
% recObj = audiorecorder(Fs,nBits,nChannels,ID);
% disp('Start speaking first message for 4 seconds')
% recordblocking(recObj,4);
% disp('End of recording the first message')
% myrecording = getaudiodata(recObj);
% m1 = getaudiodata(recObj);
% filename = 'message3.wav'; % Name of the file 
% audiowrite(filename,m1,Fs);

Fs = 40000; % Sampling rate
td = 1/Fs; % Time Duration
T = 4; 
t = td:td:T; % approximation of continuous time
[m1,Fs] = audioread("message3.wav"); % assign the message to m1
sound(m1,Fs);

%plotting

figure(1)
plot(t,m1)
title('Message Signal')
xlabel('Time-Seconds')

%% part (b)
Fc=8000; % carrier frequency
m1_hil = imag(hilbert(m1));

m1_usb_mod = m1.*cos(2*pi*Fc*t') - m1_hil.*sin(2*pi*Fc*t'); % USB modulation 
m1_dsb_mod = m1.*2.*cos(2*pi*Fc*t'); % DSB modulation

sa = dsp.SpectrumAnalyzer('SampleRate',Fs, ...
    'PlotAsTwoSidedSpectrum',true,'NumInputPorts',3, ...
    'ChannelNames',{'Message','USB signal','DSB signal'});
sa(m1,m1_usb_mod,m1_dsb_mod);
release(sa);

%% part (c)
%% Please change the N = 1e-6; with N = 1e-3; for part(e)

N = 1e-3;
w = sqrt(N)*randn(size(m1));
usb_w = m1_usb_mod + w;
dsb_w = m1_dsb_mod + w;

%% part(d)

figure(2)
subplot(211)
plot(t,m1)
hold on
plot(t,usb_w)
xlim([1.4 1.403])
legend('Message Signal','USB Mod. Signal')
xlabel('Time-Seconds')
hold off

subplot(212)
plot(t,m1)
hold on
plot(t,dsb_w)
xlim([1.4 1.403])
legend('Message Signal','DSB Mod. Signal')
xlabel('Time-Seconds')


figure(3)
plot(t,m1)
hold on
plot(t,usb_m1_rec1)
legend('Original m1','Recovered m1 usb','Location','best')
title('Original Message and Recovered Message with USB')
xlim([1.4 1.403])

figure(4)
plot(t,m1)
hold on
plot(t,lsb_m1_rec2)
legend('Original m1','Recovered m1 lsb','Location','best')
title('Original Message and Recovered Message with LSB')
xlim([1.4 1.403])

%% USB/LSB demod. and recover the message
usb_dem = 2*cos(2*pi*Fc*t').*usb_w;
lsb_dem = 2*cos(2*pi*Fc*t').*dsb_w;

% LPF
f_cutoff=4000;
f_stop=6000;
lpFilt=designfilt('lowpassfir','PassbandFrequency',f_cutoff,'StopbandFrequency',f_stop,'samplerate',Fs);
fvtool(lpFilt)

usb_m1_rec1 = filter(lpFilt,usb_dem); % Recover the m1 with usb_dem
lsb_m1_rec2 = filter(lpFilt,lsb_dem); % Recover the m1 with lsb_dem

disp('Original Message')
sound(m1,Fs)
pause(3.0)

disp('Recovered Message with usb_dem')
sound(usb_m1_rec1,Fs)
pause(3.0)

disp('Recovered Message with lsb_dem')
sound(lsb_m1_rec2,Fs)
pause(3.0)