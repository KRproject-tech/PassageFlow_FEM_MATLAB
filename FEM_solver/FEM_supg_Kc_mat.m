function fem_supg_Kc_mat = FEM_supg_Kc_mat(u,v,n) 
%% SUPG‘Î—¬€ŒvZ
global R_tensor

fem_supg_Kc_mat = squeeze(FEM_phi_b(:,:,:,n)).*repmat(u',[6 1 6]) + squeeze(FEM_phi_c(:,:,:,n)).*repmat(v',[6 1 6]);
fem_supg_Kc_mat = squeeze(sum(fem_Kc_mat,2));