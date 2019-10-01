recording = audiorecorder(44100,24,1,-1);
recordblocking(recording,7);
  
filename = "my_voice.wav";
record = getaudiodata(recording);
audiowrite(filename,record,44100);
play(recording);

[original,fs] = audioread("my_voice.wav");
fast = downsample(original,2);
slow = upsample(original,2);

disp("Original");
playerObj6 = audioplayer(original,fs); 
playblocking(playerObj6);

subplot(3,1,1);
plot(original);
title('Original');

disp("Fast");
playerObj7 = audioplayer(fast,fs);
playblocking(playerObj7);

subplot(3,1,2);
plot(fast);
title('Fast');

disp("Slow");
playerObj8 = audioplayer(slow,fs);
playblocking(playerObj8);

subplot(3,1,3);
plot(slow);
title('Slow');