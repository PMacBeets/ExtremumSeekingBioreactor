%
datapoints = 50;
min_freq = 2*pi/1000
max_freq = 2*pi/10
w_array = linspace(min_freq,max_freq,datapoints);

% Values
sim_time = 100
refine_factor = 1;

r = 0.55;
p=2;
k1 = 1.5;
k2 = 3.0;

%optimal input
u_star = r*p/2

% Initial Conditions
x1_0 = 0.1;
x2_0 = 0.1;

% input
u = 1;

err = zeros(1,datapoints);

for i=1:datapoints
    w = w_array(i);
    out = sim('non_linear_tank_Test_Dither');
    err(i) = mean(out.y_diff_filtered.Data(end-100:end)); %take average of last 100 datapoints   
end

plot(w_array,err)
xlabel('Frequency')
ylabel('Error From Steady State')
title('Error (y-y_{bar}) vs Frequency')



