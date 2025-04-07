function [fem_supg_Px_mat,fem_supg_Py_mat] = HS_FEM_supg_P_mat(bu,bv,n) 
%% SUPGà≥óÕçÄåvéZ
global FEM_P_xb FEM_P_xc FEM_P_yb FEM_P_yc

fem_supg_Px_mat = FEM_P_xb(:,:,:,:).*bu + FEM_P_xc(:,:,:,:).*bv;
fem_supg_Px_mat = squeeze(sum(fem_supg_Px_mat,1));

fem_supg_Py_mat = FEM_P_yb(:,:,:,:).*bu + FEM_P_yc(:,:,:,:).*bv;
fem_supg_Py_mat = squeeze(sum(fem_supg_Py_mat,1));