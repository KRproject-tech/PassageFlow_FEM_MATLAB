function femg_Kc_mat = FEMG_Kc_mat(U)
%% 対流項計算(グローバル変数)
global all_row_ind all_col_ind NEW_NODE_NUM_max ELEM_NUM_max Elem_num;

%% 配列要素にアクセスする方法
%%スパース行列の非スパース化
U = full(U);
% femg_Kc_mat = sparse(NEW_NODE_NUM_max,NEW_NODE_NUM_max);
%%Global matrix
% for i=1:1:ELEM_NUM_max;
%     
%     %%速度成分の分解
%     u = U(Elem_num(i,1:6),1);
%     v = U(NEW_NODE_NUM_max + Elem_num(i,1:6),1);
% 
%     %%対流項
%     fem_kc_mat = FEM_Kc_mat(u,v,i);    
%     femg_Kc_mat(Elem_num(i,1:6),Elem_num(i,1:6)) = femg_Kc_mat(Elem_num(i,1:6),Elem_num(i,1:6)) + fem_kc_mat(1:6,1:6);
% end

%% 一括で組み立てる方法

% ELEM_NUM_max is the number of local stiffness matrices
all_stiff = zeros(ELEM_NUM_max,36);

for i=1:ELEM_NUM_max
    
    %%速度成分の分解
    u = U(Elem_num(i,1:6),1);
    v = U(NEW_NODE_NUM_max + Elem_num(i,1:6),1);

    %%対流項
    fem_kc_mat = FEM_Kc_mat(u,v,i); 
    
	% insert your 1x36 array of stiffness elements
	all_stiff(i,:) = reshape(fem_kc_mat',1,36);
end

all_stiff = reshape(all_stiff',1,36*ELEM_NUM_max);

% here NEW_NODE_NUM_max is the total number of unknowns
femg_Kc_mat = sparse(all_row_ind,all_col_ind,all_stiff,NEW_NODE_NUM_max,NEW_NODE_NUM_max);
