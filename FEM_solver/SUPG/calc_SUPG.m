%% SUPG–@

g_M_s = HS_FEMG_supg_M_mat(tau_s,b_U_vec);%Šµ«€
g_Kc_s = HS_FEMG_supg_Kc_mat(tau_s,b_U_vec);%ˆÚ—¬€
g_D_s = HS_FEMG_supg_D_mat(tau_s,b_U_vec);%ŠgU€
[H_xs,H_ys] = HS_FEMG_supg_P_mat(tau_s,b_U_vec);%ˆ³—Í€

G_M_s = blkdiag(g_M_s,g_M_s,MZ2);
G_Kc_s = [ g_Kc_s-nu*g_D_s     MZ1      H_xs/rho;
           MZ1      g_Kc_s-nu*g_D_s     H_ys/rho;
           sparse(NODE_NUM_max,GLOBAL_MATRIX_NUM)];
       