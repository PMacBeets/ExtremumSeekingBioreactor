% Paramteres
K = 0.4;
w = 2*pi/40;
b = 3*w;
c = 20*w;
a_dith = .05;

% Values
sim_time = 400
refine_factor = 1;

r = 0.55;
p = 2;
k1 = 1.5;
k2 = 3.0;

% Initial Conditions
x1_0 = 1;
x2_0 = 1;

max = 1.5
num = 16
x1_arr = linspace(0,max,num);
x2_arr = linspace(0,max,num);

% Low Pass Filter
s = tf('s');
LPF = c/(s+c)
bode(LPF)

% High Pass Filter
figure
HPF = s/(s+b)
bode(HPF)

% For Analysis
Opt = 1.1;
dy = 0.2; % Percentage from optimum 

Stable = zeros(10,10);

for i=1:num
    x1_0 = x1_arr(i);
    for j=1:num
        x2_0 = x2_arr(j);
        out = sim('Extremum_seeking_Non_Linear');
        if out.y.Time(end) >= 399
            Stable(i,j) = 1; 
            fprintf("i=%d, j=%d",i,j)
        end       
    end
end



