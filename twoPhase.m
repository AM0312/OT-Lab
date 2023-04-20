A=input("Enter the coefficient matrix including slack and artificial variable at last");
b=input("Enter the r.h.s matrix");
Z=input("Enter the cost vector excluding slack");
cc=[];
Z=[Z 0];
cc2=[];
cc=input("Enter the cost for first phase");
for i=1:ar
    cc2=[cc2 0];
end
a=[a b];
[ar,ac]=size(a);
c=[];
for i=1:ac-ar-1
    c=[c 0];
end
c=[c cc];
c=[c 0];
z=zeros(1,length(a));
for i=1:ac
    z(i)=cc*(a(:,i))-c(i);
end
[zmin,zind]=min(z(1:ac-1));
while zmin<0
    q=a(:,ac)./a(:,zind);
    w=Inf;
    for i=1:ar
        if q(i)>=0
            if q(i)<w
                w=q(i);
                index=i;
            end
        end
    end
    cc(index)=0;
    cc2(index)=Z(zind);
    div=a(index,zind);
    for i=1:ac
        a(index,i)=a(index,i)/div;
    end
    for i=1:ar
        if i~=index
            a(i,:)=a(i,:)-a(i,zind)*a(index,:);
        end
    end
    for i=1:ac
        z(i)=cc*(a(:,i))-c(i);
    end
    [zmin,zind]=min(z(1:ac-1));
end
for i=1:ar
    a(:,ac-1)=[];
    [ar,ac]=size(a);
end
flag=true;
for i=1:length(cc)
    if cc(i)~=0
        flag=false;
    end
end
for i=1:ac
    z(i)=cc2*(a(:,i))-Z(i);
end
[zmin,zind]=min(z(1:ac-1));
if flag==true
    while zmin<0
    q=a(:,ac)./a(:,zind);
    w=Inf;
    for i=1:ar
        if q(i)>=0
            if q(i)<w
                w=q(i);
                index=i;
            end
        end
    end
    cc2(index)=Z(zind);
    div=a(index,zind);
    for i=1:ac
        a(index,i)=a(index,i)/div;
    end
    for i=1:ar
        if i~=index
            a(i,:)=a(i,:)-a(i,zind)*a(index,:);
        end
    end
    for i=1:ac
        z(i)=cc2*(a(:,i))-Z(i);
    end
    [zmin,zind]=min(z(1:ac-1));
    end
else
    fprintf("Infeasible")
end