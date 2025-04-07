global F_f C_L C_D d_Time;

GLOBAL_MATRIX_NUM = 2*NEW_NODE_NUM_max + NODE_NUM_max;

%% ����`���̃O���[�o���s��̍s�E���index�𐶐�
const_sparse_row_col_data;

%% ���`���i�X�g�[�N�X�������j�������l�Ƃ���
U_vec = full(G_KL\G_F);

%% ���ݎ��Ԍ���
      
%%�e�v�f�̑�\���@�擾
L_bc = min( sqrt( (Node_xy(Elem_num(1:ELEM_NUM_max,1),1)-Node_xy(Elem_num(1:ELEM_NUM_max,2),1)).^2 ...
            + (Node_xy(Elem_num(1:ELEM_NUM_max,1),2)-Node_xy(Elem_num(1:ELEM_NUM_max,2),2) ).^2) );
% d_Time = L_bc/norm([u_w v_w]);%%�N�[������: �A��@�ł͏�Ɉ��萫

%% ���Ԕ��W
itime = 1;
old_U_vec = U_vec;
% U_VEC(:,itime) = U_vec;

if GUI_plot_flag == 0 
    figure(50);
    axes1 = axes;
    set(axes1, 'drawmode', 'fast');
    scrsz = get(0, 'ScreenSize');    % �X�N���[���T�C�Y�̎擾
    % Figure�E�C���h�E�̈ʒu�ƃT�C�Y�̃f�t�H���g
    set(0, 'defaultFigurePosition', [200 scrsz(4)-1200 2*480 3*360]);
end

F_f = [0 0]';%������
for Time=0:d_Time:Time_max
    tic;
    
    
    %%%%%%%%%%%%%%%%%%%%%%% SUPG���p�̈��艻�p�����[�^�v�Z %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% �ڗ����x�̗\��
    b_U_vec = 3/2*U_vec - 1/2*old_U_vec;
    calc_tau_s;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%�@����`���̌v�Z %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    G_K1 = G_K(b_U_vec);%�ڗ���
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% SUPG�@�̌v�Z  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    calc_SUPG;
    G_M_h = G_M + G_M_s;
    G_K_h = G_K1 + G_Kc_s;     
    
    %%%%%%%%%%%%%%%%%%%%%%%%%% ����`���̋��E���� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    row_elem = diag_elem;
    G_M_h(row_elem,:) = 0;%u & v & p
    
    %%%%%%%%%%%%%%%%%%%%%%�����̋��E����/�������̂̑��x���E����/���o�̋��E����(p=0)
    G_K_h(row_elem,:) = 0;%u        

    
    G_K_h = G_K_h + hG_K;    %%�Ίp������1�ɂ���D
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ���Ԕ��W %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    old_U_vec = U_vec;
%     U_vec(:,itime+1) = full((G_M + d_Time/2*G_K_h)\((G_M - d_Time/2*G_K_h)*U_vec(:,itime) + d_Time*G_F));     %���ږ@(�N�����N�E�j�R���\���@)
    new_U = full((G_M_h + d_Time*G_K_h)\(G_M_h*U_vec + d_Time*G_F));     %���ږ@(�A��@)    
    
    %%�@�������z�`��  
%     plot_values;
    if mod(itime,5) == 0
        plot_values2;
    end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ���̗͎Z�o%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    calc_F_f;    

    itime = itime + 1;
    %% ��ԗʍX�V
%     U_VEC(:,itime) = new_U;%������ۑ�
    U_vec = new_U;%�������ߖ�
    
    display(Time);
    if GUI_plot_flag == 1 
        set(handles.time_tag,'String',num2str(Time));
    end
    
    toc;
end

%% �g�́E�R�͌W���Z�o
C_L = 2*sum(F_f(1,:))/length(F_f(1,:))/(rho*u_w^2*S_area);
C_D = 2*-sum(F_f(2,:))/length(F_f(2,:))/(rho*u_w^2*S_area);

