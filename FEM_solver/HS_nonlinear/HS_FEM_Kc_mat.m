function fem_Kc_mat = HS_FEM_Kc_mat(u,v) 
%% ‘Î—¬€ŒvZ
global FEM_phi_b FEM_phi_c

fem_Kc_mat = FEM_phi_b(:,:,:,:).*u + FEM_phi_c(:,:,:,:).*v;
fem_Kc_mat = squeeze(sum(fem_Kc_mat,2));