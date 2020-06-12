% Paramteres
K = 1;
c = 2*pi/2;
b = 2*pi/20;

w = 2*pi/40;
a_dith = .05;


% Values
sim_time = 400
refine_factor = 1;


r = 0.55;
p = 2;
k1 = 1.5;
k2 = 3.0;

% Initial Conditions
x1_0 = 0.1;
x2_0 = 1;

% input
u = 0.275;

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


out = sim('Extremum_seeking')

plot(out.y.Time, out.y.Data)

set_time = 0;
steady_state_err = 0;
for i =1:length(out.y.Data)
    if out.y.Data(i) > Opt*(1-dy) && set_time==0
        set_time = out.y.Time(i);
    end
    if out.y.Data(i) < Opt*(1-dy)
        set_time = 0;
    end
    % Steady State
    if out.y.Time(i)>300 && abs(Opt-out.y.Data(i)) > steady_state_err
        steady_state_err = abs(Opt-out.y.Data(i));
    end
    
end

fprintf("Settling time is %0.3f seconds\n",set_time)
fprintf("Steady State Error is %0.3f \n",steady_state_err)

