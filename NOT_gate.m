function [outputON,outputOFF,score] = NOT_gate(input,ymin,ymax,K,n)
% OR gate,
% input = [LOW, HIGH];
% truth table : 1 0
% output = [min(on_state),max(off_state];
% all outputs correspond to the gate with the MAX score 
x = input;
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
for i=1:length(ymin)
    outputON_all(i) = ymin(i)+(ymax(i)-ymin(i))/(1.0+(x(1)/K(i))^n(i));
    outputOFF_all(i) = ymin(i)+(ymax(i)-ymin(i))/(1.0+(input(2)/K(i))^n(i));
    score_all(i) = log10(outputON_all(i)/outputOFF_all(i));
end
gate_index = find(score_all == max(score_all));
score = score_all(gate_index);
outputON = outputON_all(gate_index);
outputOFF = outputOFF_all(gate_index);
end 