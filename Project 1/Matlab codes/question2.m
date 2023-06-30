%% part (a) 

% nBits = 16; % Number of bits to represent each sample
% nChannels = 1; % Mono channel
% ID = -1; % Default audio input device
% recObj = audiorecorder(Fs,nBits,nChannels,ID);
% disp('Start speaking first message for 4 seconds')
% recordblocking(recObj,4);
% disp('End of recording the first message')
% myrecording = getaudiodata(recObj);
% m1 = getaudiodata(recObj);
% filename = 'message1.wav'; % Name the file 
% audiowrite(filename,m1,Fs);

Fs = 40000; % Sampling rate
td = 1/Fs; % Time Duration
T = 4; 
t = td:td:T; % approximation of cont time
[m1,Fs] = audioread("message1.wav"); % assign the message to m1
sound(m1,Fs)
pause(3.0); %for delay

% recObj2 = audiorecorder(Fs,nBits,nChannels,ID);
% disp('Start speaking first message for 4 seconds')
% recordblocking(recObj2,4);
% disp('End of recording the first message')
% myrecording = getaudiodata(recObj2);
% m2 = getaudiodata(recObj2);
% filename = 'message2.wav'; % Name the file 
% audiowrite(filename,m2,Fs);
[m2,Fs] = audioread("message2.wav"); % assign the message to m2
sound(m2,Fs)

%plotting

figure(1)
subplot(211)
plot(t,m1)

title('Message 1 Signal')
xlabel('Time - Seconds')

subplot(212)
plot(t,m2)

title('Message 2 Signal')
xlabel('Time - Seconds')


% part (b)

Fc=8000; % carrier freq
qam_mod = m1.*cos(2*pi*Fc*t')+m2.*sin(2*pi*Fc*t');
sa=dsp.SpectrumAnalyzer('SampleRate',Fs, ...
    'PlotAsTwoSidedSpectrum',true,'NumInputPorts',1, ...
    'ChannelNames',{'QAM Spectrum'});
sa(qam_mod);
release(sa);


% % part (c)

%% Please change the N = 1e-6; with N = 1e-3; for part(e)
N = 1e-3;
w = sqrt(N)*randn(size(qam_mod));
qam_mod = qam_mod + w;

% plotting qam & m1

figure(2)
plot(t,m1)
hold on
plot(t,qam_mod)
title('QAM + M1')
xlim([1.5 1.51])

% part (d)

m1_rec = 2*cos(2*pi*Fc*t').*qam_mod;
m2_rec = 2*sin(2*pi*Fc*t').*qam_mod;

% Design a LPF

f_cutoff1=3000;
f_stop1=5000;
lpFilt1=designfilt('lowpassfir','PassbandFrequency',f_cutoff1,'StopbandFrequency',f_stop1,'samplerate',Fs);
fvtool(lpFilt1)

f_cutoff2 = 3000;
f_stop2 = 5000;
lpFilt2 = designfilt('lowpassfir','passbandfrequency',f_cutoff2,'stopbandfrequency',f_stop2,'samplerate',Fs);
fvtool(lpFilt2)

m1_demod_rec = filter(lpFilt1,m1_rec);
m2_demod_rec=filter(lpFilt2,m2_rec);

% Now, listen the all original and recovered messages

disp('Original Message')
sound(m1,Fs)
pause(3.0)

disp('Recovered Message')
sound(m1_demod_rec,Fs)
pause(3.0)

disp('Original Message 2')
sound(m2,Fs)
pause(3.0)

disp('Recovered Message 2')
sound(m2_demod_rec,Fs)

% plotting

figure(3)
plot(t,m1)
hold on
plot(t,m1_demod_rec)
legend('Original m1','Recovered m1','Location','best')
title('Original Message1 and Recovered Message1')
xlim([1.5 1.51])

figure(4)
plot(t,m2)
hold on
plot(t,m2_demod_rec)
legend('Original m2','Recovered m2','Location','best')
title('Original Message2 and Recovered Message2')
xlim([1.5 1.51])