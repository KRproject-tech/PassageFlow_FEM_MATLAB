global EXE_flag;

%% グローバルマトリックス構成

%スパース行列(グローバル行列)
FEMG_M_mat = sparse(NEW_NODE_NUM_max,NEW_NODE_NUM_max);
FEMG_K_mat = sparse(NEW_NODE_NUM_max,NEW_NODE_NUM_max);
FEMG_Hx_mat = sparse(NEW_NODE_NUM_max,NODE_NUM_max);
FEMG_Hy_mat = sparse(NEW_NODE_NUM_max,NODE_NUM_max);
FEMG_qx = sparse(NEW_NODE_NUM_max,1);
FEMG_qy = sparse(NEW_NODE_NUM_max,1);
FEMG_qp = sparse(NODE_NUM_max,1);

%%Global matrix
for i=1:1:ELEM_NUM_max;

    %%慣性項
    FEMG_M_mat(Elem_num(i,1:6),Elem_num(i,1:6)) = FEMG_M_mat(Elem_num(i,1:6),Elem_num(i,1:6)) + squeeze(FEM_M_mat(1:6,1:6,i));
    
    %%拡散項
    FEMG_K_mat(Elem_num(i,1:6),Elem_num(i,1:6)) = FEMG_K_mat(Elem_num(i,1:6),Elem_num(i,1:6)) + squeeze(FEM_K_mat(1:6,1:6,i));
    
    %%圧力項
    FEMG_Hx_mat(Elem_num(i,1:6),Elem_num(i,1:3)) = FEMG_Hx_mat(Elem_num(i,1:6),Elem_num(i,1:3)) + squeeze(FEM_Hx_mat(1:6,1:3,i));
    FEMG_Hy_mat(Elem_num(i,1:6),Elem_num(i,1:3)) = FEMG_Hy_mat(Elem_num(i,1:6),Elem_num(i,1:3)) + squeeze(FEM_Hy_mat(1:6,1:3,i));
    
    %%境界条件
    FEMG_qx(Elem_num(i,1:6),1) = FEMG_qx(Elem_num(i,1:6),1) + q1_i(1:6,i);
    FEMG_qy(Elem_num(i,1:6),1) = FEMG_qy(Elem_num(i,1:6),1) + q2_i(1:6,i);
    FEMG_qp(Elem_num(i,1:3),1) = FEMG_qp(Elem_num(i,1:3),1) + q3_i(1:3,i);
end
    


%% マトリクス組立
MZ1 = sparse(NEW_NODE_NUM_max,NEW_NODE_NUM_max);
MZ2 = sparse(NODE_NUM_max,NODE_NUM_max);

G_M = blkdiag(FEMG_M_mat,FEMG_M_mat,MZ2);
G_K = @(U_vec)([HS_FEMG_Kc_mat(U_vec) + FEMG_K_mat     MZ1        FEMG_Hx_mat;
                MZ1         HS_FEMG_Kc_mat(U_vec) + FEMG_K_mat    FEMG_Hy_mat;
                FEMG_Hx_mat'            FEMG_Hy_mat'       MZ2]);
G_F = [FEMG_qx;
       FEMG_qy;
       FEMG_qp/rho];
   
%%線形化項(ストークス近似)
G_KL = [FEMG_K_mat            MZ1            FEMG_Hx_mat;
        MZ1                  FEMG_K_mat      FEMG_Hy_mat;
        FEMG_Hx_mat'    FEMG_Hy_mat'       MZ2];

% clear FEM_M_mat FEM_K_mat FEM_Hx_mat FEM_Hy_mat FEM_B_mat FEM_C_mat ;

   
   



