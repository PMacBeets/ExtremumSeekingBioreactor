%
min_freq = 2*pi/1000
max_freq = 2*pi/10
w = 10*2*pi

% Values
sim_time = 500
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
u = 0.1;

out = sim('non_linear_tank_Test_Dither')

plot(out.x1.Time,out.x1.Data,out.x2.Time,out.x2.Data,out.y.Time,out.y.Data)
legend({'x1','x2','y'})
xlabel('Time (s)')
ylabel('Output')
title('Free Response')

figure
plot(out.y.Time,out.y.Data,out.y_bar.Time,out.y_bar.Data)
legend({'y','y_{bar}'})
xlabel('Time (s)')
ylabel('Output')
title('Steady State Vs Actual Values')

figure
plot(out.y_diff_filtered.Time,out.y_diff_filtered.Data)
legend({'abs(y-y_{bar}): Filtered'})
xlabel('Time (s)')
ylabel('Output')
title('Normalised Error')


final_err = mean(out.y_diff_filtered.Data(end-100:end)); %take average of last 100 datapoints  

% % Calsulate RMSE
% batch = 30
% len = length(out.y.Data)
% RMSE = zeros(1,len-batch);
% TIME = zeros(1,len-batch);
% for i=1:len-batch
%     RMSE(i) = sqrt(mean((out.y.Data(i:i+batch) - out.y_bar.Data(i:i+batch)).^2));
%     TIME(i) = batch + (sim_time-batch)/(len-batch)*i;
% end






