function [dSbus_dmax] = dSbus_dma(branch, V, ctrl, vcart)
%DSBUS_DMA   Computes partial derivatives of power injection w.r.t. ma (tap).
%
%   ma can be used either to control the Qf, Qt, Vf or Vt to a certain set 
%   value Qfset, Qtset, Vfset or Vtset respectively. Thus, the derivatives 
%   are separated for each function. The derivatives w.r.t. ma for a
%   certain control will be chosen depending on the 3rd argument "ctrl".
%   So that:
%
%   ctrl = 1 : Qf = Qfset, "from side", Transformers (not for VSC)
%   ctrl = 2 : Qt = Qtset, "to side",   Transformers and VSC
%   ctrl = 3 : Vf = Vtset, "from side", Transformers (not for VSC)
%   ctrl = 4 : Vt = Vtset, "to side",   Transformers and VSC
%
%   The derivatives will be taken with respect to polar or cartesian coordinates
%   of voltage, depending on the 4th argument. So far only polar
%
%   [DSBUS_DQFMA] = DSBUS_DMA(BRANCH, V, 1, 0)
%
%   QF Control
%   Returns one matrix containing partial derivatives of the complex bus
%   power injections w.r.t ma (where Qf control is active for all buses).
%
%   [DSBUS_DQTMA] = DSBUS_DMA(BRANCH, V, 2, 0)
%
%   QT Control
%   Returns one matrix containing partial derivatives of the complex bus
%   power injections w.r.t ma (where Qt control is active for all buses).
%
%   [DSBUS_DVFMA] = DSBUS_DMA(BRANCH, V, 3, 0)
%
%   VF Control
%   Returns one matrix containing partial derivatives of the complex bus
%   power injections w.r.t ma (where Vf control is active for all buses).
%
%   [DSBUS_DVTMA] = DSBUS_DMA(BRANCH, V, 4, 0)
%
%   VT Control
%   Returns one matrix containing partial derivatives of the complex bus
%   power injections w.r.t ma (where Vt control is active for all buses).
%
%   The following explains the expressions used to form the matrices:
%
%   S = diag(V) * conj(Ibus) = diag(conj(Ibus)) * V
%   S = diag(V) * conj(Ybus * V)
%   where:
%       Ybus = Cf' * Yf + Ct' * Yt + diag(Ysh)
%
%       Yf = Yff * Cf + Yft * Ct
%       Yt = Ytf * Cf + Ytt * Ct
%
%       Ytt = Ys + 1j*Bc/2
%       Yff = Gsw+( (Ytt+1j*Beq) ./ ((k2.^2).*tap .* conj(tap))  ) %%<<AAB- FUBM formulation- Original: Yff = Ytt ./ (tap .* conj(tap));
%       Yft = - Ys ./ conj(tap)
%       Ytf = - Ys ./ tap 
%
%       tap = ma .* exp(1j*pi/180 * ShAngle);
%
%   Polar coordinates:
%     Partials of Ytt, Yff, Yft and Ytf w.r.t. ma
%       dYtt/dma = zeros(nl,1)
%       dYff/dma = -2*Yttma./( (k2.^2).*((abs(tap)).^3) )
%       dYft/dma = Ys./( k2.*(abs(tap).*conj(tap)) )
%       dYtf/dma = Ys./( k2.*(abs(tap).*     tap ) )
%
%     Partials of Yf, Yt, Ybus w.r.t. ma
%       dYf/dma = dYff/dma * Cf + dYft/dma * Ct
%       dYt/dma = dYtf/dma * Cf + dYtt/dma * Ct
%
%       dYbus/dma = Cf' * dYf/dma + Ct' * dYt/dma    
%
%     Partials of Sbus w.r.t. ma
%       dSbus/dma = diag(V) * conj(dYbus/dma * V)
%
%   Examples:
%       [dSbus_dQfma] = dSbus_dma(branch, V, 1, vcart);
%       [dSbus_dQtma] = dSbus_dma(branch, V, 2, vcart);
%       [dSbus_dVfma] = dSbus_dma(branch, V, 3, vcart);
%       [dSbus_dVtma] = dSbus_dma(branch, V, 4, vcart);
%
%       [dSbus_dQfma] = dSbus_dma(branch, V, 1);
%       [dSbus_dQtma] = dSbus_dma(branch, V, 2);
%       [dSbus_dVfma] = dSbus_dma(branch, V, 3);
%       [dSbus_dVtma] = dSbus_dma(branch, V, 4);
%
%   For more details on the derivations behind the derivative code used
%   in MATPOWER information, see:
%
%   [TN2]  R. D. Zimmerman, "AC Power Flows, Generalized OPF Costs and
%          their Derivatives using Complex Matrix Notation", MATPOWER
%          Technical Note 2, February 2010.
%             http://www.pserc.cornell.edu/matpower/TN2-OPF-Derivatives.pdf
%   [TN4]  B. Sereeter and R. D. Zimmerman, "AC Power Flows and their
%          Derivatives using Complex Matrix Notation and Cartesian
%          Coordinate Voltages," MATPOWER Technical Note 4, April 2018.
%             http://www.pserc.cornell.edu/matpower/
%                                           TN4-OPF-Derivatives-Cartesian.pdf
%   [TNX]  A. Alvarez-Bustos, "AC/DC FUBM and their Derivatives using FUBM
%          Complex Matrix Notation" MATPOWER Technical Note x, Month 20XX.
%             http://www.pserc.cornell.edu/matpower/
%                                           TNX-OPF-Derivatives-FUBM.pdf   %%AAB- Technical note to be written
                                           
%   ABRAHAM ALVAREZ BUSTOS
%   This code is based and created for MATPOWER
%   This is part of the Flexible Universal Branch Model (FUBM) for MATPOWER
%   For more info about the model, email:
%   snoop_and@hotmail.com, abraham.alvarez-bustos@durham.ac.uk

%   MATPOWER
%   Copyright (c) 1996-2018, Power Systems Engineering Research Center (PSERC)
%   by Ray Zimmerman, PSERC Cornell
%   and Baljinnyam Sereeter, Delft University of Technology
%
%   This file is part of MATPOWER.
%   Covered by the 3-clause BSD License (see LICENSE file for details).
%   See http://www.pserc.cornell.edu/matpower/ for more info.

[F_BUS, T_BUS, BR_R, BR_X, BR_B, RATE_A, RATE_B, ...
    RATE_C, TAP, SHIFT, BR_STATUS, PF, QF, PT, QT, MU_SF, MU_ST, ...
    ANGMIN, ANGMAX, MU_ANGMIN, MU_ANGMAX, VF_SET, VT_SET,TAP_MAX, ...
    TAP_MIN, CONV, BEQ, K2, BEQ_MIN, BEQ_MAX, SH_MIN, SH_MAX, GSW, ...
    ALPH1, ALPH2, ALPH3, KDP] = idx_brch;%<<AAB-extra fields for FUBM

%% default input args
if nargin < 4
    vcart = 0;      %% default to polar coordinates
end

%% control selection
if ctrl == 1     %Qf
    iXxma = find (branch(:,QF)~=0 & branch(:, BR_STATUS)==1 & (branch(:, TAP_MIN)~= branch(:, TAP_MAX)) & branch(:,VF_SET)==0 & branch(:, CONV)==0 ); %AAB- Find branch locations of Qf control size[nQfma,1] %Transformers
elseif ctrl == 2 %Qt
    iXxma = find (branch(:,QT)~=0 & branch(:, BR_STATUS)==1 & (branch(:, TAP_MIN)~= branch(:, TAP_MAX)) & branch(:,VT_SET)==0); %AAB- Find branch locations of Qt control size[nQtsh,1] %Transformers and VSC
elseif ctrl == 3 %Vf
    iXxma = find (branch(:,VF_SET)~=0 & branch(:, BR_STATUS)==1 & branch(:, CONV)==0 & (branch(:, TAP_MIN)~= branch(:, TAP_MAX)) ); %AAB- Find branch locations of Qt control size[nQtsh,1] %Transformers
elseif ctrl == 4 %Vt
    iXxma = find (branch(:,VT_SET)~=0 & branch(:, BR_STATUS)==1 & (branch(:, TAP_MIN)~= branch(:, TAP_MAX)) ); %AAB- Find branch locations of Qt control size[nQtsh,1] %Transformers and VSC
else
    error('dSbus_dma: Control type can only be type 1 (Qf), 2 (Qt), 3(Vf), or 4(Vt)')    
end  
%% constants
nb = length(V);             %% number of buses
nl = size(branch, 1);       %% number of lines
nXxma = length(iXxma);      %% AAB- Number of elements with Voltage or Reactive power controlled by ma  

[stat, Cf, Ct, k2, tap, Ys, Bc, Beq] = getbranchdata(branch, nb); %AAB- Gets the requested data from branch
YttB = Ys + 1j*Bc/2 + 1j*Beq; % Ytt + 1j*Beq
if vcart
    error('dSbus_dma: Derivatives of Power balance equations w.r.t ma in cartasian have not been coded yet')    

else %AAB- Polar Version
    diagV = sparse(1:nb, 1:nb, V, nb, nb); %AAB- diagV = sparse(diag(V))
    
    %Selector of active ma for the specified control 
    maAux = zeros(nl,1);%AAB- Vector of zeros for the seclector
    maAux(iXxma) = 1; %AAB- Fill the selector with "1" where ma is active
    diagYsma = sparse( diag(maAux.*Ys) );  %AAB- ma selector multilied by the series addmitance Ys,  size [nl,nl]
    diagYttBma= sparse( diag(maAux.*YttB) ); %AAB- ma selector multilied by the series addmitance Ytt, size [nl,nl]
    
    %Dimensionalize (Allocate for computational speed)
    dYtt_dma = sparse( zeros(nl,nXxma) );
    dYff_dma = sparse( zeros(nl,nXxma) );
    dYft_dma = sparse( zeros(nl,nXxma) );
    dYtf_dma = sparse( zeros(nl,nXxma) );
    dSbus_dmax = sparse( zeros(nb,nXxma) );
    
    for k=1:nXxma
        Ysma =diagYsma(:,iXxma(k)); %AAB- Selects the column of diagYsma representing only the active ma for the specified control multiplied by Ys
        YttBma=diagYttBma(:,iXxma(k)); %AAB- Selects the column of diagmaAux representing only the active ma for the specified control
        
        %Partials of Ytt, Yff, Yft and Ytf w.r.t. ma
        dYff_dma(:, k) = sparse( -2*YttBma./( (k2.^2).*((abs(tap)).^3) ) );
        dYft_dma(:, k) = sparse( Ysma./( k2.*(abs(tap).*conj(tap)) ) ); 
        dYtf_dma(:, k) = sparse( Ysma./( k2.*(abs(tap).*     tap ) ) ); 
        dYtt_dma(:, k) = sparse( zeros(nl,1) );

        %Partials of Yf, Yt, Ybus w.r.t. ma
        dYf_dma = dYff_dma(:, k).* Cf + dYft_dma(:, k).* Ct; %AAB- size [nl,nb] per active ma
        dYt_dma = dYtf_dma(:, k).* Cf + dYtt_dma(:, k).* Ct; %AAB- size [nl,nb] per active ma

        dYbus_dma = Cf' * dYf_dma + Ct' * dYt_dma;      %AAB- size [nb,nb] per active ma    

        %Partials of Sbus w.r.t. ma
        dSbus_dmax(:, k) = diagV * conj(dYbus_dma * V); %AAB- Final dSbus_dma has a size of [nb, nXxma] 
    end
    
end