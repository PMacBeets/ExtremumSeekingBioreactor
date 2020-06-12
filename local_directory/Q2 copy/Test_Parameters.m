% Paramteres
K = 0.4;
w = 2*pi/40;
c = 20*w;
b = 3*w;
a_dith = .05;

% Values
sim_time = 400
refine_factor = 1;

r = 0.55;
p = 2;
k1 = 1.5;
k2 = 3.0;

% Initial Conditions
x1_0 = 0.7;
x2_0 = 0.5;


% Low Pass Filter
s = tf('s');
LPF = c/(s+c)
bode(LPF)
str1 = sprintf('Low Pass Filter, c = %0.3f',c);
title(str1)

% High Pass Filter
figure
HPF = s/(s+b)
bode(HPF)
str2 =sprintf('High Pass Filter, b = %0.3f',b)
title(str2)

% For Analysis
Opt = 2*r;
dy = 0.05; % Percentage from optimum 
out = sim('Extremum_seeking')
figure
plot(out.y.Time, out.y.Data)

set_time = 0;
steady_state_err = 0;
for i =1:length(out.y.Data)
    if abs(Opt - out.y.Data(i)) < dy*Opt && set_time==0
        set_time = out.y.Time(i);
    end
    if abs(Opt - out.y.Data(i)) > dy*Opt
        set_time = 0;
    end
    % Steady State
    if out.y.Time(i)>300 && abs(Opt-out.y.Data(i)) > steady_state_err
        steady_state_err = abs(Opt-out.y.Data(i));
    end
    
end

fprintf("Settling time is %0.3f seconds\n",set_time)
fprintf("Steady State Error is %0.3f \n",steady_state_err)

