function fem_supg_D_mat = FEM_supg_D_mat(bu,bv,n) 
%% SUPGägéUçÄåvéZ
global FEM_T_bb FEM_T_bc FEM_T_cb FEM_T_cc

fem_supg_D_mat = squeeze(FEM_T_bb(:,:,:,n)).*repmat(bu,[1 6 6 ]) + squeeze(FEM_T_bc(:,:,:,n)).*repmat(bu,[1 6 6])...
                  +squeeze(FEM_T_cb(:,:,:,n)).*repmat(bv,[1 6 6]) + squeeze(FEM_T_cc(:,:,:,n)).*repmat(bv,[1 6 6]);
fem_supg_D_mat = squeeze(sum(fem_supg_D_mat,1));