function fem_supg_Kc_mat = FEM_supg_Kc_mat(bu,bv,n) 
%% SUPGëŒó¨çÄåvéZ
global FEM_R_bb FEM_R_bc FEM_R_cb FEM_R_cc

fem_supg_Kc_mat = squeeze(FEM_R_bb(:,:,:,:,n)).*repmat(bu,[1 6 6 6]).*repmat(bu',[6 1 6 6]) + squeeze(FEM_R_bc(:,:,:,:,n)).*repmat(bu,[1 6 6 6]).*repmat(bv',[6 1 6 6])...
                  +squeeze(FEM_R_cb(:,:,:,:,n)).*repmat(bv,[1 6 6 6]).*repmat(bu',[6 1 6 6]) + squeeze(FEM_R_cc(:,:,:,:,n)).*repmat(bv,[1 6 6 6]).*repmat(bv',[6 1 6 6]);
fem_supg_Kc_mat = squeeze(sum(sum(fem_supg_Kc_mat,1),2));

% fem_supg_Kc_mat = ttv(tensor(FEM_R_bb(:,:,:,:,n)), {bu,bu},[1 2]) + ttv(tensor(FEM_R_bc(:,:,:,:,n)), {bu,bv},[1 2]) ...
%                   + ttv(tensor(FEM_R_cb(:,:,:,:,n)), {bv,bu},[1 2]) + ttv(tensor(FEM_R_cc(:,:,:,:,n)), {bv,bv},[1 2]);
% fem_supg_Kc_mat = double(fem_supg_Kc_mat);