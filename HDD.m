%EEE552 project 2 Hard decision decoding function
function [rate] = HDD(b)
snr = b;
G = [1 0 1 0 1;0 1 0 1 1]; %generator matrix
H = [1 0 1 0 0;0 1 0 1 0;1 1 0 0 1];%parity check matrix
simu = 0; %number of simulations
error = 0;%number of errors
while true
    u = floor(rand(1,2)+0.5);%info bits
    %bits to tansmit in {-1,+1}
    c = 2*mod(u*G,2)-1;             
    %received bits in{-1,+1}
    cr = (sign(snr*c+mvnrnd(zeros(1,5),eye(5)))+1)/2;
    s = mod(cr*H',2);  %syndrome
    e = syndrome(s);   %associated error
    cdecode = mod(cr+e,2); % final decoded codeword
    if 2*cdecode-1 == c
        simu = simu+1;
    else
        error = error + 1;
        simu = simu + 1;
    end
    if error > 500
        break;
    elseif simu > 5000000
        break;
    end
end
rate = error/simu;
end
function [e] = syndrome(s)
if s == [0 0 0]
    e = [0 0 0 0 0];
elseif s == [0 0 1]
    e = [0 0 0 0 1];
elseif s == [0 1 0]
    e = [0 0 0 1 0];
elseif s == [1 0 0]
    e = [0 0 1 0 0];
elseif s == [0 1 1]
    e = [0 1 0 0 0];
elseif s == [1 0 1]
    e = [1 0 0 0 0];
elseif s == [1 1 0]
    e = [1 1 0 0 0];
else
    e = [1 0 0 1 0];
end
end
