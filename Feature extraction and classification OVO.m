%% Feature Extraction and Classification - Nehchal
%% FOR CUE1 & CUE 2
%feature extraction from time analysis
% for channel 1 and channel 2 correlation 
% ALPHA RANGE (8-13 HZ) = 11-18 Signals  
% BETA RANGE (14-30 HZ) = 19-41 Signals
% THETA RANGE (4-7 HZ) = 6-10 Signals 


feature_cue23.extracted.f1 = concatenatedtimefeature(n_data.tsquared_c2data.theta,n_data.tsquared_c3data.theta,1000,1780,2);
feature_cue23.extracted.f2 = concatenatedtimefeature(n_data.tsquared_c2data.alpha,n_data.tsquared_c3data.alpha,1000,1780,2)
feature_cue23.extracted.f3 = concatenatedtimefeature(n_data.tsquared_c2data.alpha,n_data.tsquared_c3data.alpha,1000,1780,1)
feature_cue23.extracted.f4 = concatenatedtimefeature(n_data.tsquared_c2data.theta,n_data.tsquared_c3data.theta,1000,1780,4);
feature_cue23.extracted.f5 = concatenatedtimefeature(n_data.tsquared_c2data.beta,n_data.tsquared_c3data.beta,1000,1780,4)
feature_cue23.extracted.f6 = concatenatedtimefeature(n_data.tsquared_c2data.alpha,n_data.tsquared_c3data.alpha,1000,1780,4)

feature_cue23.variance.feature1 = extractedVariance(feature_cue23.extracted.f1);
feature_cue23.variance.feature2 = extractedVariance(feature_cue23.extracted.f2);
feature_cue23.variance.feature3 = extractedVariance(feature_cue23.extracted.f3);
feature_cue23.variance.feature4 = extractedVariance(feature_cue23.extracted.f4);
feature_cue23.variance.feature5 = extractedVariance(feature_cue23.extracted.f5);
feature_cue23.variance.feature6 = extractedVariance(feature_cue23.extracted.f6);

feature_cue23.mean.feature1 = extractedMean(feature_cue23.extracted.f1);
feature_cue23.mean.feature2 = extractedMean(feature_cue23.extracted.f2);
feature_cue23.mean.feature3 = extractedMean(feature_cue23.extracted.f3);
feature_cue23.mean.feature4 = extractedMean(feature_cue23.extracted.f4);
feature_cue23.mean.feature5 = extractedMean(feature_cue23.extracted.f5);
feature_cue23.mean.feature6 = extractedMean(feature_cue23.extracted.f6);


feature_cue23.peak.feature1 = extractedPeaks(feature_cue23.extracted.f1);
feature_cue23.peak.feature2 = extractedPeaks(feature_cue23.extracted.f2);
feature_cue23.peak.feature3 = extractedPeaks(feature_cue23.extracted.f3);
feature_cue23.peak.feature4 = extractedPeaks(feature_cue23.extracted.f4);
feature_cue23.peak.feature5 = extractedPeaks(feature_cue23.extracted.f5);
feature_cue23.peak.feature6 = extractedPeaks(feature_cue23.extracted.f6);


feature_cue23.TMean.feature1 = extractedTotalMean(feature_cue23.extracted.f1);
feature_cue23.TMean.feature2 = extractedTotalMean(feature_cue23.extracted.f2);
feature_cue23.TMean.feature3 = extractedTotalMean(feature_cue23.extracted.f3);
feature_cue23.TMean.feature4 = extractedTotalMean(feature_cue23.extracted.f4);
feature_cue23.TMean.feature5 = extractedTotalMean(feature_cue23.extracted.f5);
feature_cue23.TMean.feature6 = extractedTotalMean(feature_cue23.extracted.f6);


feature_cue23.finalvector12 = horzcat(feature_cue23.variance.feature1,feature_cue23.variance.feature2,feature_cue23.variance.feature3,feature_cue23.variance.feature4,feature_cue23.variance.feature5,feature_cue23.variance.feature6,feature_cue23.mean.feature1,feature_cue23.mean.feature2,feature_cue23.mean.feature3,feature_cue23.mean.feature4,feature_cue23.mean.feature5,feature_cue23.mean.feature6,feature_cue23.peak.feature1,feature_cue23.peak.feature2,feature_cue23.peak.feature3,feature_cue23.peak.feature4,feature_cue23.peak.feature5,feature_cue23.peak.feature6,feature_cue23.TMean.feature1,feature_cue23.TMean.feature2,feature_cue23.TMean.feature3,feature_cue23.TMean.feature4,feature_cue23.TMean.feature5,feature_cue23.TMean.feature6);

labelvector1 = zeros(1,302);
labelvector2 = ones(1,317);
labelvector = cat (2, labelvector1, labelvector2);

feature_cue23.ldl12 = fitcdiscr(feature_cue23.finalvector12, labelvector, 'discrimtype', 'diaglinear');
feature_cue23.svm12 = fitcsvm(feature_cue23.finalvector12,labelvector,'Standardize',true);

[feature_cue23.lda.K_mean, feature_cue23.lda.Std_data] = cross_val(feature_cue23.ldl12,10);
[feature_cue23.svm.K_mean, feature_cue23.svm.Std_data] = cross_val(feature_cue23.svm12,10);

%% For classes 1 amd 3
feature_cue13.extracted.f1 = concatenatedtimefeature(n_data.tsquared_c1data.beta,n_data.tsquared_c3data.beta,1000,1780,3);
feature_cue13.extracted.f2 = concatenatedtimefeature(n_data.tsquared_c1data.beta,n_data.tsquared_c3data.beta,1000,1780,6)
feature_cue13.extracted.f3 = concatenatedtimefeature(n_data.tsquared_c1data.alpha,n_data.tsquared_c3data.alpha,1000,1780,6)
feature_cue13.extracted.f4 = concatenatedtimefeature(n_data.tsquared_c1data.theta,n_data.tsquared_c3data.theta,1000,1780,4);
feature_cue13.extracted.f5 = concatenatedtimefeature(n_data.tsquared_c1data.beta,n_data.tsquared_c3data.beta,1000,1780,4);
feature_cue13.extracted.f6 = concatenatedtimefeature(n_data.tsquared_c1data.alpha,n_data.tsquared_c3data.alpha,1000,1780,4);

feature_cue13.variance.feature1 = extractedVariance(feature_cue13.extracted.f1);
feature_cue13.variance.feature2 = extractedVariance(feature_cue13.extracted.f2);
feature_cue13.variance.feature3 = extractedVariance(feature_cue13.extracted.f3);
feature_cue13.variance.feature4 = extractedVariance(feature_cue13.extracted.f4);
feature_cue13.variance.feature5 = extractedVariance(feature_cue13.extracted.f5);
feature_cue13.variance.feature6 = extractedVariance(feature_cue13.extracted.f6);

feature_cue13.mean.feature1 = extractedMean(feature_cue13.extracted.f1);
feature_cue13.mean.feature2 = extractedMean(feature_cue13.extracted.f2);
feature_cue13.mean.feature3 = extractedMean(feature_cue13.extracted.f3);
feature_cue13.mean.feature4 = extractedMean(feature_cue13.extracted.f4);
feature_cue13.mean.feature5 = extractedMean(feature_cue13.extracted.f5);
feature_cue13.mean.feature6 = extractedMean(feature_cue13.extracted.f6);


feature_cue13.peak.feature1 = extractedPeaks(feature_cue13.extracted.f1);
feature_cue13.peak.feature2 = extractedPeaks(feature_cue13.extracted.f2);
feature_cue13.peak.feature3 = extractedPeaks(feature_cue13.extracted.f3);
feature_cue13.peak.feature4 = extractedPeaks(feature_cue13.extracted.f4);
feature_cue13.peak.feature5 = extractedPeaks(feature_cue13.extracted.f5);
feature_cue13.peak.feature6 = extractedPeaks(feature_cue13.extracted.f6);


feature_cue13.TMean.feature1 = extractedTotalMean(feature_cue13.extracted.f1);
feature_cue13.TMean.feature2 = extractedTotalMean(feature_cue13.extracted.f2);
feature_cue13.TMean.feature3 = extractedTotalMean(feature_cue13.extracted.f3);
feature_cue13.TMean.feature4 = extractedTotalMean(feature_cue13.extracted.f4);
feature_cue13.TMean.feature5 = extractedTotalMean(feature_cue13.extracted.f5);
feature_cue13.TMean.feature6 = extractedTotalMean(feature_cue13.extracted.f6);


feature_cue13.finalvector12 = horzcat(feature_cue13.variance.feature1,feature_cue13.variance.feature2,feature_cue13.variance.feature3,feature_cue13.variance.feature4,feature_cue13.variance.feature5,feature_cue13.variance.feature6,feature_cue13.mean.feature1,feature_cue13.mean.feature2,feature_cue13.mean.feature3,feature_cue13.mean.feature4,feature_cue13.mean.feature5,feature_cue13.mean.feature6,feature_cue13.peak.feature1,feature_cue13.peak.feature2,feature_cue13.peak.feature3,feature_cue13.peak.feature4,feature_cue13.peak.feature5,feature_cue13.peak.feature6,feature_cue13.TMean.feature1,feature_cue13.TMean.feature2,feature_cue13.TMean.feature3,feature_cue13.TMean.feature4,feature_cue13.TMean.feature5,feature_cue13.TMean.feature6);

labelvector1 = zeros(1,350);
labelvector2 = ones(1,317);
labelvector = cat (2, labelvector1, labelvector2);

feature_cue13.ldl12 = fitcdiscr(feature_cue13.finalvector12, labelvector, 'discrimtype', 'diaglinear');
feature_cue13.svm12 = fitcsvm(feature_cue13.finalvector12,labelvector,'Standardize',true);

[feature_cue13.lda.K_mean, feature_cue13.lda.Std_data] = cross_val(feature_cue13.ldl12,10);
[feature_cue13.svm.K_mean, feature_cue13.svm.Std_data] = cross_val(feature_cue13.svm12,10);


%% For classes 1 and 2
feature_cue12.extracted.f1 = concatenatedtimefeature(n_data.tsquared_c1data.beta,n_data.tsquared_c2data.beta,1000,1780,1);
feature_cue12.extracted.f2 = concatenatedtimefeature(n_data.tsquared_c1data.beta,n_data.tsquared_c2data.beta,1000,1780,2)
feature_cue12.extracted.f3 = concatenatedtimefeature(n_data.tsquared_c1data.alpha,n_data.tsquared_c2data.alpha,1000,1780,1)
feature_cue12.extracted.f4 = concatenatedtimefeature(n_data.tsquared_c1data.theta,n_data.tsquared_c2data.theta,1000,1780,1);
feature_cue12.extracted.f5 = concatenatedtimefeature(n_data.tsquared_c1data.theta,n_data.tsquared_c2data.theta,1000,1780,2);
feature_cue12.extracted.f6 = concatenatedtimefeature(n_data.tsquared_c1data.alpha,n_data.tsquared_c2data.alpha,1000,1780,2);

feature_cue12.variance.feature1 = extractedVariance(feature_cue12.extracted.f1);
feature_cue12.variance.feature2 = extractedVariance(feature_cue12.extracted.f2);
feature_cue12.variance.feature3 = extractedVariance(feature_cue12.extracted.f3);
feature_cue12.variance.feature4 = extractedVariance(feature_cue12.extracted.f4);
feature_cue12.variance.feature5 = extractedVariance(feature_cue12.extracted.f5);
feature_cue12.variance.feature6 = extractedVariance(feature_cue12.extracted.f6);

feature_cue12.mean.feature1 = extractedMean(feature_cue12.extracted.f1);
feature_cue12.mean.feature2 = extractedMean(feature_cue12.extracted.f2);
feature_cue12.mean.feature3 = extractedMean(feature_cue12.extracted.f3);
feature_cue12.mean.feature4 = extractedMean(feature_cue12.extracted.f4);
feature_cue12.mean.feature5 = extractedMean(feature_cue12.extracted.f5);
feature_cue12.mean.feature6 = extractedMean(feature_cue12.extracted.f6);


feature_cue12.peak.feature1 = extractedPeaks(feature_cue12.extracted.f1);
feature_cue12.peak.feature2 = extractedPeaks(feature_cue12.extracted.f2);
feature_cue12.peak.feature3 = extractedPeaks(feature_cue12.extracted.f3);
feature_cue12.peak.feature4 = extractedPeaks(feature_cue12.extracted.f4);
feature_cue12.peak.feature5 = extractedPeaks(feature_cue12.extracted.f5);
feature_cue12.peak.feature6 = extractedPeaks(feature_cue12.extracted.f6);


feature_cue12.TMean.feature1 = extractedTotalMean(feature_cue12.extracted.f1);
feature_cue12.TMean.feature2 = extractedTotalMean(feature_cue12.extracted.f2);
feature_cue12.TMean.feature3 = extractedTotalMean(feature_cue12.extracted.f3);
feature_cue12.TMean.feature4 = extractedTotalMean(feature_cue12.extracted.f4);
feature_cue12.TMean.feature5 = extractedTotalMean(feature_cue12.extracted.f5);
feature_cue12.TMean.feature6 = extractedTotalMean(feature_cue12.extracted.f6);


feature_cue12.finalvector12 = horzcat(feature_cue12.variance.feature1,feature_cue12.variance.feature2,feature_cue12.variance.feature3,feature_cue12.variance.feature4,feature_cue12.variance.feature5,feature_cue12.variance.feature6,feature_cue12.mean.feature1,feature_cue12.mean.feature2,feature_cue12.mean.feature3,feature_cue12.mean.feature4,feature_cue12.mean.feature5,feature_cue12.mean.feature6,feature_cue12.peak.feature1,feature_cue12.peak.feature2,feature_cue12.peak.feature3,feature_cue12.peak.feature4,feature_cue12.peak.feature5,feature_cue12.peak.feature6,feature_cue12.TMean.feature1,feature_cue12.TMean.feature2,feature_cue12.TMean.feature3,feature_cue12.TMean.feature4,feature_cue12.TMean.feature5,feature_cue12.TMean.feature6);

labelvector1 = zeros(1,350);
labelvector2 = ones(1,302);
labelvector = cat (2, labelvector1, labelvector2);

feature_cue12.ldl12 = fitcdiscr(feature_cue12.finalvector12, labelvector, 'discrimtype', 'diaglinear');
feature_cue12.svm12 = fitcsvm(feature_cue12.finalvector12,labelvector,'Standardize',true);

[feature_cue12.lda.K_mean, feature_cue12.lda.Std_data] = cross_val(feature_cue12.ldl12,10);
[feature_cue12.svm.K_mean, feature_cue12.svm.Std_data] = cross_val(feature_cue12.svm12,10);

%% FOR CUE1 & CUE 2
%feature extraction from time analysis, frequency and time-frequency
function[finaldata] = concatenatedtimefeature(data1,data2,timestart,timeend,channel)
b = featureextract(data1,channel, timestart, timeend);
c = featureextract(data2,channel, timestart, timeend);
final_data = cat(2,b,c);
finaldata = permute(final_data, [2,1]);
end


function[feature_data] = featureextract(data,channel, timestart, timeend)
%extracting information from squareddata for specific band 
feature_data = squeeze(data(timestart:timeend,channel,:));
%feature_data = var(a);
end

function [feature_vector_variance] = extractedVariance(data1)
featureVec = permute(data1,[2 1]);
v = var(featureVec);
feature_vector_variance = permute(v, [2 1]);
end
 
function [feature_vector_mean] = extractedMean(data1)
feature_vector_mean = mean(data1,2);
end
 
function [feature_vector_peaks] = extractedPeaks(data1)
P1 = permute(data1,[2 1]);
peak = max(P1);
P2 = permute(peak,[2 1]);
extracted_data = mean(data1,2);
feature_vector_peaks = extracted_data - P2;
end

function [feature_vector_mean_together] = extractedTotalMean(data1)
Mean = mean(data1,1);
total_mean = mean(Mean);
FM = mean(data1,2);
feature_vector_mean_together = FM - total_mean;
end

function [K_mean, Std_data] = cross_val(data1,fold)
cross = crossval(data1, 'kfold', fold)
K = kfoldLoss(cross,'Mode','individual');
K = 1-K;
K_mean = mean(K)*100;
Std_data = std(K)*100;
end



