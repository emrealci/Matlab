clear all;
close all;
clc

%EbN0dB_Vec = 10; % first part
EbN0dB_Vec = 4:10; %second
%M_vec = 2;
%M_vec = 4;
%M_vec = 8;
M_vec = [2 4 8]; 
Rb = 1e4;
Tb = 1/Rb;
d = 1;

while d<=length(M_vec)

    M = M_vec(d);
    k = log2(M);
    Rs = Rb/k;
    Ts = 1/Rs;
    
    c = 1;
    while c<=length(EbN0dB_Vec)
        EbN0dB = EbN0dB_Vec(c);
        sim('mfsk_model_inclass.slx')
        Pb_sim(d,c) = ErrorVec(1);
        EbN0 = 10^(EbN0dB/10);
        EsN0 = k*EbN0;
        Ps_theo = ((M-1)/2)*exp(-EsN0/2);
        Pb_theo(d,c) = ((M/2)/(M-1))*Ps_theo;
    
        c = c+1;
    end
    d = d+1;
end

figure(1)
semilogy(EbN0dB_Vec,Pb_sim(1,:),'r-*')
hold on
semilogy(EbN0dB_Vec,Pb_theo(1,:),'b-o')
semilogy(EbN0dB_Vec,Pb_sim(2,:),'m-+')
semilogy(EbN0dB_Vec,Pb_theo(2,:),'k-v')
semilogy(EbN0dB_Vec,Pb_sim(3,:),'g-x')
semilogy(EbN0dB_Vec,Pb_theo(3,:),'c-+')
grid on
xlabel('E_b / N_0 in dB')
ylabel('BER - P_b')
legend('BFSK Simulated BER','BFSK Theoretical BER',...
    '4FSK Simulated BER','4FSK Theoretical BER','8FSK Simulated BER','8FSK Theoretical BER','Location','SouthWest')