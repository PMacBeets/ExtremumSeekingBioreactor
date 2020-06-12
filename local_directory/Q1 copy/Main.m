% Values
sim_time = 10
refine_factor = 1;

r = 0.55;
p=2;
k1 = 1.5;
k2 = 3.0;

%optimal input
u_star = r*p/2

% Initial Conditions
x1_0 = 1;
x2_0 = 1.5;

% input
u = 0.275;

sim_string = 'non_linear_tank';%'non_linear_tank'

out = sim(sim_string)

figure
plot(out.x1.Time,out.x1.Data,out.x2.Time,out.x2.Data,out.y.Time,out.y.Data)
legend({'x1','x2','y'})
xlabel('Time (s)')
ylabel('Output')
title('Free Response')

%% Q1.6

% Open Loop Phase Portrait
x1_0_arr = [0.1 0.1 0.1 0.5 0.5 0.5 1 1 1];
x2_0_arr = [0.5 1 1.5 0.5 1 1.5 0.5 1 1.5];

if length(x1_0_arr)~=length(x2_0_arr)
    print("Incorrect length of initial conditions vector");
    ERROR
end

figure
refine_factor = .1;

for i=1:length(x1_0_arr)
    x1_0 = x1_0_arr(i);
    x2_0 = x2_0_arr(i);
    out = sim(sim_string);
    plot(out.x1.Data,out.x2.Data)
    hold on
end

xlim([0 1.5])
ylim([0 2])
xlabel('x1')
ylabel('x2')
title('Open Loop Phase Portrait')
grid on

%% Q1.7
spread = 0.5;
num_sim = 10;
input_arr  =zeros(1,num_sim );
dt = 2*spread/num_sim;

for i=1:num_sim
    input_arr(i) = u_star-spread+i*dt;  
end

sim_time = 100;
y_star = zeros(1,num_sim);

for i=1:num_sim
    u = input_arr(i);
    x1_0 = 0.1;
    x2_0 = 1;
    out = sim(sim_string);
    y_star(i) = out.y.Data(end);
end

figure
plot(input_arr,y_star)
xlabel('Input U')
ylabel('Y_ss')
title('Y Steady State vs Input')


