%% Use of CSP to generate features : Asmita

[csp.cue1_2, csp.cue2_1] = CSP_data(n_data.tsquared_c1data.full,n_data.tsquared_c2data.full);

[csp.cue1_3, csp.cue3_1] = CSP_data(n_data.tsquared_c1data.full,n_data.tsquared_c3data.full);

[csp.cue2_3, csp.cue3_2] = CSP_data(n_data.tsquared_c2data.full,n_data.tsquared_c3data.full);

Classification.lda.data_1_2 = csp_classification(csp.cue1_2,csp.cue2_1);
Classification.lda.data_1_3 = csp_classification(csp.cue1_3,csp.cue3_1);
Classification.lda.data_2_3 = csp_classification(csp.cue2_3,csp.cue3_2);

Classification.svm.data_1_2 = csp_svmclassification(csp.cue1_2,csp.cue2_1);
Classification.svm.data_1_3 = csp_svmclassification(csp.cue1_3,csp.cue3_1);
Classification.svm.data_2_3 = csp_svmclassification(csp.cue2_3,csp.cue3_2);

[Classification.accuracy.lda.data_1_2.mean, Classification.accuracy.lda.data_1_2.SD] = cross_val(Classification.lda.data_1_2,10);
[Classification.accuracy.lda.data_1_3.mean, Classification.accuracy.lda.data_1_3.SD] = cross_val(Classification.lda.data_1_3,10);
[Classification.accuracy.lda.data_2_3.mean, Classification.accuracy.lda.data_2_3.SD] = cross_val(Classification.lda.data_2_3,10);

[Classification.accuracy.svm.data_1_2.mean, Classification.accuracy.svm.data_1_2.SD] = cross_val(Classification.svm.data_1_2,10);
[Classification.accuracy.svm.data_1_3.mean, Classification.accuracy.svm.data_1_3.SD] = cross_val(Classification.svm.data_1_3,10);
[Classification.accuracy.svm.data_2_3.mean, Classification.accuracy.svm.data_2_3.SD] = cross_val(Classification.svm.data_2_3,10);

[csp.cue12_3, csp.cue3_12] = CSP_data3(n_data.tsquared_c1data.full,n_data.tsquared_c2data.full,n_data.tsquared_c3data.full);

[csp.cue13_2, csp.cue2_13] = CSP_data3(n_data.tsquared_c1data.full,n_data.tsquared_c3data.full,n_data.tsquared_c2data.full);

[csp.cue23_1, csp.cue1_23] = CSP_data3(n_data.tsquared_c2data.full,n_data.tsquared_c3data.full,n_data.tsquared_c1data.full);

Classification.lda.data_12_3 = csp_classification(csp.cue12_3,csp.cue3_12);
Classification.lda.data_13_2 = csp_classification(csp.cue13_2,csp.cue2_13);
Classification.lda.data_23_1 = csp_classification(csp.cue23_1,csp.cue1_23);

Classification.svm.data_12_3 = csp_svmclassification(csp.cue12_3,csp.cue3_12);
Classification.svm.data_13_2 = csp_svmclassification(csp.cue13_2,csp.cue2_13);
Classification.svm.data_23_1 = csp_svmclassification(csp.cue23_1,csp.cue1_23);

[Classification.accuracy.lda.data_12_3.mean, Classification.accuracy.lda.data_12_3.SD] = cross_val(Classification.lda.data_12_3,10);
[Classification.accuracy.lda.data_13_2.mean, Classification.accuracy.lda.data_13_2.SD] = cross_val(Classification.lda.data_13_2,10);
[Classification.accuracy.lda.data_23_1.mean, Classification.accuracy.lda.data_23_1.SD] = cross_val(Classification.lda.data_23_1,10);

[Classification.accuracy.svm.data_12_3.mean, Classification.accuracy.svm.data_12_3.SD] = cross_val(Classification.svm.data_12_3,10);
[Classification.accuracy.svm.data_13_2.mean, Classification.accuracy.svm.data_13_2.SD] = cross_val(Classification.svm.data_13_2,10);
[Classification.accuracy.svm.data_23_1.mean, Classification.accuracy.svm.data_23_1.SD] = cross_val(Classification.svm.data_23_1,10);


function [csp_data1, csp_data2] = CSP_data(data1, data2)

%Input data:3 dimensional filtered and squared data of the form
%samples*channels*trials

%Making covaraince matrix for each data set
cov1 = covarianceMatrix(data1);
cov2 = covarianceMatrix(data2);

%Taking mean of each covariance matrix
covMean_data1 = squeeze(mean(cov1,3));
covMean_data2 = squeeze(mean(cov2,3));

%Eigenvalues with both means as an input to the function
%EG : Vectors, EV : Eigenvalues
[EG,EV] = eig(covMean_data1,covMean_data2 );

%Sort in descending order to distinguish between 
%highest and lowest variance 
[~,ind] = sort(diag(EV),'descend');
 EG = EG(:,ind);
 
%Taking one couple (First and last) spatial filters
spatial_Filters = EG(:, [1 8]);
 
csp_finaldata1 = zeros(2,1);
csp_finaldata2 = zeros(2,1);
i = 1;

%projecting data on the spatial filters
while(i~=size(cov1,3))
    X1 =  spatial_Filters'*data1(:,:,i)';
    Y1 = log(var(X1',1));
    csp_finaldata1(:,:,i)= Y1;
    i = i+1;
end
j = 1;
while(j~=size(cov2,3))
    X2 =  spatial_Filters'*data2(:,:,j)';
    Y2 = log(var(X2',1))
    csp_finaldata2(:,:,j)= Y2;
    j=j+1;
end
 
csp_data1 = squeeze(csp_finaldata1);
csp_data2= squeeze(csp_finaldata2);
 
 
end
 
function [final_data] = covarianceMatrix(data1)
i = 1;
while(i~=length(data1(1,1,:)))
    E = data1(:,:,i);
    final_data(:,:,i) = cov(E)./trace(E'*E);
    i=i+1;
end
end 

%Classification based on extracted features
function [classification_data] = csp_classification(data1,data2)
C = cat(2,data1,data2);
C = permute(C, [2 1])
 
labelvector1 =  zeros(length(data1(1,:)),1);
labelvector2 =  ones(length(data2(1,:)),1);
labelvector = cat(1,labelvector1, labelvector2);
classification_data = fitcdiscr (C, labelvector, 'DiscrimType' , 'pseudoquadratic' );
 
end

%Checking accuracy 
function [K_mean, Std_data] = cross_val(data1,fold)
cross = crossval(data1, 'kfold', fold)
K = kfoldLoss(cross,'Mode','individual');
K = 1-K;
K_mean = mean(K)*100;
Std_data = std(K)*100;
end

function [classification_data] = csp_svmclassification(data1,data2)
C = cat(2,data1,data2);
C = permute(C, [2 1])
 
labelvector1 =  zeros(length(data1(1,:)),1);
labelvector2 =  ones(length(data2(1,:)),1);
labelvector = cat(1,labelvector1, labelvector2);
classification_data = fitcsvm(C, labelvector);
 
end

%%CSP function for 3 datasets
function [csp_data1, csp_data2] = CSP_data3(data1, data2, data3)
data1 = cat(3,data1,data2);
cov1 = covarianceMatrix(data1);
cov2 = covarianceMatrix(data3);
 
covMean_data1 = squeeze(mean(cov1,3));
covMean_data2 = squeeze(mean(cov2,3));
 
[EG,EV] = eig(covMean_data1,covMean_data2 );
[~,ind] = sort(diag(EV),'descend');
 EG = EG(:,ind);
 
spatial_Filters = EG(:, [1 8]);
 
csp_finaldata1 = zeros(2,1);
csp_finaldata2 = zeros(2,1);
i = 1;
while(i~=size(cov1,3))
    X1 =  spatial_Filters'*data1(:,:,i)';
    Y1 = log(var(X1',1));
    csp_finaldata1(:,:,i)= Y1;
    i = i+1;
end
j = 1;
while(j~=size(cov2,3))
    X2 =  spatial_Filters'*data3(:,:,j)';
    Y2 = log(var(X2',1))
    csp_finaldata2(:,:,j)= Y2;
    j=j+1;
end
 
csp_data1 = squeeze(csp_finaldata1);
csp_data2= squeeze(csp_finaldata2);
 
 
end