function fem_Kc_mat = FEM_Kc_mat(u,v,n) 
%% ëŒó¨çÄåvéZ
global FEM_phi_b FEM_phi_c

fem_Kc_mat = squeeze(FEM_phi_b(:,:,:,n)).*repmat(u',[6 1 6]) + squeeze(FEM_phi_c(:,:,:,n)).*repmat(v',[6 1 6]);
fem_Kc_mat = squeeze(sum(fem_Kc_mat,2));