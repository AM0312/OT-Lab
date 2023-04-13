clc;
clear;
% cost=input("Enter cost matrix:");
% A=input("Enter supply:");
% B=input("Enter demand:");
cost = [2 10 4 5;6 12 8 11;3 9 5 7];
A = [12;25;20];
B = [25;10;15;5];
if sum(A)==sum(B)
    fprintf('Balanced \n');
else
    fprintf('Unbalanced \n');
    if sum(A) < sum(B)
        cost(end+1,:) = zeros(1,size(B,2));
        A(end+1)=sum(B)-sum(A);
    else 
        cost(:,end+1) = zeros(1,size(A,2));
        B(end+1) = sum(A)-sum(B);
    end
    fprintf("New cost matrix:\n");
    disp(cost);
    fprintf("New demand:\n");
    disp(B');
    fprintf("New supply\n");
    disp(A);
end
Icost = cost;
X = zeros(size(cost));
[m,n] = size(cost);
BFS = m+n-1;

for i=1:m
    for j=1:n
        minCost = min(cost(:));
        [rowIndex,colIndex] = find(minCost==cost);
        x11 = min(A(rowIndex),B(colIndex));
        [alloc,index] = max(x11);
        ii = rowIndex(index);
        jj = colIndex(index);
        y11 = min(A(ii),B(jj));
        X(ii,jj) = y11;
        A(ii) = A(ii) - y11;
        B(jj) = B(jj) - y11;
        cost(ii,jj) = inf;
    end
end
fprintf('Initial BFS = \n');
IB = array2table(X);
disp(IB);
TotalBFS = length(nonzeros(X));
if TotalBFS == BFS
    fprintf('Non-degenerate BFS \n');
else
    fprintf('Degenerate \n');
end
InitialCost = sum(sum(Icost.*X));
fprintf('Initial BFS cost = %d\n',InitialCost);


