%EEE552 project 2 iterative decoding
function [rate] = iterative(b)
snr = b;
G = [1 0 1 0 1;0 1 0 1 1]; %generator matrix
H = [1 0 1 0 0;0 1 0 1 0;1 1 0 0 1];%parity check matrix
simu = 0; %number of simulations
error = 0;%number of errors
while true
    u = floor(rand(1,2)+0.5);%info bits
    %bits to tansmit in {-1,+1}
    c = snr*(2*mod(u*G,2)-1);
    %received bits in{-1,+1}
    cr = c+mvnrnd(zeros(1,5),eye(5));
    cdecoded = decode(cr,H);
    if 2*cdecoded-1 == c/snr
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
function [cdecoded] = decode(cr,H)
ur = zeros(3,5);
lambda = 2*cr;
for l = 1:3
    utemp = ur;
    for m = 1:3
          multiline = tanh((-lambda + utemp(m,:))/2).*H(m,:);
        for n = 1:5
            if H(m,n) == 1
                temp = multiline;
                temp(n) = 0;
                multi = nonzeros(temp);
                ur(m, n) = -2*atanh(prod(multi));
            end
        end
    end
    lambda = 2*cr + H'*u;
end
cdecoded = (sign(lambda)+1)/2;
end