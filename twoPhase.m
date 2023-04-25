A=input("Enter the coefficient matrix including slack,surplus and artificial variables:");
b=input("Enter rhs in column form:");
A=[A b];
Z1=input("Enter the cost vector including slack and artificial:");
Z1=[Z1 0];
cc2=[];
[ARows,ACols]=size(A);
c=input("Enter the cost for first phase with all variables:");
c=[c 0];
bv=input("Enter the cost of basic variable for first phase:");
for i=1:ARows
    cc2=[cc2 0];
end
ZjCj=zeros(1,length(A));
for i=1:ACols
    ZjCj(i)=bv*(A(:,i))-c(i);
end
[zmin,zind]=min(ZjCj(1:ACols-1));
while zmin<0
    q=A(:,ACols)./A(:,zind);
    w=Inf;
    for i=1:ARows
        if q(i)>=0
            if q(i)<w
                w=q(i);
                index=i;
            end
        end
    end
    bv(index)=c(zind);
    cc2(index)=Z1(zind);
    A(index,:)=A(index,:)/A(index,zind);
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
for i=1:ARows
    A(:,ACols-1)=[];
    ZjCj(length(ZjCj))=[];
    [ARows,ACols]=size(A);
end
flag=true;
for i=1:length(bv)
    if bv(i)~=0
        flag=false;
    end
end
c2=input("Enter the cost vector for second phase that includes slack and artifical variables:");
c2=[c2 0];
for i=1:ACols
    ZjCj(i)=cc2*(A(:,i))-c2(i);
end
[zmin,zind]=min(ZjCj(1:ACols-1));
if flag==true
    while zmin<0
        q=A(:,ACols)./A(:,zind);
        w=Inf;
        for i=1:ARows
            if q(i)>=0
                if q(i)<w
                    w=q(i);
                    index=i;
                end
            end
        end
        cc2(index)=c2(zind);
        A(index,:)=A(index,:)/A(index,zind);
        for i=1:ARows
            if i~=index
                A(i,:)=A(i,:)-A(i,zind)*A(index,:);
            end
        end
        for i=1:ACols
            ZjCj(i)=cc2*(A(:,i))-c2(i);
        end
        [zmin,zind]=min(ZjCj(1:ACols-1));
    end
else
    fprintf("Infeasible")
end
disp(A);
disp(ZjCj);