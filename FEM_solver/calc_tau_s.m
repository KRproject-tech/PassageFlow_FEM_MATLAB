%% ���艻�p�����[�^�쐬


for i=1:ELEM_NUM_max 

    %%�ڗ����x�����̕���
    bu = b_U_vec(Elem_num(i,1:6),1);
    bv = b_U_vec(NEW_NODE_NUM_max + Elem_num(i,1:6),1);
    
    %%�ڗ����ϑ��x�̓��o
    bu_m(i,1) = sum(bu)/length(bu);
    bv_m(i,1) = sum(bv)/length(bv);  
    
end

%%�v�f����
he = 2*sqrt(bu_m.^2 + bv_m.^2).*( abs(bu_m.*FEM_b1 + bv_m.*FEM_c1) + abs(bu_m.*FEM_b2 + bv_m.*FEM_c2)...
                + abs(bu_m.*FEM_b3 + bv_m.*FEM_c3)).^-1*2.*S;
            
%%���艻�p�����[�^�̌v�Z
tau_s = ( 4/d_Time^2 + 4*(bu_m.^2 + bv_m.^2)./he.^2 + 16*nu^2./he.^4 ).^-0.5;