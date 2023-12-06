clear, clc, close all

p_init = 1-0.8;
porosity_init = 1 - p_init;

a_init = 1.3;
b_init = 150;
k_init = 0.000;

crospovidone_pressure = [55.0
66.1
84.7
96.7
108.2
128.3
156.4
184.1
226.5
286.6
55.7
70.3
87.1
99.1
110.1
130.7
160.7
190.8
231.2
284.1
54.3
66.2
80.5
95.7
109.0
125.4
147.6
172.4
216.1
261.3
65.2
78.9
103.5
117.4
132.0
166.2
190.9
236.1
283.7
340.0
50.7
62.2
77.0
88.3
103.1
120.7
141.6
178.6
215.5
258.2];

crospovidone_sf = [0.613
0.650
0.692
0.714
0.728
0.745
0.757
0.767
0.769
0.771
0.608
0.650
0.687
0.707
0.720
0.740
0.751
0.761
0.764
0.767
0.605
0.642
0.678
0.707
0.724
0.740
0.754
0.765
0.768
0.770
0.641
0.675
0.717
0.733
0.744
0.758
0.763
0.772
0.768
0.777
0.619
0.653
0.697
0.717
0.743
0.764
0.775
0.784
0.790
0.795];



crospovidone_por = 1-crospovidone_sf;
scatter(crospovidone_pressure, crospovidone_sf)

y_transform = log((1-p_init)./(1-crospovidone_sf));

transform_fit = piston_createFit(crospovidone_pressure,y_transform,a_init,b_init,k_init);
porosity_fit = piston_equ_por_createFit(crospovidone_pressure,crospovidone_por,porosity_init, a_init, b_init, k_init);
porosity_fit_unbound = piston_equ_por_createFit_unbounded(crospovidone_pressure,crospovidone_por,porosity_init, a_init, b_init, k_init);

pressure_cont = min(crospovidone_pressure): max(crospovidone_pressure);

hold on
transform_predict_exp = log((crospovidone_pressure.^(1/transform_fit.a)+transform_fit.b^(1/transform_fit.a))./transform_fit.b^(1/transform_fit.a))+transform_fit.k.*crospovidone_pressure;
transform_predict_value = log((pressure_cont.^(1/transform_fit.a)+transform_fit.b^(1/transform_fit.a))./transform_fit.b^(1/transform_fit.a))+transform_fit.k.*pressure_cont;
transform_predict_sf_exp = 1-((1-p_init)./exp(transform_predict_exp));
transform_predict_sf = 1-((1-p_init)./exp(transform_predict_value));
plot(pressure_cont, transform_predict_sf,'r')

porosity_predict_exp = porosity_init./((((crospovidone_pressure).^(1/porosity_fit.a)+porosity_fit.b.^(1/porosity_fit.a))./porosity_fit.b^(1/porosity_fit.a)).*exp(porosity_fit.k.*crospovidone_pressure));
porosity_fit_predict = porosity_init./((((pressure_cont).^(1/porosity_fit.a)+porosity_fit.b.^(1/porosity_fit.a))./porosity_fit.b^(1/porosity_fit.a)).*exp(porosity_fit.k.*pressure_cont));
plot(pressure_cont, 1-porosity_fit_predict,'b')

porosity_predict_exp_unb = porosity_init./((((crospovidone_pressure).^(1/porosity_fit_unbound.a)+porosity_fit_unbound.b.^(1/porosity_fit_unbound.a))./porosity_fit_unbound.b^(1/porosity_fit_unbound.a)).*exp(porosity_fit_unbound.k.*crospovidone_pressure));
porosity_fit_predict_unb = porosity_init./((((pressure_cont).^(1/porosity_fit_unbound.a)+porosity_fit_unbound.b.^(1/porosity_fit_unbound.a))./porosity_fit_unbound.b^(1/porosity_fit_unbound.a)).*exp(porosity_fit_unbound.k.*pressure_cont));
plot(pressure_cont, 1-porosity_fit_predict_unb,'k')

legend('Experiment Data','Y transform fit', 'Porosity Fit','Porosity Fit Looser Bounds')
xlabel('Compaction Pressure')
ylabel('Relative Density')

figure
scatter(crospovidone_sf,(transform_predict_sf_exp-crospovidone_sf))
hold on
scatter(crospovidone_sf,(1-porosity_predict_exp-crospovidone_sf))
scatter(crospovidone_sf,(1-porosity_predict_exp_unb-crospovidone_sf))

legend({'Transform', 'Porosity','Porosity Looser Bounds'})