noOfVariables=input("Enter no of variables:");
noOfConstraints=input("Enter no of constraints:");
A=input("Enter coefficient matrix:");
b=input("Enter solution matrix (Column form):");
Z=input("Enter cost vector:");

A=[A eye(noOfConstraints,noOfConstraints)];
Z=[Z zeros(1,noOfConstraints) 0];

% disp(A);
% disp(Z);

mat=[A b];
bv=(noOfVariables+1):size(mat,2)-1;

Zrow=Z(bv)*mat-Z;
ZC=[Zrow;mat];

simplexTable=array2table(ZC);
simplexTable.Properties.VariableNames(1:size(ZC,2))={'x1','x2','s1','s2','Sol'};

run=true;

while run
    if any(Zrow<0)
        disp("Old basic Variables:");
        disp(bv);
        ZC=Zrow(1:end-1);
        [enterCol,pivotCol]=min(ZC);
        sol=mat(:,end);
        col=mat(:,pivotCol);
    end
end