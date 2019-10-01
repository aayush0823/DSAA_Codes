num = findnumber("Police.ogg");
disp(num);
function [result] = findnumber(audio_file)
    
    sample = audioinfo(audio_file);
    single = audioinfo('q3/1.ogg');
    num_samples = sample.Duration/single.Duration;
    
    step = sample.SampleRate*single.Duration;
%     plot(audioread("q3/1.ogg"));
    
    dial_tones = zeros(10,step);
    a = audioread('q3/0.ogg');
    dial_tones(1,:) = a(1:step);
    a = audioread('q3/1.ogg');
    dial_tones(2,:) = a(1:step);
    a = audioread('q3/2.ogg');
    dial_tones(3,:) = a(1:step);
    a = audioread('q3/3.ogg');
    dial_tones(4,:) = a(1:step);
    a = audioread('q3/4.ogg');
    dial_tones(5,:) = a(1:step);
    a = audioread('q3/5.ogg');
    dial_tones(6,:) = a(1:step);
    a = audioread('q3/6.ogg');
    dial_tones(7,:) = a(1:step);
    a = audioread('q3/7.ogg');
    dial_tones(8,:) = a(1:step);
    a = audioread('q3/8.ogg');
    dial_tones(9,:) = a(1:step);
    a = audioread('q3/9.ogg');
    dial_tones(10,:) = a(1:step);
    
    tone = audioread(audio_file);
    
    result = uint64(0);
    for i = [1:1:num_samples]
        x = tone((i-1)*step +1 : i*step);
        [a,max_num] = max(dial_tones*x);
        result = 10*result + max_num - 1;
    end
end
