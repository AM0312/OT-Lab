clc;
clear;
f=@(x)(x^2-2*x);
L=input("Enter leftmost interval value:");
R=input("Enter rightmost interval value:");
n=input("Enter number of iterations:");

Fib=[1 1];
for i=3:n+1
    Fib=[Fib Fib(i-1)+Fib(i-2)];
end
for k=1:n
    x2=R-Fib(n+1-k)*(R-L)/Fib(n+2-k);
    x1=L+R-x2;
    if f(x1)>f(x2)
        R=x2;
    elseif f(x1)<f(x2)
        L=x1;
    else
        if(min(abs(x1),abs(L)))==abs(L)
            R=x2;
        else
            L=x1;
        end
    end
end

fprintf("Final Answer obtained = %f",(L+R)/2);