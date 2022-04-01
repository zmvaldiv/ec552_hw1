function [outputON,outputOFF,score,bestgate_index] = OR_gate(input1,input2,ymax,ymin,n,K,oper_inputs,gatenum)
% OR gate,
% input = [LOW, HIGH];
% truth table : 1 0 0 0
% output = [min(on_state),max(off_state];
% all outputs correspond to the gate with the MAX score 

x = [input1(1)+input2(1), input1(1)+input2(2), input1(2)+input2(1), input1(2)+input2(2)];

disp('-------------------------')
disp(' ')
disp(['Gate:' num2str(gatenum)]);
%%%%%% do operations here %%%%%%%
if ~isequal(size(ymax,2),size(x,2))
        ymax = [ymax' ymax' ymax' ymax'];
        ymin = [ymin' ymin' ymin' ymin'];
end
disp('->Ymax and Ymin are copied in each column to test each X value.');
if size(ymin)~=size(K)
        K=K';
        K = [K K K K];
end
disp('->K is copied in each column to test each X value.');
if size(ymin)~=size(n)
    n = n';
    n = [n n n n];
end
disp('->n is copied in each column to test each X value.');
disp('All variable have the same dimensions.');
%stretch operator, ymax/min copied in each colum to fit dimensions
if oper_inputs.stretch(gatenum) == 1
    ymax = ymax.*x;
    ymin = ymin./x;

    disp(' ')
    disp('Stretch operation was perfomed:');
    disp('->Ymax is multiplied by each X value');
    disp('->Ymin is divided by each X value');
end

%increase operator, n copied in each colum to fit dimensions
if oper_inputs.increase(gatenum) == 1
    n = n.*x;
    
    disp(' ')
    disp('The slope was increased:');
    disp('->n is multiplied by each X value');    
end

%decrease operator, n copied in each colum to fit dimensions
if oper_inputs.decrease(gatenum) == 1
    n = n./x;
    
    disp(' ')
    disp('The slope was decreased:');
    disp('->n is divided by each X value');
end

%strong promotor operator, ymax/min copied in each colum to fit dimensions
if oper_inputs.strong_prom(gatenum) == 1
    ymax = ymax.*x;
    ymin = ymin.*x;
    
    disp(' ')
    disp('Stronger promotor operation was perfomed:');
    disp('->Ymax is multiplied by each X value');
    disp('->Ymin is multiplied by each X value');
end

%weak promotor operator, ymax/min copied in each colum to fit dimensions
if oper_inputs.weak_prom(gatenum) == 1
    ymax = ymax./x;
    ymin = ymin./x;
    
    disp(' ')
    disp('Weaker promotor operation was perfomed:');
    disp('->Ymax is divided by each X value');
    disp('->Ymin is divided by each X value');
end
%strong rbs operator, K copied in each colum to fit dimensions
if oper_inputs.strong_rbs(gatenum) == 1
    K = K./x;
    
    disp(' ')
    disp('Strong RBS operation was perfomed:');
    disp('->K is divided by each X value');
end

%weak rbs operator, K copied in each colum to fit dimensions
if oper_inputs.weak_rbs(gatenum) == 1
    K = K.*x;
    
    disp(' ')
    disp('Weak RBS operation was perfomed:');
    disp('->K is multiplied by each X value');
end
%%%%%%%%%%
% for loop that sees which gate is the best
for j = 1:length(x)   
    for i=1:length(ymin)
        y = ymin(i,j)+(ymax(i,j)-ymin(i,j))./(1.0+(x(j)./K(i,j)).^n(i,j));
        if j==1
            outputON_all(i) = y;
        else
        %outputOFF_all(i,j) = max(max(y(:,1:3)));
            outputOFF_all(i,j) = y;
        end 
    end
end

outputOFF_max = max(outputOFF_all');
score_all = log10(outputON_all./outputOFF_max);
bestgate_index = find(score_all == max(max(score_all)));
bestgate_index = bestgate_index(1);
score = score_all(bestgate_index(1));
outputON = outputON_all(bestgate_index(1));
outputOFF = outputOFF_all(bestgate_index(1));

disp(' ')
disp('->The output Y is found for each X.')
disp('->The score is found for each OR gate in the library.'); 
disp('->The score for each gate is found. The highest scoring gate is found.');
disp('->The highest scoring gate, the outputs, and the score are recorded.');
disp('Calculations complete. Gate optimized.')
disp('-------------------------')
end 
