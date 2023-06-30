clear all;
close all;
clc

W = 1e6;
Rs = W;
Ts = 1/Rs;
EbN0dB_Vec = 4:4:20;
M = 16;
m = sqrt(M);
d = 1;

L = log2(M);
Rb = L*Rs;
Tb = 1/Rb;
c = 1;

while c<=length(EbN0dB_Vec)

    EbN0dB = EbN0dB_Vec(c);
    sim("mpam_model_inclass.slx")
    sim("mqam_model_inclass.slx")

    Pb_sim_mqam(d,c) = ErrorVec(1);
    EbN0 = 10^(EbN0dB/10);
    Ps = (2*(m-1)/m)*qfunc(sqrt((6*log2(m)/((m^2)-1))*EbN0));
    Pb_theo_mqam(d,c) = Ps/log2(m);

    Pb_sim_mpam(d,c) = ErrorVec(1);
%   EbN0 = 10^(EbN0dB/10);
    Ps = (2*(M-1)/M)*qfunc(sqrt((6*log2(M)/((M^2)-1))*EbN0));
    Pb_theo_mpam(d,c) = Ps/log2(M);
    c = c+1;
end

figure(1)
semilogy(EbN0dB_Vec,Pb_theo_mqam,'b-o')
hold on
semilogy(EbN0dB_Vec,Pb_sim_mqam,'g-v')

semilogy(EbN0dB_Vec,Pb_theo_mpam,'k-*')
semilogy(EbN0dB_Vec,Pb_sim_mpam,'m-+')
grid on
legend('16QAM-Theo','16QAM-Sim','16PAM-Theo','16-PAM Sim','Location','southwest')
xlabel('E_b / N_0 in dB')
ylabel('BER')