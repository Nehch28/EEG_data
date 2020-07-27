%% Correlation - Asmita and Nehchal

correlation_data.cue12_full = correlationanalysis(n_data.fsquared_c1data.full, n_data.fsquared_c2data.full, 1000, 1780);
correlation_data.cue13_full = correlationanalysis(n_data.fsquared_c1data.full, n_data.fsquared_c3data.full, 1000, 1780);
correlation_data.cue23_full = correlationanalysis(n_data.fsquared_c2data.full, n_data.fsquared_c3data.full, 1000, 1780);
correlation_data.cue13_full= permute(correlation_data.cue13_full, [2,1]);
correlation_data.cue23_full= permute(correlation_data.cue23_full, [2,1]);
correlation_data.cue12_full= permute(correlation_data.cue12_full, [2,1]);




correlation_data.cue123_full = correlationanalysis3(n_data.fsquared_c1data.full, n_data.fsquared_c2data.full, n_data.fsquared_c3data.full, 1000, 1780);
correlation_data.cue312_full = correlationanalysis3(n_data.fsquared_c3data.full, n_data.fsquared_c1data.full, n_data.fsquared_c2data.full, 1000, 1780);
correlation_data.cue231_full = correlationanalysis3(n_data.fsquared_c2data.full, n_data.fsquared_c3data.full, n_data.fsquared_c1data.full, 1000, 1780);




function[correlation_data] = correlationanalysis(data1, data2, timestart, timeend)
c_data1 = fft_data(data1,timestart,timeend);
c_data2 = fft_data(data2, timestart, timeend);

c_data = cat(3, c_data1, c_data2);
c_fdata = permute (c_data, [3,2,1]);

labelvector1 = zeros(length(c_data1(1,1,:)) , 1);
labelvector2 = ones((length(c_data2(1,1,:))), 1);
labelvector = cat(1, labelvector1, labelvector2);
 
for i = 1:8
    correlation_data(:,i) = corr(labelvector(:,1),squeeze(c_fdata(:,i,:))).^2;
end

end

function[correlation_data] = correlationanalysis3(data1, data2, data3, timestart, timeend)
c_data1 = fft_data(data1,timestart,timeend);
c_data2 = fft_data(data2, timestart, timeend);
c_data3 = fft_data(data3, timestart, timeend);

c_data = cat(3, c_data1, c_data2, c_data3);
c_fdata = permute (c_data, [3,2,1]);

labelvector1 = zeros(length(c_data1(1,1,:))+ length(c_data2(1,1,:)) , 1);
labelvector2 = ones((length(c_data3(1,1,:))), 1);
labelvector = cat(1, labelvector1, labelvector2);
 
for i = 1:8
    correlation_data(:,i) = corr(labelvector(:,1),squeeze(c_fdata(:,i,:))).^2;
end

correlation_data = correlation_data';

end

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

