function femg_Kc_mat = HS_FEMG_Kc_mat(U)
%% �Η����v�Z(�O���[�o���ϐ�)
global all_row_ind all_col_ind NEW_NODE_NUM_max ELEM_NUM_max Elem_num;

%% �z��v�f�ɃA�N�Z�X������@
%%�X�p�[�X�s��̔�X�p�[�X��
U = full(U);

%% �ꊇ�őg�ݗ��Ă���@

% ELEM_NUM_max is the number of local stiffness matrices
all_stiff = zeros(ELEM_NUM_max,36);

u = zeros(1,6,1,ELEM_NUM_max);
v = zeros(1,6,1,ELEM_NUM_max);

for i=1:ELEM_NUM_max
    
    %%���x�����̕���
    u(1,:,1,i) = U(Elem_num(i,1:6),1);
    v(1,:,1,i) = U(NEW_NODE_NUM_max + Elem_num(i,1:6),1);
end

u = repmat(u,[6 1 6 1]);
v = repmat(v,[6 1 6 1]);

%%�Η���
fem_kc_mat = HS_FEM_Kc_mat(u,v); 
    
all_stiff = reshape(permute(fem_kc_mat(:,:,:),[2 1 3]),1,36*ELEM_NUM_max);

% here NEW_NODE_NUM_max is the total number of unknowns
femg_Kc_mat = sparse(all_row_ind,all_col_ind,all_stiff,NEW_NODE_NUM_max,NEW_NODE_NUM_max);
