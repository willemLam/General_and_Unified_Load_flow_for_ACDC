function mpc = FUBM_m_grid
%%%%%%%%%%%%%%%%%%%%%%%% IEEE_30_VSC  Test Case %%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 0.1;

%% area data
% area refbus
mpc.areas = [
        1    1; %area 1 CIGRE
        2    19; %area 2 DC GRID
            ];

        

%% bus data
%	bus_i	type	Pd      Qd      Gs      Bs      area   Vm       Va    base[KV]	zone	Vmax	Vmin

mpc.bus = [
    %Area 1 (IEEE 30 Bus System)
    1       3       0       0       0       0       1       1       0       0.4     1       1.15	0.85;
    2       1   	0       0       0   	0   	1   	1   	0   	0.4 	1   	1.15	0.85;
    3    	1   	0.03   0   	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    4    	1   	0       0   	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    5    	1   	0.0375  0.0075	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    6    	1   	0       0   	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    7    	1   	0       0   	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    8    	1   	0       0   	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    9    	1   	0.0101  0   	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    10    	1   	0       0   	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    11    	1   	0.015  -0.003   0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    12    	1   	0       0   	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    13    	1   	0.0202  0       0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    14    	1   	0      -0.0124	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    15    	1   	0       0   	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    16    	1   	0       0   	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    17    	1   	0       0   	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    18    	1   	0       0   	0   	0    	1   	1   	0   	0.4 	1   	1.15	0.85;
    %Area 2 (Transformers nodes for VSC DC GRID 1)  
    19    	1   	0       0    	0   	0   	2   	1   	0   	0.8 	1   	1.15	0.85;
    20    	1   	0       0   	0   	0   	2   	1   	0   	0.8 	1   	1.15	0.85;
    21    	1       0       0   	0   	0   	2   	1   	0   	0.8 	1   	1.15	0.85;
    22    	1       0       0   	0   	0   	2   	1   	0   	0.8 	1   	1.15	0.85;
    %Area 2 (DC GRID 1)
    23   	1   	-0.005  0   	0   	0   	2   	1   	0   	0.8 	1   	1.15	0.85;
    24   	1   	-0.005  0   	0   	0   	2   	1   	0   	0.8 	1   	1.15	0.85;
    25   	1   	0.005   0   	0   	0   	2   	1   	0   	0.8 	1   	1.15	0.85;
    26   	1   	0.005   0   	0   	0   	2   	1   	0   	0.8 	1   	1.15	0.85;
];
%% generator data
%	bus     Pg      Qg      Qmax	Qmin	Vg     mBase	status	Pmax   Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
    %IEEE 57 Bus System
    1       0       0   	1       -1  	1   	0.1    	1   	1  	   -1    0	 0	 0   	0   	0   	0   	0       	0   	0   	0   	0;
    ];
%% branch data
%  fbus tbus	r	    x	    b       rateA   rateB	rateC ratio/ma  angle status angmin	angmax  PF      QF      PT      QT      MU_SF  MU_ST   MU_ANGMIN   MU_ANGMAX   VF_SET  VT_SET  MA_MAX MA_MIN CONV_A     BEQ     K2   BEQ_MIN BEQ_MAX SH_MIN  SH_MAX  GSW ALPHA1 ALPHA2 ALPHA3  KDP----------------------
mpc.branch = [
%Area 1  AC
1	2	0.0119    0.0052    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
2	3	0.0619    0.0027    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
2	4	0.0060    0.0026    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
4	5	0.0146    0.0024    0.0000	    0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
4	6	0.0794    0.0087    0.0000	    0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
6	7	0.0227    0.0025    0.0000	    0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
4	8	0.0242    0.0054    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
8	9	0.0051    0.0022    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
8	10	0.0794    0.0087    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
10	11	0.0619    0.0027    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
10	12	0.0265    0.0029    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
12	13	0.0227    0.0025    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
7	14	0.0185    0.0030    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
9   15  0.0051    0.0022    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
13  16  0.0051    0.0022    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
11  17  0.0051    0.0022    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;
7   18  0.0051    0.0022    0.0000      0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0       	0       	0   	0       1       1       0	    0       1    0       0       -360    360     0    0       0       0     0;

%Area 2  VSC                               rateA   rateB	rateC ratio/ma  angle status angmin	angmax  PF      QF      PT      QT      MU_SF  MU_ST   MU_ANGMIN   MU_ANGMAX   VF_SET  VT_SET  MA_MAX MA_MIN CONV_A     BEQ     K2   BEQ_MIN BEQ_MAX SH_MIN  SH_MAX  GSW ALPHA1 ALPHA2 ALPHA3  ----------------------    
19  15    0.0000050  0.000025   0           0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0   	  0   	0      -0.0100  	0   	0       -1       	1       	1.003   	0       1.4     0.6     2       0       1    -0.7    0.7     -360    360     0    0       0       0     0; %VSC1vdc
20  16    0.0000050  0.000025   0       	0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0         0   	0      -0.0100     	0   	0       -1       	1       	1.002   	0       1.4     0.6     2       0       1    -0.7    0.7      -50     50     0    0       0       0     0; %VSC2vdc
21  17    0.0000050  0.000025   0       	0.1 	0.1 	0.1 	1   	0   	1	-360	360 	0    	  0   	0      -0.0100    	0   	0       -1       	1       	1.001  	0       1.4     0.6     2       0       1    -0.7    0.7      -50     50     0    0       0       0     0; %VSC3vdc
22  18    0.0000050  0.000025   0       	0.1 	0.1 	0.1 	1   	0   	1	-360	360 	-0.0031   0   	0      -0.0100    	0   	0       -1       	1       	0   	0       1.4     0.6     1       0       1    -0.7    0.7      -50     50     0    0       0       0     0; %VSC4vdc

%Area 2  DC                        rateA   rateB	rateC ratio/ma  angle status angmin	angmax  PF      QF      PT      QT      MU_SF  MU_ST   MU_ANGMIN   MU_ANGMAX   VF_SET  VT_SET  MA_MAX MA_MIN CONV_A     BEQ     K2   BEQ_MIN BEQ_MAX SH_MIN  SH_MAX  GSW ALPHA1 ALPHA2 ALPHA3  ----------------------   
19	23	0.0312	    1E-09	1E-09           0.1 	0.1 	0.1     1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0           0       	0   	0   	1   	1   	0   	0   	1    0       0       -360    360     0    0       0       0     0;
20	24	0.0312	    1E-09	1E-09	        0.1 	0.1 	0.1     1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0           0       	0   	0   	1   	1   	0   	0   	1    0       0       -360    360     0    0       0       0     0;
21	25	0.0312	    1E-09	1E-09        	0.1 	0.1 	0.1     1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0           0       	0   	0   	1   	1   	0   	0   	1    0       0       -360    360     0    0       0       0     0;
22	26	0.0312	    1E-09	1E-09        	0.1 	0.1 	0.1     1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0           0       	0   	0   	1   	1   	0   	0   	1    0       0       -360    360     0    0       0       0     0;
26	23	0.0781  	1E-09	1E-09        	0.1 	0.1 	0.1     1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0           0       	0   	0   	1   	1   	0   	0   	1    0       0       -360    360     0    0       0       0     0;
23	25	0.0781  	1E-09	1E-09        	0.1 	0.1 	0.1     1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0           0       	0   	0   	1   	1   	0   	0   	1    0       0       -360    360     0    0       0       0     0;
25	24	0.0781  	1E-09	1E-09        	0.1 	0.1 	0.1     1   	0   	1	-360	360 	0   	0   	0   	0   	0   	0   	0           0       	0   	0   	1   	1   	0   	0   	1    0       0       -360    360     0    0       0       0     0;
    ];
%%-----  OPF Data  -----%%
%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
    %Pg cost
    2	0   	0       	1	0.01        	2   	0;
    %Qg cost
    2	0   	0       	1	0.01        	0   	0;
];
