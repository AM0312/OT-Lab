clc;
clear;
% cost=input("Enter cost matrix:");
% supply=input("Enter supply:");
% demand=input("Enter demand:");
if sum(supply)==sum(demand)
    fprintf('Balanced \n');
else
    fprintf('Unbalanced \n');
    if sum(supply) < sum(demand)
        cost(end+1,:) = zeros(1,size(demand,2));
        supply(end+1)=sum(demand)-sum(supply);
    else 
        cost(:,end+1) = zeros(1,size(supply,2));
        demand(end+1) = sum(supply)-sum(demand);
    end
    fprintf("New cost matrix:\n");
    disp(cost);
    fprintf("New demand:\n");
    disp(demand');
    fprintf("New supply\n");
    disp(supply);
end
Icost = cost;
X = zeros(size(cost));
[m,n] = size(cost);
BFS = m+n-1;

for i=1:m
    for j=1:n
        minCost = min(cost(:));
        [rowIndex,colIndex] = find(minCost==cost);
        x11 = min(supply(rowIndex),demand(colIndex));
        [alloc,index] = max(x11);
        ii = rowIndex(index);
        jj = colIndex(index);
        y11 = min(supply(ii),demand(jj));
        X(ii,jj) = y11;
        supply(ii) = supply(ii) - y11;
        demand(jj) = demand(jj) - y11;
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


