noOfConstraints=input("No. of constraints:");
b=input("Rhs column vector:");
A=input("Coefficient matrix:");
Z=input("Cost vector:");
A=[A eye(noOfConstraints) b];
Z=[Z zeros(noOfConstraints+1)];

cv=zeros(1,noOfConstraints);
zc=zeros(1,length(A));
[ARow,ACol]=size(A);
for i=1:length(zc)
    zc(i)=cv*A(:,i)-Z(i);
end
[zmin,zind]=min(zc(1:ACol-1));
while zmin<0
    q=A(:,ACol)./A(:,zind);
    w=Inf;
    for i=1:noOfConstraints
        if q(i)>=0
            if q(i)<w
                w=q(i);
                index=i;
            end
        end
    end
    cv(index)=Z(zind);
    multiplier=A(index,zind);
    for i=1:ACol
        A(index,i)=A(index,i)/multiplier;
    end
    for i=1:ARow
        if i~=index
            A(i,:)=A(i,:)-A(i,zind)*A(index,:);
        end
    end
    for i=1:ACol
        zc(i)=cv*(A(:,i))-Z(i);
    end
    [zmin,zind]=min(zc(1:ACol-1));
end
disp(A);
disp(z);