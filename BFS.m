noOfConstraints=input("No. of constraints:");
noOfVariables=input("No. of variables(including slack):");
b=input("Rhs matrix:");
a=input("Coefficient matrix(including slack):");
c=input("Cost vector(including slack):");
pair=nchoosek(1:noOfVariables,noOfConstraints);
basicFeasibleSolutions=[];
notBasicFeasible=[];
flag=true;
for i=1:length(pair)
    currentSolution=zeros(length(a),1);
    B=a(:,pair(i,:));
    if det(B)==0
        fprintf("Not a Basic Solution\n")
    else 
        x=B\b;
        if all(x>=0 & x~=-Inf & x~=Inf)
            currentSolution(pair(i,:))=x;
            basicFeasibleSolutions=[basicFeasibleSolutions currentSolution];
            if any(x==0)
                flag=false;
            end
        else
            currentSolution(pair(i,:))=x;
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
% z=c*basicFeasibleSolutions;
% a=max(z);
% for i=1:length(z)
%     if z(i)==a
%         k=i;
%         break
%     end
% end
% disp(basicFeasibleSolutions(:,k));
end