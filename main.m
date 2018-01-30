%EEE552 Project 2 main file
clc;
clear;
N = 20;
SNRb = 0:0.25:N; %Eb/N0 dB scale
[~,n] = size(SNRb);
SNR = SNRb*2/5;  %Es/N0 dB scale
snr = 10.^(SNR./10);%Es/N0 linear scale
prob = zeros(3,n);
for i = 1:n
    prob(1,i) = HDD(sqrt(snr(i)));
    prob(2,i) = SDD(sqrt(snr(i)));
    prob(3,i) = iterative(sqrt(snr(i)));
    per = i/n*100;
    disp(per);
end
probf = zeros(3,n);
for i = 1:n
    p = qfunc(sqrt(snr(i)));
    probf(1,i) = 2*qfunc(sqrt(3*snr(i)))+qfunc(sqrt(4*snr(i))); %SDD upper bound
    probf(2,i) = 1-(5*p*(1-p)^4+2*p^2*(1-p)^3+(1-p)^5);%HDD exact bound
    probf(3,i) = 10*p^2*(1-p)^3+10*p^3*(1-p)^2+5*p^4*(1-p)+p^5;%HDD upper bound
end
figure(1);
semilogy(SNRb,prob(1,:),'--');hold on;
title('simulation results of 3 decoders');
semilogy(SNRb,prob(2,:),'-.');
semilogy(SNRb,prob(3,:));hold;
legend('HDD','SDD','iterative');
ylabel('code word error rate');
xlabel('Eb/N0');
figure(2);
semilogy(SNRb,prob(1,:),'--');hold on;
title('bounds and simu result of HDD');
semilogy(SNRb,probf(2,:),'-.');
semilogy(SNRb,probf(3,:));
hold;
legend('simu result','exact bound','upper bound');
ylabel('code word error rate');
xlabel('Eb/N0');
figure(3);
semilogy(SNRb,prob(2,:),'--');hold on;
title('bound and simu result of SDD');
semilogy(SNRb,probf(1,:));hold;
legend('simu result','upper bound')
ylabel('code word error rate');
xlabel('Eb/N0');