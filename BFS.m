noOfConstraints=input("No. of constraints:");
noOfVariables=input("No. of variables(including slack):");
b=input("Rhs matrix:");
a=input("Coefficient matrix(including slack):");
c=input("Cost vector(including slack):");
combinations=nchoosek(1:noOfVariables,noOfConstraints);
basicFeasibleSolutions=[];
notBasicFeasible=[];
flag=true;
for i=1:length(combinations)
    currentSolution=zeros(length(a),1);
    B=a(:,combinations(i,:));
    if det(B)==0
        fprintf("Not a Basic Solution\n")
    else 
        x=B\b;
        if all(x>=0 & x~=-Inf & x~=Inf)
            currentSolution(combinations(i,:))=x;
            basicFeasibleSolutions=[basicFeasibleSolutions currentSolution];
            if any(x==0)
                flag=false;
            end
        else
            currentSolution(combinations(i,:))=x;
            notBasicFeasible=[notBasicFeasible currentSolution];
        end
    end
end
fprintf("Basic Infeasible Solutions:\n");
disp(notBasicFeasible);
if ~isempty(basicFeasibleSolutions)
    fprintf("Basic Feasible Solutions:\n")
    disp(basicFeasibleSolutions);
    if ~flag
        fprintf("Degenerate B.F.S.\n")
    else
        fprintf("Non-Degenerate B.F.S.\n")
    end
    disp("Optimal Solution:\n")
    z=c*basicFeasibleSolutions;
    [maxz,max_ind]=max(z);
    disp(basicFeasibleSolutions(:,max_ind));
end