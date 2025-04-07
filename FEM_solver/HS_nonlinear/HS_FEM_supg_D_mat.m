function fem_supg_D_mat = HS_FEM_supg_D_mat(bu,bv) 
%% SUPGägéUçÄåvéZ
global FEM_T_bb FEM_T_bc FEM_T_cb FEM_T_cc

fem_supg_D_mat = FEM_T_bb(:,:,:,:).*bu + FEM_T_bc(:,:,:,:).*bu...
                  +FEM_T_cb(:,:,:,:).*bv + FEM_T_cc(:,:,:,:).*bv;
fem_supg_D_mat = squeeze(sum(fem_supg_D_mat,1));