[y, Fs] = audioread('voice01.wav'); 

%high-pass filter
hpFilt = designfilt('highpassiir', 'FilterOrder', 8, 'HalfPowerFrequency', 100, 'SampleRate', Fs); 

yFiltered = filtfilt(hpFilt, y); 

%amplitude extract with pitch func
[p, loc] = pitch(yFiltered, Fs, 'Method', 'NCF', 'Range', [50, 400]); 

%waveform visualisation
t = (0:length(yFiltered)-1) / Fs; 
figure;
plot(t, yFiltered);
title('Waveform of Filtered Audio Signal');
xlabel('Time(s)');
ylabel('Amplitude');

%zero value removal
p = p(p>0);

%amplitude statistics
meanPitch = mean(p);
stdPitch = std(p);
medianPitch = median(p);

%gender check
if meanPitch > 160 && medianPitch > 140 && stdPitch < 80
    gender = 'Female';
else
    gender = 'Male';
end

sound(y, Fs);

disp(['Estimated Gender: ', gender]);
