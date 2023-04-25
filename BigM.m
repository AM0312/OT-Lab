A=input("Enter the coefficient matrix with slack and artificial variable");
b=input("Enter rhs in column form:");
A=[A b];
Z=input("Enter the cost vector including slack and artificial variable");
Z=[Z 0];
bv=input("Enter the cost of starting basic variables");
[ARows,ACols]=size(A);
ZjCj=zeros(1,ACols);
for i=1:ACols
    ZjCj(i)=bv*A(:,i)-Z(i);
end
ZjCj=zeros(1,ACols);
for i=1:ACols
    ZjCj(i)=bv*(A(:,i))-Z(i);
end
[zmin,zind]=min(ZjCj(1:ACols-1));
j=1;
while zmin<0
    q=A(:,ACols)./A(:,zind);
    w=Inf;
    for i=1:n
        if q(i)>=0
            if q(i)<w
                w=q(i);
                index=i;
            end
        end
    end
    bv(index)=Z(zind);
    div=A(index,zind);
    for i=1:ACols
        A(index,i)=A(index,i)/div;
    end
    for i=1:ARows
        if i~=index
            A(i,:)=A(i,:)-A(i,zind)*A(index,:);
        end
    end
    for i=1:ACols
        ZjCj(i)=bv*(A(:,i))-Z(i);
    end
    [zmin,zind]=min(ZjCj(1:ACols-1));
end
disp(A);
disp(ZjCj);