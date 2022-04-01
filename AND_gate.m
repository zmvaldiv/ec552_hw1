function [outputON,outputOFF,score,bestgate_index] = AND_gate(input1,input2,ymin,ymax,K,n,oper_inputs,gatenum)
% AND gate,
% input = [LOW, HIGH];
% truth table : 0 0 0 1
% output = [min(on_state),max(off_state)];
% all outputs correspond to the gate with the MAX score 

x = [input1(1)+input2(1), input1(1)+input2(2), input1(2)+input2(1), input1(2)+input2(2)];

%%%%%% do operations here %%%%%%%
%stretch operator, ymax/min copied in each colum to fit dimensions
if oper_inputs.stretch(gatenum) == 1
    if ~isequal(size(ymax,2),size(x,2))
        ymax = [ymax' ymax' ymax' ymax'];
        ymin = [ymin' ymin' ymin' ymin'];
    end

    disp('Ymax and Ymin are copied in each column to test each X value');

    ymax = ymax.*x;
    ymin = ymin./x;

    disp('Stretch operation was perfomed:');
    disp('Ymax is multiplied by each X value');
    disp('Ymin is divided by each X value');
end

%increase operator, n changes dimensions when multiplied
if oper_inputs.increase(gatenum) == 1
    n = n*x;
    disp('The slope was increased:');
    disp('n is multiplied by each X value');    
end

%decrease operator, n changes dimensions when multiplied
if oper_inputs.decrease(gatenum) == 1
    n = n/x;
    disp('The slope was decreased:');
    disp('n is divided by each X value');
end

%strong promotor operator, ymax/min copied in each colum to fit dimensions
if oper_inputs.strong_prom(gatenum) == 1
    if ~isequal(size(ymax,2),size(x,2))
        ymax = [ymax' ymax' ymax' ymax'];
        ymin = [ymin' ymin' ymin' ymin'];
    end
    
    disp('Ymax and Ymin are copied in each column to test each X value');

    ymax = ymax.*x;
    ymin = ymin.*x;
    
    disp('Stronger promotor operation was perfomed:');
    disp('Ymax is multiplied by each X value');
    disp('Ymin is multiplied by each X value');
end

%weak promotor operator, ymax/min copied in each colum to fit dimensions
if oper_inputs.weak_prom(gatenum) == 1
    if ~isequal(size(ymax,2),size(x,2))
        ymax = [ymax' ymax' ymax' ymax'];
        ymin = [ymin' ymin' ymin' ymin'];
    end

    disp('Ymax and Ymin are copied in each column to test each X value');

    ymax = ymax./x;
    ymin = ymin./x;
    disp('Weaker promotor operation was perfomed:');
    disp('Ymax is divided by each X value');
    disp('Ymin is divided by each X value');
end
%strong rbs operator, K changes dimensions when multiplied
if oper_inputs.strong_rbs(gatenum) == 1
    K = K/x;
    disp('Strong RBS operation was perfomed:');
    disp('K is divided by each X value');
end

%weak rbs operator, K changes dimensions when multiplied
if oper_inputs.weak_rbs(gatenum) == 1
    K = K*x;
    disp('Weak RBS operation was perfomed:');
    disp('K is multiplied by each X value');
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
    y = ymin(i,j)+(ymax(i,j)-ymin(i,j))./(1.0+(x(j)./K(i,j)).^n(i,j));
    outputON_all(i,j) = y(:,4);
    outputOFF_all(i,j) = max(max(y(:,1:3)));
    score_all(i,j) = log10(outputON_all(i,j)/outputOFF_all(i,j));
end
end
bestgate_index = find(score_all == max(max(score_all)));
score = score_all(bestgate_index);
outputON = outputON_all(bestgate_index);
outputOFF = outputOFF_all(bestgate_index);

disp('The output Y is found for each X. The score is found for each AND gate.'); 
disp('The score for each gate is found. The highest scoring gate is found.');
disp('The highest scoring gate, the outputs, and the score are recorded.');
end 