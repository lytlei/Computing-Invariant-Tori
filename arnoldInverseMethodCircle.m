% Inverse Method of Iteration of Fattened Arnol'd Map
% Author: Leon Lei
% Date: 21/02/23

% Parameters
alpha = 0.1;
beta = 0.3;
epsilon = 0.1;

% Set up continuous closed curve (DO NOT CHANGE)
tMin = 0;
tMax = 1;

% Set up initial curve (H_0)
curveX = chebfun('t', [tMin,tMax]);
curveY = chebfun('0', [tMin,tMax]);

% Map
f1 = @(x,y) (x+alpha/(2*pi)+epsilon/(2*pi)*(y+sin(2*pi*x))); % Maps x_{n} to x_{n+1}
f2 = @(x,y) (beta * (y+sin(2*pi*x))); % Maps y_{n} to y_{n+1}
inverseX = @(x,y) x-alpha/(2*pi) - epsilon*y/(2*pi*beta); % Maps x_{n} to x_{n-1}
inverseY = @(x,y) y/beta - sin(2*pi*(x-alpha/(2*pi)-epsilon*y/(2*pi*beta))); % Maps y_{n} to y_{n-1}

tic

iterationNumber = 0;

while(1)
    % Plotting Curve
    hold off
    plot3(cos(2*pi*curveX), sin(2*pi*curveX), curveY, 'linewidth', 1, 'b');
    hold on
    axis([-1 1 -1 1 -1.5 1.5])
    grid on
    
    % Labels
    xlabel('$\cos(x)$','FontSize',18,'interpreter','latex')
    ylabel('$\sin(x)$','FontSize',18,'interpreter','latex')
    zlabel('$y$','FontSize',18,'rotation',0,'interpreter','latex')
    title(['Iteration Number: ', num2str(iterationNumber)],'FontSize',18,'interpreter','latex')

    % Increase pause time to watch iterations
    pause(0)
    
    % Compute next curve
    tempX = chebfun(inverseX(curveX, curveY),[tMin,tMax]);
    tempY = chebfun(f2(tempX,compose(mod(tempX, 1),curveY)),[tMin,tMax]);

    % Stopping condition for when the torus is accurate to 10^-6 of invariant
    % tous
    if (norm(curveY-tempY) < 10^-6)
        curveY = tempY;
        break
    end

    curveY = tempY;
    iterationNumber = iterationNumber + 1;

    toc
end

toc