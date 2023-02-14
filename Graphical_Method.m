x1=0:.1:15;

y1=(8-2*x1)/4;

X_intercept1=[x1(find(y1==0)), y1(find(y1==0))];
Y_intercept1=[0, y1(find(x1==0))];

y2=(15-3*x1)/5;

X_intercept2=[x1(find(y2==0)), y2(find(y2==0))];
Y_intercept2=[0, y2(find(x1==0))];

plot(x1,y1,'-',x1,y2,'-');
grid on;

line([0,0], ylim, 'Color', 'b', 'LineWidth', 1.5,'HandleVisibility','off');
line(xlim, [0,0], 'Color', 'c', 'LineWidth', 1.5,'HandleVisibility','off');
legend('2x1+4x2<=8','3x1+5x2>=15');

xlim([0 inf]);
ylim([0 inf]);

intersection=[x1(find(y1==y2)),y1(find(y1==y2))];

hold on
plot(X_intercept1(1),X_intercept1(2),'-r*','HandleVisibility','off');
plot(X_intercept2(1),X_intercept2(2),'-r*','HandleVisibility','off');
plot(Y_intercept1(1),Y_intercept1(2),'-r*','HandleVisibility','off');
plot(Y_intercept2(1),Y_intercept2(2),'-r*','HandleVisibility','off');
plot(intersection(1),intersection(2),'-r*','HandleVisibility','off');

extremePoints=[X_intercept1;Y_intercept1;X_intercept2;Y_intercept2;intersection];
feasiblePoints=[];

disp(extremePoints);

for i=1:5
    if((2*extremePoints(i,1)+4*extremePoints(i,2)<=8)&&(3*extremePoints(i,1)+5*extremePoints(i,2)<=15)&&(extremePoints(i,1)>=0)&&(extremePoints(i,2)>=0))
        feasiblePoints=[feasiblePoints;extremePoints(i,:)];
    end
end

if ~isempty(feasiblePoints)
    disp(feasiblePoints);

    z=@(x,y)(3*x+2*y);
    maxz=0;
    maxx=0;
    maxy=0;

    for i=1:length(feasiblePoints)
        if z(feasiblePoints(i,1),feasiblePoints(i,2))>maxz
            maxz=z(feasiblePoints(i,1),feasiblePoints(i,2));
            maxx=feasiblePoints(i,1);
            maxy=feasiblePoints(i,2);
        end
    end

    disp([maxx maxy]);

else
    disp("Unfeasible problem");
end
