%EEE552 project 2 soft decision decoding
function [rate] = SDD(b)
snr = b;
G = [1 0 1 0 1;0 1 0 1 1]; %generator matrix
H = [1 0 1 0 0;0 1 0 1 0;1 1 0 0 1];%parity check matrix
simu = 0; %number of simulations
error = 0;%number of errors
while true
    u = floor(rand(1,2)+0.5);%info bits
    %bits to tansmit in {-1,+1}
    c = (2*mod(u*G,2)-1);             
    %received bits in{-1,+1}
    cr = snr*c+mvnrnd(zeros(1,5),eye(5));
    cdecoded = decode(cr,snr);
    if 2*cdecoded-1 == c
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
function [cdecoded] = decode(cr,snr)
codewords = [0 0 0 0 0;0 1 0 1 1;1 1 1 1 0;1 0 1 0 1];
r = zeros(1,4);
for i = 1:4
    r(i) = sum((cr-snr*(2*codewords(i,:)-1)).^2);
end
[~,l] = min(r);
cdecoded = codewords(l,:);
end