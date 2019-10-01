recording = audiorecorder(44100,24,1,-1);
recordblocking(recording,5);
 
filename = "sample.wav";
record = getaudiodata(recording);
audiowrite(filename,record,44100);
play(recording);

[y,fs]=audioread("sample.wav");

 vol1 = audioplayer(y,fs);
 vol2 = audioplayer(y,24000);
 vol3 = audioplayer(y,16000);
 vol4 = audioplayer(y,8000);
 vol5 = audioplayer(y,4000);

 playblocking(vol1);
 playblocking(vol2);
 playblocking(vol3);
 playblocking(vol4);
 playblocking(vol5);

 [sample1,fs1]=audioread("WIDE HALL-1.wav");
 [sample2,fs2]=audioread("STRANGEBOX-2.wav");
 [sample3,fs3]=audioread("SMALL CHURCH E001 M2S.wav");
 
 y = y(:,1);
 sample1 = sample1(:,1);
 sample2 = sample2(:,1);
 sample3 = sample3(:,1);
 
 c1 = conv(y,sample1);
 c2 = conv(y,sample2);
 c3 = conv(y,sample3);

vol6 = audioplayer(c1,fs);
playblocking(vol6);
vol7 = audioplayer(c2,fs);
playblocking(vol7);
vol8 = audioplayer(c3,fs);
playblocking(vol8);