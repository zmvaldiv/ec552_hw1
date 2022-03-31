function [outputON,outputOFF,score] = OR_gate(input1,input2,ymin,ymax,K,n,oper_inputs)
% OR gate,
% input = [LOW, HIGH];
% truth table : 1 0 0 0
% output = [min(on_state),max(off_state];
% all outputs correspond to the gate with the MAX score 

x = [input1(1)+input2(1), input1(1)+input2(2), input1(2)+input2(1), input1(2)+input2(2)];
%%%%%% do operations here %%%%%%%
if oper_inputs.stretch == 1
n = n*x;
end

if oper_inputs.increase == 1
    n = n*x;
end
if oper_inputs.strong_prom == 1
    ymax = ymax*x;
    ymin = ymin*x;
end

if oper_inputs.weak_prom == 1
    ymax = ymax/x;
    ymin = ymin/x;
end
if oper_inputs.strong_rbs == 1
    K = K/x;
end
if oper_inputs.weak_rbs == 1
    K = K*x;
end
%%%%%%%%%%

for j = 1:length(x)
    if size(ymin)~=size(K)
        K=K';
        K = [K K K K];
    end
    if size(ymin)~=size(n)
        n = n';
        n = [n n n n];
    end
for i=1:length(ymin)
    y = ymin(i,j)+(ymax(i,j)-ymin(i,j))./(1.0+(x./K(i,j)).^n(i,j));
    outputON_all(i,j) = y(:,1);
    outputOFF_all(i,j) = max(max(y(:,2:4)));
    score_all(i,j) = log10(outputON_all(i,j)/outputOFF_all(i,j));
end
end
gate_index = find(score_all == max(max(score_all)));
score = score_all(gate_index);
outputON = outputON_all(gate_index);
outputOFF = outputOFF_all(gate_index);
end 
