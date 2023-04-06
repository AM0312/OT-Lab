Z=[-3 -5]; %Enter cost
A=[-1 -3;-1 -1]; %Enter coefficient matrix
b=[-3;-2]; %Enter rhs column vector
variables=["x1","x2","s1","s2","Sol"];
s=eye(size(A,1));
Z=[Z zeros(1,size(b,1)) 0];
A=[A s b]; 

BV=[];

for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            BV=[BV i];
        end
    end
end

fprintf("Basic Variables:\n");
disp(variables(BV));

run=true;
while run
    ZjCj=Z(BV)*A-Z;
    table=[ZjCj;A];
    simplexTable=array2table(table);
    simplexTable.Properties.VariableNames(1:size(simplexTable,2))=variables;
    disp(simplexTable);
    if any(A(:,end)<0)
        fprintf("Infeasible BFS.\n");
        [leavingVal,pivotRow]=min(A(:,end));
        fprintf("Leaving Row=%d \n",pivotRow);
        Row=A(pivotRow,1:end-1);
        Zrow=ZjCj(:,1:end-1);
        for i=1:size(Row,2)
            if Row(i)<0
                ratio(i)=abs(Zrow(i)./Row(i));
            else
                ratio(i)=inf;
            end
        end
        [minRatio,pivotCol]=min(ratio);
        BV(pivotRow)=pivotCol;
        fprintf("New Basic Variables:\n");
        disp(variables(BV));
        pivotVal=A(pivotRow,pivotCol);
        A(pivotRow,:)=A(pivotRow,:)./pivotVal;
        for i=1:size(A,1)
            if i~=pivotRow
                A(i,:)=A(i,:)-A(i,pivotCol).*A(pivotRow,:);
            end
            ZjCj=ZjCj-ZjCj(pivotCol).*A(pivotRow,:);
        end
    else
        run=false;
        fprintf("Feasible BFS.\n");
    end
end