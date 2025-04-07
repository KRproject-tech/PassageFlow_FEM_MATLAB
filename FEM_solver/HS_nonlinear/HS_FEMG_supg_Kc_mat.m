function femg_supg_Kc_mat = HS_FEMG_supg_Kc_mat(tau_s,b_U)
%% SUPG慣性項計算(グローバル変数)
global all_row_ind all_col_ind NEW_NODE_NUM_max ELEM_NUM_max Elem_num;

%% 配列要素にアクセスする方法
%%スパース行列の非スパース化
b_U = full(b_U);%移流速度

%% 一括で組み立てる方法

% ELEM_NUM_max is the number of local stiffness matrices
all_stiff = zeros(ELEM_NUM_max,36);

    
bu = zeros(6,1,1,1,ELEM_NUM_max);
bv = zeros(6,1,1,1,ELEM_NUM_max);
bu1 = zeros(1,6,1,1,ELEM_NUM_max);
bv1 = zeros(1,6,1,1,ELEM_NUM_max);

for i=1:ELEM_NUM_max
    
    %%速度成分の分解
    bu(:,1,1,1,i) = b_U(Elem_num(i,1:6),1);
    bv(:,1,1,1,i) = b_U(NEW_NODE_NUM_max + Elem_num(i,1:6),1);
    
    bu1(1,:,1,1,i) = b_U(Elem_num(i,1:6),1);
    bv1(1,:,1,1,i) = b_U(NEW_NODE_NUM_max + Elem_num(i,1:6),1);
end

bu = repmat(bu,[1 6 6 6 1]);
bv = repmat(bv,[1 6 6 6 1]);
bu1 = repmat(bu1,[6 1 6 6 1]);
bv1 = repmat(bv1,[6 1 6 6 1]);


 %%SUPG項
tau_S = zeros(1,1,ELEM_NUM_max);
tau_S(1,1,:) = tau_s;   
fem_supg_kc_mat = repmat(tau_S,[6 6 1]).*HS_FEM_supg_Kc_mat(bu,bv,bu1,bv1); 
 
all_stiff = reshape(permute(fem_supg_kc_mat(:,:,:),[2 1 3]),1,36*ELEM_NUM_max);

% here NEW_NODE_NUM_max is the total number of unknowns
femg_supg_Kc_mat = sparse(all_row_ind,all_col_ind,all_stiff,NEW_NODE_NUM_max,NEW_NODE_NUM_max);
