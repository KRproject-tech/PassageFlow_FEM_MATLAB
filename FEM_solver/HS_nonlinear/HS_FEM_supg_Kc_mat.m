function fem_supg_Kc_mat = HS_FEM_supg_Kc_mat(bu,bv,bu1,bv1) 
%% SUPGëŒó¨çÄåvéZ
global FEM_R_bb FEM_R_bc FEM_R_cb FEM_R_cc

fem_supg_Kc_mat = FEM_R_bb(:,:,:,:,:).*bu.*bu1 + FEM_R_bc(:,:,:,:,:).*bu.*bv1...
                  +FEM_R_cb(:,:,:,:,:).*bv.*bu1 + FEM_R_cc(:,:,:,:,:).*bv.*bv1;
fem_supg_Kc_mat = squeeze(sum(sum(fem_supg_Kc_mat,1),2));

