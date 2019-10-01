[y1,f1]=audioread('q5/1.wav');
[y2,f2]=audioread('q5/2.wav');
[y3,f3]=audioread('q5/3.wav');
[y4,f4]=audioread('q5/4.wav');
[y5,f5]=audioread('q5/5.wav');
y={y1,y2,y3,y4,y5};
f=[f1,f2,f3,f4,f5];
t = {(0:length(y{1}))/f(1),(0:length(y{2}))/f(2),(0:length(y{3}))/f(3),(0:length(y{4}))/f(4),(0:length(y{5}))/f(5)};
start = {y{1}(t{1}<5),y{2}(t{2}<5),y{3}(t{3}<5),y{4}(t{4}<5),y{5}(t{5}<5)};
finish = {y{1}(t{1}>(length(y{1})/f(1)-5)),y{2}(t{2}>(length(y{2})/f(2)-5)),y{3}(t{3}>(length(y{3})/f(3)-5)),y{4}(t{4}>(length(y{4})/f(4)-5)),y{5}(t{5}>(length(y{5})/f(5)-5))};

corval=[0 0 0 0 0];
pair = [-1 -1 -1 -1 -1];
for s = 1:5
    for e = 1:5
        if s ~= e
            temp=max(xcorr(start{s},finish{e}));
            if temp > corval(s)
                corval(s)=temp;
                pair(s)=e;
            end
        end
    end
end
ans = [];
final_signal = [];
first = find(corval == min(corval));
ans=[ans first];
final_signal=[final_signal;medfilt1(y{first})];
second = find(pair == first);
final_signal=[final_signal;medfilt1(y{second})];
ans=[ans second];
third = find(pair == second);
final_signal=[final_signal;medfilt1(y{third})];
ans=[ans third];
fourth = find(pair == third);
final_signal=[final_signal;medfilt1(y{fourth})];
ans=[ans fourth];
fifth = find(pair == fourth);
final_signal=[final_signal;medfilt1(y{fifth})];
ans=[ans fifth];
disp(ans);
final_signal = smoothdata(final_signal,'sgolay');
final_signal = smoothdata(final_signal,'gaussian');
% sound(final_signal);