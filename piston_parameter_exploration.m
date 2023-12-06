%Piston equation fitting constant exploration
clear, clc, close all

pressure_mpa = 0:5000; 
%% For each initial porosity, with constant 
constant_k = 0.009;
constant_a = 1.49;
constant_b = 150;
const_init_porosity = 0.3; % changes on a per material basis


var_initial_porosity = 0.4:0.1:0.8; % changes on a per material basis

var_init_porosity_por = zeros(numel(pressure_mpa),numel(var_initial_porosity));
legend_str = cell(1,numel(var_initial_porosity));
figure
hold on
for i = 1:numel(var_initial_porosity)
    var_init_porosity_por(:,i) = var_initial_porosity(i)./((((pressure_mpa).^(1/constant_a)+constant_b.^(1/constant_a))./constant_b^(1/constant_a)).*exp(constant_k.*pressure_mpa));
    plot(pressure_mpa,var_init_porosity_por(:,i))
    legend_str{i} = strcat('Init Por = ', num2str(var_initial_porosity(i)));
end
set(gcf,'Color',[1 1 1])
set(gca,'Box','off')
set(gca,'FontSize',12)
xlabel('Pressure (MPa)',FontSize=14)
ylabel('Porosity (-)','FontSize',14)
title('Effect of initial porosity')
text(150,0.7,strcat('a = ',num2str(constant_a)),'FontSize',14)
text(150,0.65,strcat('b = ',num2str(constant_b)),'FontSize',14)
text(150,0.6,strcat('k = ',num2str(constant_k)),'FontSize',14)
legend(legend_str,'FontSize',14)

%% Variable a values
var_a = [1, 1.49, 2, 3];
var_a_por = zeros(numel(pressure_mpa),numel(var_a));
legend_str = cell(1,numel(var_a));
figure
hold on
for i = 1:numel(var_a)
    var_a_por(:,i) = const_init_porosity./((((pressure_mpa).^(1/var_a(i))+constant_b.^(1/var_a(i)))./constant_b^(1/var_a(i))).*exp(constant_k.*pressure_mpa));
    plot(pressure_mpa,var_a_por(:,i))
    legend_str{i} = strcat('a = ', num2str(var_a(i)));
end
set(gcf,'Color',[1 1 1])
set(gca,'Box','off')
set(gca,'FontSize',12)
xlabel('Pressure (MPa)',FontSize=14)
ylabel('Porosity (-)','FontSize',14)
title('Effect of "a" parameter')
text(150,0.25,strcat('Init Por = ',num2str(const_init_porosity)),'FontSize',14)
text(150,0.225,strcat('b = ',num2str(constant_b)),'FontSize',14)
text(150,0.2,strcat('k = ',num2str(constant_k)),'FontSize',14)


legend(legend_str,'FontSize',14)

%% Variable b values
var_b = [30, 150, 200, 500, 1000];
var_b_por = zeros(numel(pressure_mpa),numel(var_b));
legend_str = cell(1,numel(var_b));
figure
hold on
for i = 1:numel(var_b)
    var_b_por(:,i) = const_init_porosity./((((pressure_mpa).^(1/constant_a)+var_b(i).^(1/constant_a))./var_b(i)^(1/constant_a)).*exp(constant_k.*pressure_mpa));
    plot(pressure_mpa,var_b_por(:,i))
    legend_str{i} = strcat('b = ', num2str(var_b(i)));
end
set(gcf,'Color',[1 1 1])
set(gca,'Box','off')
set(gca,'FontSize',12)
xlabel('Pressure (MPa)',FontSize=14)
ylabel('Porosity (-)','FontSize',14)
title('Effect of "b" parameter')
text(150,0.25,strcat('Init Por = ',num2str(const_init_porosity)),'FontSize',14)
text(150,0.225,strcat('a = ',num2str(constant_a)),'FontSize',14)
text(150,0.2,strcat('k = ',num2str(constant_k)),'FontSize',14)


legend(legend_str,'FontSize',14)

%% Variable k values
var_k = [0.0001, 0.0005, 0.001, 0.005, 0.01];
var_k_por = zeros(numel(pressure_mpa),numel(var_k));
legend_str = cell(1,numel(var_k));
figure
hold on
for i = 1:numel(var_k)
    var_k_por(:,i) = const_init_porosity./((((pressure_mpa).^(1/constant_a)+constant_b.^(1/constant_a))./constant_b^(1/constant_a)).*exp(var_k(i).*pressure_mpa));
    plot(pressure_mpa,var_k_por(:,i))
    legend_str{i} = strcat('k = ', num2str(var_k(i)));
end
set(gcf,'Color',[1 1 1])
set(gca,'Box','off')
set(gca,'FontSize',12)
xlabel('Pressure (MPa)',FontSize=14)
ylabel('Porosity (-)','FontSize',14)
title('Effect of "k" parameter')
text(150,0.25,strcat('Init Por = ',num2str(const_init_porosity)),'FontSize',14)
text(150,0.225,strcat('a = ',num2str(constant_a)),'FontSize',14)
text(150,0.2,strcat('b = ',num2str(constant_b)),'FontSize',14)


legend(legend_str,'FontSize',14)