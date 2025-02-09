clc; clear; close all;

% Define parameters
a = 1;          % Wave speed (m/s)
L = 1;          % Length of domain
Nx = 100;       % Number of spatial points
dx = L/Nx;      % Spatial step
co_values = [1, 0.5, 0.25];
Nt = 10;       % Number of time steps

% Define spatial grid
x = linspace(0, L, Nx);

% Initial condition u(x,0) = f(x)
u0 = zeros(1, Nx);
u0(x >= 0.1 & x <= 0.2) = 1;

schemes = {'FTBS', 'FTCS', 'FTFS'};
colors = {'b', 'r', 'g'};

for s = 1:3
    figure;
    hold on;
    for co = co_values
        dt = co*dx/a;
        u = u0;
        for n = 1:Nt
            u_new = u;
            switch schemes{s}
                case 'FTBS'
                    for i = 2:Nx
                        u_new(i) = u(i) - co * (u(i) - u(i-1));
                    end
                case 'FTCS'
                    for i = 2:Nx-1
                        u_new(i) = u(i) - (co/2) * (u(i+1) - u(i-1));
                    end
                case 'FTFS'
                    for i = 1:Nx-1
                        u_new(i) = u(i) - co * (u(i+1) - u(i));
                    end
            end
            u = u_new;
        end
        plot(x, u, 'DisplayName', sprintf('Co = %.2f', co), 'LineWidth', 1.5);
    end
    title([schemes{s} ' Scheme']);
    xlabel('x'); ylabel('u'); grid on;
    legend;
    hold off;
end
