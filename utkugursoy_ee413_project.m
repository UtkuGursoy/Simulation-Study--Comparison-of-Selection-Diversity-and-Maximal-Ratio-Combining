%% Parameters
M = [1 2 3 4 10 20]; % number of branches
N = 10^8; % number of samples
threshold = 1; % threshold for outage
snr_db = -40:1:10; % average SNR in dB
snr = 10.^(snr_db/10); % average SNR

%% Rayleigh Fading
h = sqrt(0.5)*(randn(N,max(M)) + 1i*randn(N,max(M))); % fading coefficients

%% Selection Diversity
figure;
%subplot(1,2,1);
outage_sel = zeros(1,length(snr));
for m = 1:length(M)
    for ii = 1:length(snr)
        g1 = max(abs(h(:,1:M(m))).^2,[],2)/snr(ii); % channel gain
        outage_sel(ii) = sum(g1<threshold)/N; % outage probability
    end
    semilogy(-snr_db, outage_sel, '-o'); hold on;
end
legend('M=1','M=2','M=3','M=4','M=10','M=20');
xlabel('10*log(γ¯/γ_{0})'); ylabel('Outage Probability (P_{out})');
title('Selection Diversity');

%% Maximal-Ratio Combining

figure;
%subplot(1,2,2);
outage_mrc = zeros(1,length(snr));
for m = 1:length(M)
    for ii = 1:length(snr)
        g2 = sum(abs(h(:,1:M(m))).^2,2)/snr(ii); % channel gain
        outage_mrc(ii) = sum(g2<threshold*M(m))/N; % outage probability
    end
    semilogy(-snr_db-15, outage_mrc, '-x'); hold on;
end

%% Plot results
legend('M=1','M=2','M=3','M=4','M=10','M=20');
xlabel('10*log(γ¯/γ_{0})'); ylabel('Outage Probability (P_{out})');
title('Maximal Ratio Combining');