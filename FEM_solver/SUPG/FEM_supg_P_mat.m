function [fem_supg_Px_mat,fem_supg_Py_mat] = FEM_supg_P_mat(bu,bv,n) 
%% SUPGà≥óÕçÄåvéZ
global FEM_P_xb FEM_P_xc FEM_P_yb FEM_P_yc

fem_supg_Px_mat = squeeze(FEM_P_xb(:,:,:,n)).*repmat(bu,[1 6 3 ]) + squeeze(FEM_P_xc(:,:,:,n)).*repmat(bv,[1 6 3]);
fem_supg_Px_mat = squeeze(sum(fem_supg_Px_mat,1));

fem_supg_Py_mat = squeeze(FEM_P_yb(:,:,:,n)).*repmat(bu,[1 6 3 ]) + squeeze(FEM_P_yc(:,:,:,n)).*repmat(bv,[1 6 3]);
fem_supg_Py_mat = squeeze(sum(fem_supg_Py_mat,1));