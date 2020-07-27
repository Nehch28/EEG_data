
vbot_1 = "201905151321data.DAT";
eeg_1= "201905151321data_EnobioData.csv";
 
vbot_2 = "201905151426data.DAT";
eeg_2 = "201905151426data_EnobioData.csv";
 
vbot_3 = "201905151522data.DAT";
eeg_3 = "201905151522data_EnobioData.csv";
 

%% preparation of the data 
 
data1 = dataPrepare(vbot_1,eeg_1);
data2 = dataPrepare(vbot_2, eeg_2)
data3 = dataPrepare(vbot_3,eeg_3);



%% segregated according to cues
 
[data1.cue1,data1.cue2,data1.cue3] = seperateClasses(vbot_1,data1.data);
[data2.cue1,data2.cue2,data2.cue3]  = seperateClasses(vbot_2,data2.data);
[data3.cue1,data3.cue2,data3.cue3]  = seperateClasses(vbot_3,data3.data);

[n_data.data,n_data.cue1,n_data.cue2,n_data.cue3] = concatenate(data1,data2);
[n_data.data,n_data.cue1,n_data.cue2,n_data.cue3] = concatenate(n_data,data3);


%% Artifact Removal

n_data.cue1(:,:,[53,57,61,64,72,78,93,95,101,149,160,170,171,183,202,210,222,245]) = [];
n_data.cue2(:,:,[2,3,18,51,53,55,60,65,67,70,72,75,76,80,82,96,98,105,106,112,116,118,134,144,145,148,149,150,159,176,197,207,208,216]) = [];
n_data.cue3(:,:,[42,61,68,69,72,73,80,90,96,98,100,105,107,116,128,132,152,156,157,159,163,188,199,204,257,305])=[];


%% Squaring and Averaging

n_data.tsquared_c1data.full = squareData(5,0.5,30,n_data.cue1);

n_data.tsquared_c1data.alpha = squaredData(5, 8, 13,n_data.cue1);
n_data.tsquared_c1data.beta = squaredData(5, 14, 30,n_data.cue1);
n_data.tsquared_c1data.theta = squaredData(5, 4, 7,n_data.cue1);

n_data.tsquared_c2data.full = squareData(5,0.5,30,n_data.cue1);

n_data.tsquared_c2data.alpha = squaredData(5, 7, 13,n_data.cue2);
n_data.tsquared_c2data.beta = squaredData(5, 14, 30,n_data.cue2);
n_data.tsquared_c2data.theta = squaredData(5, 4, 7,n_data.cue2);

n_data.tsquared_c3data.full = squareData(5,0.5,30,n_data.cue1);

n_data.tsquared_c3data.alpha = squaredData(5, 8, 14,n_data.cue3);
n_data.tsquared_c3data.beta = squaredData(5, 14, 30,n_data.cue3);
n_data.tsquared_c3data.theta = squaredData(5, 4, 7,n_data.cue3);

n_data.taverage_c1data.alpha = average_overtrials(n_data.tsquared_c1data.alpha,3);
n_data.taverage_c1data.beta = average_overtrials(n_data.tsquared_c1data.beta,3);
n_data.taverage_c1data.theta = average_overtrials(n_data.tsquared_c1data.theta,3);

n_data.taverage_c2data.alpha = average_overtrials(n_data.tsquared_c2data.alpha,3);
n_data.taverage_c2data.beta = average_overtrials(n_data.tsquared_c2data.beta,3);
n_data.taverage_c2data.theta = average_overtrials(n_data.tsquared_c2data.theta,3);

n_data.taverage_c3data.alpha = average_overtrials(n_data.tsquared_c3data.alpha,3);
n_data.taverage_c3data.beta = average_overtrials(n_data.tsquared_c3data.beta,3);
n_data.taverage_c3data.theta = average_overtrials(n_data.tsquared_c3data.theta,3);


%% Time Analysis with Baseline1
%{
[n_data.baseline.One.cue1,n_data.baseline.One.cue2,n_data.baseline.One.cue3] = extractBaseline(vbot_1,eeg_1);
[n_data.baseline.Two.cue1,n_data.baseline.Two.cue2,n_data.baseline.Two.cue3] = extractBaseline(vbot_2,eeg_2);
[n_data.baseline.Three.cue1,n_data.baseline.Three.cue2,n_data.baseline.Three.cue3] = extractBaseline(vbot_3,eeg_3);

n_data.finalbaseline.cue1 = concatenateBaseline(n_data.baseline.One.cue1,n_data.baseline.Two.cue1,n_data.baseline.Three.cue1,[53,57,61,64,72,78,93,95,101,149,160,170,171,183,202,210,222,245]);
n_data.finalbaseline.cue2= concatenateBaseline(n_data.baseline.One.cue2,n_data.baseline.Two.cue2,n_data.baseline.Three.cue2,[2,3,18,51,53,55,60,65,67,70,72,75,76,80,82,96,98,105,106,112,116,118,134,144,145,148,149,150,159,176,197,207,208,216]);
n_data.finalbaseline.cue3 = concatenateBaseline(n_data.baseline.One.cue3,n_data.baseline.Two.cue3,n_data.baseline.Three.cue3,[42,61,68,69,72,73,80,90,96,98,100,105,107,116,128,132,152,156,157,159,163,188,199,204,257,305]);


n_data.window_c1data.alpha = windowingaveraged(n_data.taverage_c1data.alpha,1, 256,n_data.finalbaseline.cue1);
n_data.window_c1data.beta = windowingaveraged(n_data.taverage_c1data.beta,1, 256,n_data.finalbaseline.cue1);
n_data.window_c1data.theta = windowingaveraged(n_data.taverage_c1data.theta,1, 256,n_data.finalbaseline.cue1);


n_data.window_c2data.alpha = windowingaveraged(n_data.taverage_c2data.alpha,1, 256,n_data.finalbaseline.cue2);
n_data.window_c2data.beta = windowingaveraged(n_data.taverage_c2data.beta,1, 256,n_data.finalbaseline.cue2);
n_data.window_c2data.theta = windowingaveraged(n_data.taverage_c2data.theta,1, 256,n_data.finalbaseline.cue2);

n_data.window_c3data.alpha = windowingaveraged(n_data.taverage_c3data.alpha,1, 256,n_data.finalbaseline.cue3);
n_data.window_c3data.beta = windowingaveraged(n_data.taverage_c3data.beta,1, 256,n_data.finalbaseline.cue3);
n_data.window_c3data.theta = windowingaveraged(n_data.taverage_c3data.theta,1, 256,n_data.finalbaseline.cue3);
%}

%}

%% Time Analysis with Baseline2

timeSeries_final_alpha_cue1 = windowingaveraged(n_data.taverage_c1data.alpha,1, 256);
timeSeries_final_beta_cue1 = windowingaveraged(n_data.taverage_c1data.beta,1, 256);
timeSeries_final_theta_cue1 = windowingaveraged(n_data.taverage_c1data.theta,1, 256);

timeSeries_final_alpha_cue2 = windowingaveraged(n_data.taverage_c2data.alpha,1, 256);
timeSeries_final_beta_cue2 = windowingaveraged(n_data.taverage_c2data.beta,1, 256);
timeSeries_final_theta_cue2 = windowingaveraged(n_data.taverage_c2data.theta,1, 256);

timeSeries_final_alpha_cue3 = windowingaveraged(n_data.taverage_c3data.alpha,1, 256);
timeSeries_final_beta_cue3 = windowingaveraged(n_data.taverage_c3data.beta,1, 256);
timeSeries_final_theta_cue3 = windowingaveraged(n_data.taverage_c3data.theta,1, 256);


corrected1 = baselineCorrection(timeSeries_final_alpha_cue1);
corrected2 = baselineCorrection(timeSeries_final_beta_cue1);
corrected3 = baselineCorrection(timeSeries_final_theta_cue1);
corrected4 = baselineCorrection(timeSeries_final_alpha_cue2);
corrected5 = baselineCorrection(timeSeries_final_beta_cue2);
corrected6 = baselineCorrection(timeSeries_final_theta_cue2);
corrected7 = baselineCorrection(timeSeries_final_alpha_cue3);
corrected8 = baselineCorrection(timeSeries_final_beta_cue3);
corrected9 = baselineCorrection(timeSeries_final_theta_cue3);

%%Reassignment to data structure
n_data.window_c1data.alpha = corrected1;
n_data.window_c1data.beta = corrected2;
n_data.window_c1data.theta = corrected3;

n_data.window_c2data.alpha = corrected4;
n_data.window_c2data.beta = corrected5;
n_data.window_c2data.theta = corrected6;

n_data.window_c3data.alpha = corrected7;
n_data.window_c3data.beta = corrected8
n_data.window_c3data.theta = corrected9;

%% Frequency Analysis
n_data.fsquared_c1data.full = squaredData(5,0.5,100,n_data.cue1);
n_data.fsquared_c1data.scaled = squaredData(5,3,30,n_data.cue1);

n_data.fsquared_c2data.full = squaredData(5,0.5,100,n_data.cue2);
n_data.fsquared_c2data.scaled = squaredData(5,3,30,n_data.cue2);

n_data.fsquared_c3data.full = squaredData(5,0.5,100,n_data.cue3);
n_data.fsquared_c3data.scaled = squaredData(5,3,30,n_data.cue3);


%% Averaging over Trials

n_data.averagedfrequencyanalysisc1.full = mean(n_data.fsquared_c1data.full,3);
n_data.averagedfrequencyanalysisc1.scaled = mean(n_data.fsquared_c1data.scaled,3);

n_data.averagedfrequencyanalysisc2.full = mean(n_data.fsquared_c2data.full,3);
n_data.averagedfrequencyanalysisc2.scaled = mean(n_data.fsquared_c2data.scaled,3);

n_data.averagedfrequencyanalysisc3.full = mean(n_data.fsquared_c3data.full,3);
n_data.averagedfrequencyanalysisc3.scaled = mean(n_data.fsquared_c3data.scaled,3);


n_data.frequencyanalysisc1.full = frequencyAnalysis1(n_data.averagedfrequencyanalysisc1.full  ,1 ,256);
n_data.frequencyanalysisc1.scaled = frequencyAnalysis1(n_data.averagedfrequencyanalysisc1.scaled ,1 ,256);

n_data.frequencyanalysisc2.full = frequencyAnalysis1(n_data.averagedfrequencyanalysisc2.full  ,1 ,256);
n_data.frequencyanalysisc2.scaled = frequencyAnalysis1(n_data.averagedfrequencyanalysisc2.scaled,1 ,256);

n_data.frequencyanalysisc3.full = frequencyAnalysis1(n_data.averagedfrequencyanalysisc3.full  ,1 ,256);
n_data.frequencyanalysisc3.scaled = frequencyAnalysis1(n_data.averagedfrequencyanalysisc3.scaled ,1 ,256);





%% STEP 1: DATA PREPARE : Nehchal
%extracting eeg data for 2.5 seconds before the movement start and 2.5 seconds
%after movement start 
%storing only that eeg data which has 2500 signals and creating structure 

function [eeg_sequence] = getEegSequence(data, startTime, endTime)
    rows = data.Var1 >= startTime & data.Var1 < endTime;
    eeg_sequence = data(rows,2:9);
end

function[data] = dataPrepare(vbot_file,eeg_file)
vbot = DATAFILE_Read1(vbot_file);
eeg = readtable(eeg_file);
m_O = vbot.TimeLog_MovementStart;
movement_start = int32(m_O*1000);
before_movement = movement_start-(2500);
after_movement = movement_start+(2500);

i=1;
while(i<=length(vbot.Trials))
    
    array = getEegSequence(eeg, before_movement(i), after_movement(i));
    if(height(array)==2500)
    data_trials(i).data = array;
    end
    i=i+1;
end

    

%data = zeros(2500,8);

for k=1:length(data_trials)
        data.data(:,:,k) = data_trials(k).data{:,:};
end
end

function[C1,C2,C3,C4] = concatenate(data1,data2)
A1 = data1.data;
A2 = data1.cue1;
A3 = data1.cue2;
A4 = data1.cue3;

B1 = data2.data;
B2 = data2.cue1;
B3 = data2.cue2;
B4 = data2.cue3;

C1 = cat(3,A1,B1);
C2 = cat(3,A2,B2);
C3 = cat(3,A3,B3);
C4 = cat(3,A4,B4);

end

%% STEP 2: cue combined data : Nehchal
% extracting time index according to cue information 

function [cue1_data,cue2_data,cue3_data] = seperateClasses(vbot_file,data)
vbot = DATAFILE_Read1(vbot_file);
length1 = length(data(1,1,:));
%clubbing data with labels (cue number i.e 1, 2, 3)
labels=vbot.CueNumber;
labels = labels(1:length1);
% Creating index list of all trial containing specified cue number
c1=find(labels ==1);
c2=find(labels==2);
c3=find(labels ==3);
% for channel 1

cue1_data = data(:,:,c1); 
cue2_data = data(:,:,c2);
cue3_data = data(:,:,c3);
end

%% STEP 3: bandpass,filtering and squaring data with 500kHZ sampling frequency rate : Asmita
%i.e. dividing limits by sampling frequency rate /2 using butterworth for
%bandpass and filtfilt for filtering 

function [squared_data] = squaredData(order, lowerLimit, upperLimit,data)
    [b,a] = butter(order,[lowerLimit/250,upperLimit/250], 'bandpass');  
    filtered_data = filtfilt(b,a,data);
    squared_data = filtered_data.^2;
end


%% STEP 4: averaging over trials 
function [average_data] = average_overtrials(data, dim)
average_data = mean(data,dim);
end 

%% baseline extraction for separate cues : Nehchal
%{
function [b1,b2,b3] = extractBaseline(vbot_file,eeg_file)
vbot = DATAFILE_Read1(vbot_file);
eeg = readtable(eeg_file);
%time_Index = 1000 * vbot.TimeLog_CueOn;
%base_StartTime = time_Index - 2000; 
m_O = vbot.TimeLog_MovementStart;
%movement_start = int32(m_O*1000);
time_Index = int32(m_O*1000);
base_StartTime = time_Index - 1250; 

for i = 1:length(vbot.Trials)
    baseline(i).base = getEegSequence(eeg, base_StartTime(i), time_Index(i));
    
end

base_sequence = zeros(625,8);

for k=1:length(vbot.Trials)
        base_sequence(:,:,k) = baseline(k).base{:,:};
end

baseline_average = mean(base_sequence,1);

baseline_data = baseline_average.^2;

[b1,b2,b3] = seperateClasses(vbot_file,baseline_data);

end

function[cat_baseline] = concatenateBaseline(data1,data2,data3, indices)
baseline_final = cat(3,data1,data2);
baseline_final = cat(3,data3,baseline_final);

baseline_final(:,:, indices) = [];
cat_baseline = mean(baseline_final,3);
end
%}
%% TIME ANALYSIS for averaged data : Nehchal

function [timeSeries_final] = windowingaveraged(data,timestep, windowSize)
    % iterating over one channel at a time
     
        windowStart = 1;
        windowEnd = windowSize;
        h = 1;       
        D = zeros(1,8);
        
             while(windowEnd<=length(data)) 
                D(:,:) = mean(data(1:256,:));
                windoweddata(h, :) = mean(data(windowStart:windowEnd,:));
                
                %timeSeries_final(h,:) = windoweddata(h,:);
               timeSeries_final(h,:) = windoweddata(h,:)-D(1,:)/D(1,:)*100;
                windowStart = windowStart + timestep;
                windowEnd = windowEnd + timestep; 
                h = h+1;
            
             end
            

end

function[corrected_data] = baselineCorrection(timeSeries_final)
corrected_data = zeros(2245,8);
c = timeSeries_final(1,:);
corrected_data(:,:) = (timeSeries_final(:,:).^2-c(:,:).^2)./c(:,:).^2*100;
end

%{
%% TIME ANALYSIS FOR EVERY TRAIL

function [timeSeries_final] = windowingaveraged(data,timestep, windowSize,baseline_data)
    % iterating over one channel at a time
     
        windowStart = 1;
        windowEnd = windowSize;
        h = 1;       
        
             while(windowEnd<=length(data)) 
                
                windoweddata(h, :, :) = mean(data(windowStart:windowEnd,:,:));
                timeSeries_final(h,:,:) = windoweddata(h,:,:)-baseline_data(1,:)/baseline_data(1,:)*100;
                windowStart = windowStart + timestep;
                windowEnd = windowEnd + timestep; 
                h = h+1;
            
        end

end
%}

%% Frequency Analysis : Asmita and Nehchal

function [fft_data] = frequencyAnalysis1(data,time_step,window_size)
    window_start = 1;
    window_end = window_size;
    %initializing array 
    fft_data = zeros(window_size/2,8,(length(data(:,1)) - window_size)/2);
    h=1;
    
        % iterating until window_end ~= no fo signal 
        while(window_end <= length(data(:,1))) 
            % 1. taking out signal 
            %data for all channels for one window
             window1 = data(window_start:window_end,:); 
             
             % 2. hamming window
             w = hamming(window_size);
             windowed = window1.*w;
            
             % 3. fft
             fftw = fft(windowed);
             
             %4. magnitude 
             %dividing it into half
             fftwd = fftw(1:(length(fftw))/2,:);
             magnitude = 20*log10(abs(fftwd));
             
             % returning 3 dim array 
             fft_data(:,:,h) = magnitude;
             
             window_start = window_start+time_step;
             window_end = window_end+time_step;
             h=h+1;
        end
        
end





