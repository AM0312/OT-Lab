A=input("Enter the coefficient matrix with slack and artificial variable:");
b=input("Enter rhs in column form:");
A=[A b];
c=input("Enter the cost vector including slack and artificial variable:");
c=[c 0];
bv=input("Enter the cost of starting bfs:");
[ARows,ACols]=size(A);
ZjCj=zeros(1,ACols);
for i=1:ACols
    ZjCj(i)=bv*A(:,i)-c(i);
end
[zmin,zind]=min(ZjCj(1:ACols-1));
while zmin<0
    ratio=A(:,ACols)./A(:,zind);
    w=Inf;
    for i=1:length(bv)
        if ratio(i)>=0
            if ratio(i)<w
                w=ratio(i);
                index=i;
            end
        end
    end
    bv(index)=c(zind);
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
        ZjCj(i)=bv*(A(:,i))-c(i);
    end
    [zmin,zind]=min(ZjCj(1:ACols-1));
end
disp(A);
disp(ZjCj);
disp(bv);