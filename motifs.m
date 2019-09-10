%this function computes the autocovariance of the signal, to see
%periodicity in the signal and computes similarity between windows
%established by user.
%Input: file with the signal,channel/row to use,window.
%Output: matrix of windows of the signal,autocovariance, lags, similarity index C, correlation for windows

function [mat_s,ac_b,lags,C,i_corr,lags_w] = motifs(s,n,w) 

Fs = 25000;            % Sampling frequency                    
T = (1/Fs)*1e3; %time for each event in ms, sampling interval, you can also do: t(2)-t(1) or dt
N = length(s); %Total number of data points
Tdata = N*T; % Total duration of data
t = [T:T:Tdata]; %time vector
tresh = std(s)*2.5; %treshold 
n_ev = w/T; %number of events in sampling window


tw = round(Tdata/w); %total windows
k = n_ev;

%take points for window established
i=1;
for j = 1:n_ev:length(s)-1 
    mat_s(i,:)=s(j:k);
    i=i+1;
    k=n_ev*i;
end

[ac_b,lags] = xcorr(s-mean(s),N,'normalized'); %xcorr for whole signal, the mean is substracted to the whole signal
C = simil(mat_s); %Computes similarity index in matrix

%xcorr for matrix obtained or for each window obtained
[p q] = size(mat_s);

%[r,lags_w] = xcorr(mat_s(i,:),n_ev,'normalized');
for ii = 1:p 
    [r,lags_w] = xcorr(mat_s(ii,:),n_ev,'normalized');
    i_corr(ii,:) = r;
    %lagsW(i,:) = lags_w;%we have the same lag for all the signal 
end




end