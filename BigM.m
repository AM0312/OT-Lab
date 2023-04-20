a=input("Enter the coefficient matrix with slack and artificial variable and r.h.s");
c=input("Enter the cost vector includin slack and artificial variable and solution cost(0)at the end as well");
cc=input("Enter the cost of starting basic variables");
[ar,ac]=size(a);
z=zeros(1,ac);
for i=1:ac
    z(i)=cc*a(:,i)-c(i);
end
z=zeros(1,ac);
for i=1:ac
    z(i)=cc*(a(:,i))-c(i);
end
[zmin,zind]=min(z(1:ac-1));
j=1;
while zmin<0
    q=a(:,ac)./a(:,zind);
    w=Inf;
    for i=1:n
        if q(i)>=0
            if q(i)<w
                w=q(i);
                index=i;
            end
        end
    end
    cc(index)=c(zind);
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
disp(a);
disp(z);
disp(cc);