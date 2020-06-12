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
x1_0 = 0.1;
x2_0 = 1;

num = 50;
r_array = linspace(0.25,0.75,num);

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

Stable = zeros(1,num);
steady_state_array = zeros(1,num);
set_time_array = zeros(1,num);


for i=1:num
    r =r_array(i);
    out = sim('Extremum_seeking');      
    if out.y.Time(end) >= 399
        Stable(i) = 1; 
        %fprintf("i=%d",i)
        % Calculate Steady State Error
        set_time = 0;
        steady_state_err = 0;
        Opt = 2*r;
        for j =1:length(out.y.Data)
            % Settling time
            if out.y.Data(j) > Opt*(1-dy) && set_time==0
                set_time = out.y.Time(j);
            end
            if out.y.Data(j) < Opt*(1-dy)
                set_time = 0;
            end
            % Steady State
            if out.y.Time(j)>300 && abs(Opt-out.y.Data(j)) > steady_state_err
                steady_state_err = abs(Opt-out.y.Data(j));
            end
        end  
        steady_state_array(i) = steady_state_err;
        set_time_array(i) = set_time;
    end
end

figure

