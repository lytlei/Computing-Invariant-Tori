% Brute Force Iteration of Fattened Arnol'd Map in R^2
% Author: Leon Lei
% Date: 21/02/23

% Parameters
alpha = 0.1;
beta = 0.3;
epsilon = 0;

% Set up curve segment (tMin < tMax)
% tMin = 0, tMax = 1 for continuous closed curve.
% For a short curve segment to observe dynamics, take for example tMin = 0.1, tMax = 0.2
tMin = 0; % Time start, 0 to 1
tMax = 1; % Time end, 0 to 1

% Set up initial curve (H_0)
curveX = chebfun('t', [tMin,tMax]);
curveY = chebfun('0', [tMin,tMax]);

% Map
f1 = @(x,y) (x+alpha/(2*pi)+epsilon/(2*pi)*(y+sin(2*pi*x))); % Maps x_{n} to x_{n+1}
f2 = @(x,y) (beta * (y+sin(2*pi*x))); % Maps y_{n} to y_{n+1}

tic

for i = 1 : 300
    % Stopping condition for when the curve is too complicated
    if (length(curveX) > 65000 || length(curveY) > 65000)
        break
    end

    % Plotting Curve
    hold off
    plot(curveX, curveY);
    hold on
    axis([0 1 -1 1])

    % Labels
    xlabel('$x$','FontSize',18,'interpreter','latex');
    ylabel('$y$','FontSize',18,'rotation',0,'interpreter','latex');
    title(['Iteration Number: ', num2str(i)],'FontSize',18,'interpreter','latex')

    % Increase pause time to watch iterations
    pause(0)

    % Compute next curve
    tempX = mod(f1(curveX, curveY), 1);
    tempY = f2(curveX,curveY);

    curveX = tempX;
    curveY = tempY;

    toc
end
