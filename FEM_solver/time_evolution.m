global F_f C_L C_D d_Time;

GLOBAL_MATRIX_NUM = 2*NEW_NODE_NUM_max + NODE_NUM_max;

%% 非線形項のグローバル行列の行・列のindexを生成
const_sparse_row_col_data;

%% 線形解（ストークス方程式）を初期値とする
U_vec = full(G_KL\G_F);

%% 刻み時間決定
      
%%各要素の代表寸法取得
L_bc = min( sqrt( (Node_xy(Elem_num(1:ELEM_NUM_max,1),1)-Node_xy(Elem_num(1:ELEM_NUM_max,2),1)).^2 ...
            + (Node_xy(Elem_num(1:ELEM_NUM_max,1),2)-Node_xy(Elem_num(1:ELEM_NUM_max,2),2) ).^2) );
% d_Time = L_bc/norm([u_w v_w]);%%クーラン数: 陰解法では常に安定性

%% 時間発展
itime = 1;
old_U_vec = U_vec;
% U_VEC(:,itime) = U_vec;

if GUI_plot_flag == 0 
    figure(50);
    axes1 = axes;
    set(axes1, 'drawmode', 'fast');
    scrsz = get(0, 'ScreenSize');    % スクリーンサイズの取得
    % Figureウインドウの位置とサイズのデフォルト
    set(0, 'defaultFigurePosition', [200 scrsz(4)-1200 2*480 3*360]);
end

F_f = [0 0]';%初期化
for Time=0:d_Time:Time_max
    tic;
    
    
    %%%%%%%%%%%%%%%%%%%%%%% SUPG項用の安定化パラメータ計算 %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% 移流速度の予測
    b_U_vec = 3/2*U_vec - 1/2*old_U_vec;
    calc_tau_s;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%　非線形項の計算 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    G_K1 = G_K(b_U_vec);%移流項
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% SUPG法の計算  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    calc_SUPG;
    G_M_h = G_M + G_M_s;
    G_K_h = G_K1 + G_Kc_s;     
    
    %%%%%%%%%%%%%%%%%%%%%%%%%% 非線形項の境界条件 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    row_elem = diag_elem;
    G_M_h(row_elem,:) = 0;%u & v & p
    
    %%%%%%%%%%%%%%%%%%%%%%流入の境界条件/内部物体の速度境界条件/流出の境界条件(p=0)
    G_K_h(row_elem,:) = 0;%u        

    
    G_K_h = G_K_h + hG_K;    %%対角成分を1にする．
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 時間発展 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    old_U_vec = U_vec;
%     U_vec(:,itime+1) = full((G_M + d_Time/2*G_K_h)\((G_M - d_Time/2*G_K_h)*U_vec(:,itime) + d_Time*G_F));     %直接法(クランク・ニコルソン法)
    new_U = full((G_M_h + d_Time*G_K_h)\(G_M_h*U_vec + d_Time*G_F));     %直接法(陰解法)    
    
    %%　流速分布描画  
%     plot_values;
    if mod(itime,5) == 0
        plot_values2;
    end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 流体力算出%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    calc_F_f;    

    itime = itime + 1;
    %% 状態量更新
%     U_VEC(:,itime) = new_U;%時刻歴保存
    U_vec = new_U;%メモリ節約
    
    display(Time);
    if GUI_plot_flag == 1 
        set(handles.time_tag,'String',num2str(Time));
    end
    
    toc;
end

%% 揚力・抗力係数算出
C_L = 2*sum(F_f(1,:))/length(F_f(1,:))/(rho*u_w^2*S_area);
C_D = 2*-sum(F_f(2,:))/length(F_f(2,:))/(rho*u_w^2*S_area);

