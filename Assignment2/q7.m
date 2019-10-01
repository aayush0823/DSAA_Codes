[y fs] = audioread('chirp.wav');
window = 100;
stride = 10;
A = myspectrogram(y, window,stride);
B = spectrogram(y, window, stride);
figure
subplot(1,2,1), imshow(log(A(:,1:round(window/2))).');
subplot(1,2,2), imshow(abs(B));
sgtitle("MySpectrogram vs In-built at Window Size = 500 and stride = 50");

[input,fs] = audioread('message.wav');
figure
pspectrum(input,fs,'spectrogram','Leakage',0,'OverlapPercent',0,'FrequencyLimits',[0, 6000]);

dial(20171188);
function output = dial(rollnum)

freq=2000;
wait_len=0:1/freq:0.4;
sig_len=0:1/freq:0.8;

rollnum = num2str(rollnum) ;
rollnum = uint8(rollnum) - '0';

output = zeros(1);

for i=1:length(rollnum)
    a = rollnum(i);
    if a == 0
        add = sin(2*pi*941*sig_len)+sin(2*pi*1336*sig_len);
    end
    
    if a == 1
        add = sin(2*pi*1209*sig_len)+sin(2*pi*697*sig_len);
    end
    
    if a == 2
        add = sin(2*pi*697*sig_len)+sin(2*pi*1336*sig_len);
    end
    
    if a == 3
        add = sin(2*pi*697*sig_len)+sin(2*pi*1477*sig_len);
    end
    
    if a == 4
        add = sin(2*pi*770*sig_len)+sin(2*pi*1209*sig_len);
    end
    
    if a == 5
        add = sin(2*pi*770*sig_len)+sin(2*pi*1336*sig_len);
    end
    
    if a == 6
        add = sin(2*pi*770*sig_len)+sin(2*pi*1477*sig_len);
    end
    
    if a == 7
        add = sin(2*pi*1209*sig_len)+sin(2*pi*852*sig_len);
    end
    
    if a == 8
        add = sin(2*pi*852*sig_len)+sin(2*pi*1336*sig_len);
    end
    
    if a == 9
        add = sin(2*pi*852*sig_len)+sin(2*pi*1477*sig_len);
    end
    gap = sin(wait_len);
    output = horzcat(output,add);
    if length(rollnum) == i
        break;
    else
         output = horzcat(output,gap);
    end
    
end
figure
pspectrum(output,freq,'spectrogram','Leakage',0,'OverlapPercent',0,'FrequencyLimits',[600, 1600]);
sound(output);
end

function result = myspectrogram(audio, window, stride)
n = length(audio);
step = window - stride;

offset = [ 1 : step : n-window ];

result = zeros (length(offset),window);

for i=1:length(offset)
    result(i,1:window) = abs(fft(audio(offset(i):offset(i)+window-1)));
end

end