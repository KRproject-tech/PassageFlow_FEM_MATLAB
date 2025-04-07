function femg_supg_M_mat = HS_FEMG_supg_M_mat(tau_s,b_U)
%% SUPG慣性項計算(グローバル変数)
global all_row_ind all_col_ind NEW_NODE_NUM_max ELEM_NUM_max Elem_num;

%% 配列要素にアクセスする方法
%%スパース行列の非スパース化
b_U = full(b_U);


%% 一括で組み立てる方法

% ELEM_NUM_max is the number of local stiffness matrices
all_stiff = zeros(ELEM_NUM_max,36);

bu = zeros(1,6,1,ELEM_NUM_max);
bv = zeros(1,6,1,ELEM_NUM_max);

for i=1:ELEM_NUM_max
    
    %%速度成分の分解
    bu(1,:,1,i) = b_U(Elem_num(i,1:6),1);
    bv(1,:,1,i) = b_U(NEW_NODE_NUM_max + Elem_num(i,1:6),1);
end

bu = repmat(bu,[6 1 6 1]);
bv = repmat(bv,[6 1 6 1]);
    
%%SUPG慣性項
tau_S = zeros(1,1,ELEM_NUM_max);
tau_S(1,1,:) = tau_s;
fem_supg_m_mat = repmat(tau_S,[6 6 1]).*HS_FEM_Kc_mat(bu,bv); 
    
all_stiff = reshape(permute(fem_supg_m_mat(:,:,:),[2 1 3]),1,36*ELEM_NUM_max);

% here NEW_NODE_NUM_max is the total number of unknowns
femg_supg_M_mat = sparse(all_row_ind,all_col_ind,all_stiff,NEW_NODE_NUM_max,NEW_NODE_NUM_max);
