%% FOR CUE1 & CUE 2
%feature extraction from time analysis
% for channel 1 and channel 2 correlation 
% ALPHA RANGE (8-13 HZ) = 12-21 Signals  
% BETA RANGE (14-30 HZ) = 22-47 Signals
% THETA RANGE (4-7 HZ) = 7-11 Signals 

feature.extracted.f1 = concatenatedtimefeature(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,724,1500,1);
feature.extracted.f1 = concatenatedtimefeature(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,724,1500,2);
feature.extracted.f2 = concatenatedtimefeature(a_c1data.tsquared_c1data.alpha,a_c2data.tsquared_c2data.alpha,724,1500,4);
feature.extracted.f3= concatenatedtimefeature(a_c1data.tsquared_c1data.beta,a_c2data.tsquared_c2data.beta,724,1500,8);
feature.extracted.f4 = concatenatedtimefeature(a_c1data.tsquared_c1data.alpha,a_c2data.tsquared_c2data.alpha,724,1500,8);



[b,c] = concatenatedtimefeature(a_c1data.tsquared_c1data.alpha,a_c2data.tsquared_c2data.alpha,724,1500,8);
scatter(b,c(1,1:302))


% concatenated
%{
feature.finalvector = horzcat(feature.vector1,feature.vector2,feature.vector3,feature.vector4,feature.vector5,feature.vector6,feature.vector7,feature.vector8,feature.vector9);


labelvector1 = zeros(1,302);
labelvector2 = ones(1,322);
labelvector = cat (2, labelvector1, labelvector2);

feature.ldl = fitcdiscr(feature.finalvector, labelvector, 'discrimtype', 'diaglinear');

%}


%% FOR CUE1 & CUE 2
%feature extraction from time analysis
function[b,c] = concatenatedtimefeature(data1,data2,timestart,timeend,channel)
b = featureextract(data1,channel, timestart, timeend);
c = featureextract(data2,channel, timestart, timeend);
%finaldata = cat(2,b,c);
%finaldata = permute(finaldata, [2,1]);
end

function[feature_data] = featureextract(data,channel, timestart, timeend)
%extracting information from squareddata for specific band 
a = squeeze(data(timestart:timeend,channel,:));
feature_data = var(a);
end


%% frequency feature extraction 
%{
function[frequencyfeature] = freqfeature(data1,data2,timestart,timeend,channel,freqstart,freqend) 
a = freqextraction(data1,timestart,timeend,channel,freqstart,freqend);
b = freqextraction(data2,timestart,timeend,channel,freqstart,freqend);
f = cat(2,a,b);
frequencyfeature = permute(f, [2,1]); 

end
%}
%{
function[frequencydata] = freqextraction(data,timestart,timeend,channel,freqstart,freqend)
f = fft_data(data, timestart, timeend); %creating periodogram
a = length(f(:,1,1))/250; %calculating the no of points in 1 frequency 
f = squeeze(f(freqstart*a:freqend*a,channel,:)); %taking out frequency range specified
m = mean(f,3);
m = mean(m,1);
maxv = max(f);
frequencydata = maxv - m;
end
%}

function[frequencydata] = freqextraction(data1,data2, timestart,timeend,channel,freqstart,freqend)
f1 = fft_data(data1, timestart, timeend);%creating periodogram
f2 = fft_data(data2, timestart, timeend);
a = length(f1(:,1,1))/250; %calculating the no of points in 1 frequency 
f1 = squeeze(f1(freqstart*a:freqend*a,channel,:));%taking out frequency range specified
f2 = squeeze(f2(freqstart*a:freqend*a,channel,:));
f = cat(2,f1,f2);
m = mean(f,2);
m = mean(m,1);
maxv1 = mean(f1,1);
maxv2 = mean(f2,1);
maxv1 = maxv1 - m;
maxv2 = maxv2 - m;
g = cat(2,maxv1,maxv2);
frequencydata = permute(g, [2,1]);
end

% periodogram 

function [fft_d] = fft_data(data1, timestart, timeend)
fft_d1 = data1(timestart:timeend, :, :); %taking out the periodogram from timestart to timened where the desynchronization is visible in the data 
%creating a hamming window for the data
w = hamming(length(fft_d1(:,1,1)));
%mutliplying the hamming window with the data
fft11 = fft_d1.*w;
fft1 = fft(fft11);
fftwd1 = fft1(1:(length(fft1(:,1,1)))/2,:,:);
%taking magnitude of fft
magnitude = 20*log10(abs(fftwd1));

%taking out the ratio of signals in every 1 frequency and then fitting the
%data into 250 nyquist frequency by dividing it frequency calculated 
frequency = length(magnitude(:,1,1))/250;
fft_d = magnitude(:,:,:)./frequency;


end 
