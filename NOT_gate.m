function [outputON,outputOFF,score,bestgate_index] = NOT_gate(input,ymin,ymax,K,n,oper_inputs,gatenum)
% OR gate,
% input = [LOW, HIGH];
% truth table : 1 0
% output = [min(on_state),max(off_state];
% all outputs correspond to the gate with the MAX score 
x = input;
%%%%%% do operations here %%%%%%%
%stretch operator, ymax/min copied in each colum to fit dimensions
if oper_inputs.stretch(gatenum) == 1
    ymax = [ymax' ymax'];
    ymin = [ymin' ymin'];

    disp('Ymax and Ymin are copied in each column to test each X value');

    ymax = ymax.*x;
    ymin = ymin./x;

    disp('Stretch operation was perfomed:');
    disp('Ymax is multiplied by each X value');
    disp('Ymin is divided by each X value');
end

%increase operator, n changes dimensions when multiplied
if oper_inputs.increase(gatenum) == 1
    n = [n' n'];
    n = n.*x;
    disp('The slope was increased:');
    disp('n is multiplied by each X value');    
end

%decrease operator, n changes dimensions when multiplied
if oper_inputs.decrease(gatenum) == 1
    n = [n' n'];
    n = n./x;
    disp('The slope was decreased:');
    disp('n is divided by each X value');
end

%strong promotor operator, ymax/min copied in each colum to fit dimensions
if oper_inputs.strong_prom(gatenum) == 1
    ymax = [ymax' ymax'];
    ymin = [ymin' ymin'];
    
    disp('Ymax and Ymin are copied in each column to test each X value');

    ymax = ymax.*x;
    ymin = ymin.*x;
    
    disp('Stronger promotor operation was perfomed:');
    disp('Ymax is multiplied by each X value');
    disp('Ymin is multiplied by each X value');
end

%weak promotor operator, ymax/min copied in each colum to fit dimensions
if oper_inputs.weak_prom(gatenum) == 1
    ymax = [ymax' ymax'];
    ymin = [ymin' ymin'];

    disp('Ymax and Ymin are copied in each column to test each X value');

    ymax = ymax./x;
    ymin = ymin./x;
    disp('Weaker promotor operation was perfomed:');
    disp('Ymax is divided by each X value');
    disp('Ymin is divided by each X value');
end
%strong rbs operator, K changes dimensions when multiplied
if oper_inputs.strong_rbs(gatenum) == 1
    K = [K' K'];
    K = K./x;
    disp('Strong RBS operation was perfomed:');
    disp('K is divided by each X value');
end

%weak rbs operator, K changes dimensions when multiplied
if oper_inputs.weak_rbs(gatenum) == 1
    K = [K' K'];
    K = K.*x;
    disp('Weak RBS operation was perfomed:');
    disp('K is multiplied by each X value');
end
%%%%%%%%%%
for i=1:length(ymin)
    outputON_all(i) = ymin(i,1)+(ymax(i,1)-ymin(i,1))/(1.0+(x(1)/K(i,1))^n(i,1));
    outputOFF_all(i) = ymin(i,2)+(ymax(i,2)-ymin(i,2))/(1.0+(x(2)/K(i,2))^n(i,2));
    score_all(i) = log10(outputON_all(i)/outputOFF_all(i));
end
bestgate_index = find(score_all == max(score_all));
score = score_all(bestgate_index);
outputON = outputON_all(bestgate_index);
outputOFF = outputOFF_all(bestgate_index);

disp('The output Y is found for each X. The score is found for each NOT gate.'); 
disp('The score for each gate is found. The highest scoring gate is found.');
disp('The highest scoring gate, the outputs, and the score are recorded.');
end 