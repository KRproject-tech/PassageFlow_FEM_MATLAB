function femg_supg_D_mat = FEMG_supg_D_mat(tau_s,b_U)
%% SUPG慣性項計算(グローバル変数)
global all_row_ind all_col_ind NEW_NODE_NUM_max ELEM_NUM_max Elem_num;

%% 配列要素にアクセスする方法
%%スパース行列の非スパース化
b_U = full(b_U);


%% 一括で組み立てる方法

% ELEM_NUM_max is the number of local stiffness matrices
all_stiff = zeros(ELEM_NUM_max,36);

for i=1:ELEM_NUM_max
    
    %%移流速度成分の分解
    bu = b_U(Elem_num(i,1:6),1);
    bv = b_U(NEW_NODE_NUM_max + Elem_num(i,1:6),1);
  
    
    %%SUPG慣性項
    fem_supg_d_mat = tau_s(i)*FEM_supg_D_mat(bu,bv,i); 
    

	% insert your 1x36 array of stiffness elements
	all_stiff(i,:) = reshape(fem_supg_d_mat',1,36);
end

all_stiff = reshape(all_stiff',1,36*ELEM_NUM_max);

% here NEW_NODE_NUM_max is the total number of unknowns
femg_supg_D_mat = sparse(all_row_ind,all_col_ind,all_stiff,NEW_NODE_NUM_max,NEW_NODE_NUM_max);