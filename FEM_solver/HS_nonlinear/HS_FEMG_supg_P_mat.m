function [femg_supg_Px_mat,femg_supg_Py_mat] = HS_FEMG_supg_P_mat(tau_s,b_U)
%% SUPG�������v�Z(�O���[�o���ϐ�)
global all_row_ind2 all_col_ind2 NEW_NODE_NUM_max NODE_NUM_max ELEM_NUM_max Elem_num;

%%�X�p�[�X�s��̔�X�p�[�X��
b_U = full(b_U);

%% �z��v�f�ɃA�N�Z�X������@
% femg_supg_Px_mat = sparse(NEW_NODE_NUM_max,NODE_NUM_max);
% femg_supg_Py_mat = sparse(NEW_NODE_NUM_max,NODE_NUM_max);
% %Global matrix
% for i=1:1:ELEM_NUM_max;
%     
%     %%���x�����̕���
%     bu = b_U(Elem_num(i,1:6),1);
%     bv = b_U(NEW_NODE_NUM_max + Elem_num(i,1:6),1);
% 
%     %%SUPG������
%     [fem_supg_px_mat,fem_supg_py_mat] = FEM_supg_P_mat(bu,bv,i);    
%     femg_supg_Px_mat(Elem_num(i,1:6),Elem_num(i,1:3)) = femg_supg_Px_mat(Elem_num(i,1:6),Elem_num(i,1:3)) + fem_supg_px_mat;
%     femg_supg_Py_mat(Elem_num(i,1:6),Elem_num(i,1:3)) = femg_supg_Py_mat(Elem_num(i,1:6),Elem_num(i,1:3)) + fem_supg_py_mat;
% end

%% �ꊇ�őg�ݗ��Ă���@

% ELEM_NUM_max is the number of local stiffness matrices
all_stiff1 = zeros(ELEM_NUM_max,18);
all_stiff2 = zeros(ELEM_NUM_max,18);
    
bu = zeros(6,1,1,ELEM_NUM_max);
bv = zeros(6,1,1,ELEM_NUM_max);

for i=1:ELEM_NUM_max
    
    %%���x�����̕���
    bu(:,1,1,i) = b_U(Elem_num(i,1:6),1);
    bv(:,1,1,i) = b_U(NEW_NODE_NUM_max + Elem_num(i,1:6),1);
end

bu = repmat(bu,[1 6 3 1]);
bv = repmat(bv,[1 6 3 1]);


    
%%SUPG������
tau_S = zeros(1,1,ELEM_NUM_max);
tau_S(1,1,:) = tau_s;  
[fem_supg_px_mat,fem_supg_py_mat] = HS_FEM_supg_P_mat(bu,bv);     

fem_supg_px_mat = repmat(tau_S,[6 3 1]).*fem_supg_px_mat;
fem_supg_py_mat = repmat(tau_S,[6 3 1]).*fem_supg_py_mat;

all_stiff1 = reshape(permute(fem_supg_px_mat(:,:,:),[2 1 3]),1,18*ELEM_NUM_max);
all_stiff2 = reshape(permute(fem_supg_py_mat(:,:,:),[2 1 3]),1,18*ELEM_NUM_max);


% here NEW_NODE_NUM_max is the total number of unknowns
femg_supg_Px_mat = sparse(all_row_ind2,all_col_ind2,all_stiff1,NEW_NODE_NUM_max,NODE_NUM_max);
femg_supg_Py_mat = sparse(all_row_ind2,all_col_ind2,all_stiff2,NEW_NODE_NUM_max,NODE_NUM_max);

