%% 安定化パラメータ作成


for i=1:ELEM_NUM_max 

    %%移流速度成分の分解
    bu = b_U_vec(Elem_num(i,1:6),1);
    bv = b_U_vec(NEW_NODE_NUM_max + Elem_num(i,1:6),1);
    
    %%移流平均速度の導出
    bu_m(i,1) = sum(bu)/length(bu);
    bv_m(i,1) = sum(bv)/length(bv);  
    
end

%%要素長さ
he = 2*sqrt(bu_m.^2 + bv_m.^2).*( abs(bu_m.*FEM_b1 + bv_m.*FEM_c1) + abs(bu_m.*FEM_b2 + bv_m.*FEM_c2)...
                + abs(bu_m.*FEM_b3 + bv_m.*FEM_c3)).^-1*2.*S;
            
%%安定化パラメータの計算
tau_s = ( 4/d_Time^2 + 4*(bu_m.^2 + bv_m.^2)./he.^2 + 16*nu^2./he.^4 ).^-0.5;