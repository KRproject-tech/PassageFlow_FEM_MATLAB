global EXE_flag u_in_value;

%% 境界線上の要素抽出    %%
if EXE_flag == 1
    axes(handles.axes6);
    hold off;
else
    figure(3)
end

%% 境界条件代入
if EXE_flag == 1
    u_w = u_in_value;
end


q1_i=sparse(6,ELEM_NUM_max);%N.S.eq. x成分の流入境界条件
q2_i=sparse(6,ELEM_NUM_max);%N.S.eq. y成分の流入境界条件
q3_i=sparse(3,ELEM_NUM_max);%連続の式の境界条件

%% 節点値指定境界条件用の配列
h_num = 1;%p=0の境界条件（流出境界条件）のノード番号保管配列のカウント
hold_num = 0;%p=0のノード番号保管配列

h_num_v = 1;%u=1,v=0の境界条件（流入境界条件）のノード番号保管配列のカウント
hold_num_v = 0;%u=1,v=0の境界条件（流入境界条件）のノード番号保管配列

h_num_v2 = 1;%内部物体の境界条件（粘着境界条件）のノード番号保管配列のカウント
hold_num_v2 = 0;%内部物体の境界条件（粘着境界条件）のノード番号保管配列

h_numff = 1;%内部物体の面要素(n*dS)とノード番号の保管配列のカウント
hold_ff = zeros(3,1);%内部物体の面要素(n*dS)とノード番号の保管配列

pl_num = 1;

%% 境界抽出
for i=1:1:ELEM_NUM_max;
    j=1;
    j_max=1;
    %%各境界線上の要素を表示
    while j_max < ON_NUM_max;  
        j=j_max;            

            
            %境界線上のノードで構成された辺を含む三角要素
            if ~isempty(find(Elem_num(i,:) == on_line_xy{1}(j),1)) && ~isempty(find(Elem_num(i,:) == on_line_xy{1}(j+1),1))
                 
                
                inlet=0;
                outlet=0;
                %% 境界要素の抽出(inlet, outlet)
                Boundary;
                
                
                
                if EXE_flag == 1                    
                else
                	subplot(2,1,1);
                end               
                    
                %推進体断面と流路の境界                               
                    
                    %%三角要素に対する境界線の位置関係                     
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%節点1-2が境界線上
                    if ~isempty(find( on_line_xy{1} == Elem_num(i,1),1)) && ~isempty(find( on_line_xy{1} == Elem_num(i,2),1))                     
                        l_bc = norm(Node_xy(Elem_num(i,1),:)-Node_xy(Elem_num(i,2),:));   

                        lnx12 = Node_xy(Elem_num(i,2),2)-Node_xy(Elem_num(i,1),2);
                        lny12 = Node_xy(Elem_num(i,1),1)-Node_xy(Elem_num(i,2),1);

                        if inlet == 1  

                            q1_i(:,i) = nu*du_dn*l_bc*[1/6 1/6 0 4/6 0 0]';
                            q2_i(:,i) = nu*dv_dn*l_bc*[1/6 1/6 0 4/6 0 0]';
                            q3_i(:,i) = [u_w*(1/6 + 1/3)*lnx12 + v_w*(1/6 + 1/3)*lny12;
                                         u_w*(1/6 + 1/3)*lnx12 + v_w*(1/6 + 1/3)*lny12;
                                         0];

                            %%流入速度ベクトル表示
                            quiver( Node_xy(Elem_num(i,1),1), Node_xy(Elem_num(i,1),2), u_w, v_w,'r-');
                            hold on; 
                            quiver( Node_xy(Elem_num(i,2),1), Node_xy(Elem_num(i,2),2), u_w, v_w,'r-');
                            hold on; 
                            quiver( Node_xy(Elem_num(i,4),1), Node_xy(Elem_num(i,4),2), u_w, v_w,'r-');
                            hold on;

                            %%流速値指定
                            hold_num_v(h_num_v) = Elem_num(i,1);
                            hold_num_v(h_num_v+1) = Elem_num(i,2);
                            hold_num_v(h_num_v+2) = Elem_num(i,4);
                            h_num_v = h_num_v+3;

                        elseif outlet == 1;

                            %%圧力値指定
                            hold_num(h_num) = Elem_num(i,1);
                            hold_num(h_num+1) = Elem_num(i,2);
                            h_num = h_num+2;

                        else
                            %% 流体中物体
                            q1_i(:,i) = nu*du_dn*l_bc*[1/6 1/6 0 4/6 0 0]';
                            q2_i(:,i) = nu*dv_dn*l_bc*[1/6 1/6 0 4/6 0 0]';
                            q3_i(:,i) = [u_w_obj*(1/6 + 1/3)*lnx12 + v_w_obj*(1/6 + 1/3)*lny12;
                                         u_w_obj*(1/6 + 1/3)*lnx12 + v_w_obj*(1/6 + 1/3)*lny12;
                                         0];

                            %%流入速度ベクトル表示
%                             quiver( Node_xy(Elem_num(i,1),1), Node_xy(Elem_num(i,1),2), u_w_obj, v_w_obj,'r-');
%                             hold on; 
%                             quiver( Node_xy(Elem_num(i,2),1), Node_xy(Elem_num(i,2),2), u_w_obj, v_w_obj,'r-');
%                             hold on; 
%                             quiver( Node_xy(Elem_num(i,4),1), Node_xy(Elem_num(i,4),2), u_w_obj, v_w_obj,'r-');
%                             hold on;
                            
                            plot( Node_xy(Elem_num(i,1),1), Node_xy(Elem_num(i,1),2),'Marker','o');
                            hold on; 
                            plot( Node_xy(Elem_num(i,2),1), Node_xy(Elem_num(i,2),2),'Marker','o');
                            hold on; 
                            plot( Node_xy(Elem_num(i,4),1), Node_xy(Elem_num(i,4),2),'Marker','o');
                            hold on;

                            %%流速値指定
                            hold_num_v2(h_num_v2,:) = Elem_num(i,1);
                            hold_num_v2(h_num_v2+1,:) = Elem_num(i,2);
                            hold_num_v2(h_num_v2+2,:) = Elem_num(i,4);
                            h_num_v2 = h_num_v2+3;
                            
                            %%表面の微小面積と法線ベクトルの積を格納 (この値と圧力の積が流体力ベクトルとなる)
                            hold_ff(:,h_numff) = [ [0 -1;1 0]*(Node_xy(Elem_num(i,1),:) - Node_xy(Elem_num(i,2),:))';
                                                    Elem_num(i,1)];
                            h_numff = h_numff+1;
                        end

                        %境界線表示                    
                        plot( [Node_xy(Elem_num(i,1),1) Node_xy(Elem_num(i,2),1)], [Node_xy(Elem_num(i,1),2) Node_xy(Elem_num(i,2),2)],'-');
                        hold on;
                   
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%節点2-3が境界線上
                    elseif ~isempty(find( on_line_xy{1} == Elem_num(i,2),1)) && ~isempty(find( on_line_xy{1} == Elem_num(i,3),1))
                        l_bc = norm(Node_xy(Elem_num(i,2),:)-Node_xy(Elem_num(i,3),:));

                        lnx23 = Node_xy(Elem_num(i,3),2)-Node_xy(Elem_num(i,2),2);
                        lny23 = Node_xy(Elem_num(i,2),1)-Node_xy(Elem_num(i,3),1);

                        if inlet == 1; 

                            q1_i(:,i) = nu*du_dn*l_bc*[0 1/6 1/6 0 4/6 0]';
                            q2_i(:,i) = nu*dv_dn*l_bc*[0 1/6 1/6 0 4/6 0]';
                            q3_i(:,i) = [0;
                                         u_w*(1/6 + 1/3)*lnx23 + v_w*(1/6 + 1/3)*lny23;
                                         u_w*(1/6 + 1/3)*lnx23 + v_w*(1/6 + 1/3)*lny23];

                            %%流入速度ベクトル表示
                            quiver( Node_xy(Elem_num(i,2),1), Node_xy(Elem_num(i,2),2), u_w, v_w,'r-');
                            hold on; 
                            quiver( Node_xy(Elem_num(i,3),1), Node_xy(Elem_num(i,3),2), u_w, v_w,'r-');
                            hold on; 
                            quiver( Node_xy(Elem_num(i,5),1), Node_xy(Elem_num(i,5),2), u_w, v_w,'r-');
                            hold on; 

                            %%流速値指定
                            hold_num_v(h_num_v) = Elem_num(i,2);
                            hold_num_v(h_num_v+1) = Elem_num(i,3);
                            hold_num_v(h_num_v+2) = Elem_num(i,5);
                            h_num_v = h_num_v+3;

                        elseif outlet == 1;   

                            %%圧力値指定
                            hold_num(h_num) = Elem_num(i,2);
                            hold_num(h_num+1) = Elem_num(i,3);
                            h_num = h_num+2;

                       else
                            %% 流体中物体
                            q1_i(:,i) = nu*du_dn*l_bc*[0 1/6 1/6 0 4/6 0]';
                            q2_i(:,i) = nu*dv_dn*l_bc*[0 1/6 1/6 0 4/6 0]';
                            q3_i(:,i) = [0;
                                         u_w_obj*(1/6 + 1/3)*lnx23 + v_w_obj*(1/6 + 1/3)*lny23;
                                         u_w_obj*(1/6 + 1/3)*lnx23 + v_w_obj*(1/6 + 1/3)*lny23];

                            %%流入速度ベクトル表示
%                             quiver( Node_xy(Elem_num(i,2),1), Node_xy(Elem_num(i,2),2), u_w_obj, v_w_obj,'r-');
%                             hold on; 
%                             quiver( Node_xy(Elem_num(i,3),1), Node_xy(Elem_num(i,3),2), u_w_obj, v_w_obj,'r-');
%                             hold on; 
%                             quiver( Node_xy(Elem_num(i,5),1), Node_xy(Elem_num(i,5),2), u_w_obj, v_w_obj,'r-');
%                             hold on; 

                            plot( Node_xy(Elem_num(i,2),1), Node_xy(Elem_num(i,2),2),'Marker','o');
                            hold on; 
                            plot( Node_xy(Elem_num(i,3),1), Node_xy(Elem_num(i,3),2),'Marker','o');
                            hold on; 
                            plot( Node_xy(Elem_num(i,5),1), Node_xy(Elem_num(i,5),2),'Marker','o');

                            %%流速値指定
                            hold_num_v2(h_num_v2,:) = Elem_num(i,2);
                            hold_num_v2(h_num_v2+1,:) = Elem_num(i,3);
                            hold_num_v2(h_num_v2+2,:) = Elem_num(i,5);
                            h_num_v2 = h_num_v2+3;
                            
                            %%表面の微小面積と法線ベクトルの積を格納 (この値と圧力の積が流体力ベクトルとなる)
                            hold_ff(:,h_numff) = [ [0 -1;1 0]*(Node_xy(Elem_num(i,2),:) - Node_xy(Elem_num(i,3),:))';
                                                    Elem_num(i,2)];
                            h_numff = h_numff+1;
                            
                        end

                        %境界線表示
                        plot( [Node_xy(Elem_num(i,2),1) Node_xy(Elem_num(i,3),1)], [Node_xy(Elem_num(i,2),2) Node_xy(Elem_num(i,3),2)],'-');
                        hold on;
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%節点3-1が境界線上
                    elseif ~isempty(find( on_line_xy{1} == Elem_num(i,3),1)) && ~isempty(find( on_line_xy{1} == Elem_num(i,1),1))
                        l_bc = norm(Node_xy(Elem_num(i,3),:)-Node_xy(Elem_num(i,1),:)); 

                        lnx31 = Node_xy(Elem_num(i,1),2)-Node_xy(Elem_num(i,3),2);
                        lny31 = Node_xy(Elem_num(i,3),1)-Node_xy(Elem_num(i,1),1);

                        if inlet == 1;  

                            q1_i(:,i) = nu*du_dn*l_bc*[1/6 0 1/6 0 0 4/6]'; 
                            q2_i(:,i) = nu*dv_dn*l_bc*[1/6 0 1/6 0 0 4/6]'; 
                            q3_i(:,i) = [u_w*(1/6 + 1/3)*lnx31 + v_w*(1/6 + 1/3)*lny31;
                                         0;
                                         u_w*(1/6 + 1/3)*lnx31 + v_w*(1/6 + 1/3)*lny31];

                            %%流入速度ベクトル表示
                            quiver( Node_xy(Elem_num(i,1),1), Node_xy(Elem_num(i,1),2), u_w, v_w,'r-');
                            hold on; 
                            quiver( Node_xy(Elem_num(i,3),1), Node_xy(Elem_num(i,3),2), u_w, v_w,'r-');
                            hold on; 
                            quiver( Node_xy(Elem_num(i,6),1), Node_xy(Elem_num(i,6),2), u_w, v_w,'r-');
                            hold on;

                            %%流速値指定
                            hold_num_v(h_num_v) = Elem_num(i,3);
                            hold_num_v(h_num_v+1) = Elem_num(i,1);
                            hold_num_v(h_num_v+2) = Elem_num(i,6);
                            h_num_v = h_num_v+3;

                        elseif outlet == 1;  

                            %%圧力値指定
                            hold_num(h_num) = Elem_num(i,3);
                            hold_num(h_num+1) = Elem_num(i,1);
                            h_num = h_num+2;   

                        else
                            %% 流体中物体
                            q1_i(:,i) = nu*du_dn*l_bc*[1/6 0 1/6 0 0 4/6]';
                            q2_i(:,i) = nu*dv_dn*l_bc*[1/6 0 1/6 0 0 4/6]';
                            q3_i(:,i) = [u_w_obj*(1/6 + 1/3)*lnx31 + v_w_obj*(1/6 + 1/3)*lny31;
                                         0;
                                         u_w_obj*(1/6 + 1/3)*lnx31 + v_w_obj*(1/6 + 1/3)*lny31];

                            %%流入速度ベクトル表示
%                             quiver( Node_xy(Elem_num(i,3),1), Node_xy(Elem_num(i,3),2), u_w_obj, v_w_obj,'r-');
%                             hold on; 
%                             quiver( Node_xy(Elem_num(i,1),1), Node_xy(Elem_num(i,1),2), u_w_obj, v_w_obj,'r-');
%                             hold on; 
%                             quiver( Node_xy(Elem_num(i,6),1), Node_xy(Elem_num(i,6),2), u_w_obj, v_w_obj,'r-');
%                             hold on;

                            plot( Node_xy(Elem_num(i,3),1), Node_xy(Elem_num(i,3),2),'Marker','o');
                            hold on; 
                            plot( Node_xy(Elem_num(i,1),1), Node_xy(Elem_num(i,1),2),'Marker','o');
                            hold on; 
                            plot( Node_xy(Elem_num(i,6),1), Node_xy(Elem_num(i,6),2),'Marker','o');

                            %%流速値指定
                            hold_num_v2(h_num_v2,:) = Elem_num(i,3);
                            hold_num_v2(h_num_v2+1,:) = Elem_num(i,1);
                            hold_num_v2(h_num_v2+2,:) = Elem_num(i,6);
                            h_num_v2 = h_num_v2+3;
                            
                            %%表面の微小面積と法線ベクトルの積を格納 (この値と圧力の積が流体力ベクトルとなる)
                            hold_ff(:,h_numff) = [ [0 -1;1 0]*(Node_xy(Elem_num(i,3),:) - Node_xy(Elem_num(i,1),:))';
                                                    Elem_num(i,3)];
                            h_numff = h_numff+1;                            
                        end

                        %境界線表示
                        plot( [Node_xy(Elem_num(i,3),1) Node_xy(Elem_num(i,1),1)], [Node_xy(Elem_num(i,3),2) Node_xy(Elem_num(i,1),2)],'-');
                        hold on;
                  
                    end 
                
                


                 
                if inlet == 1; 
                    color = 'g-';
                elseif outlet == 1;
                     color = 'r-';
                else
                    color = 'w-';
                end
                            
                if EXE_flag == 1
                else
                        subplot(2,1,2);
                end                   

                %境界近傍の要素のメッシュ表示
                plot( [Node_xy(Elem_num(i,1),1) Node_xy(Elem_num(i,2),1)], [Node_xy(Elem_num(i,1),2) Node_xy(Elem_num(i,2),2)],color);
                hold on;
                plot( [Node_xy(Elem_num(i,2),1) Node_xy(Elem_num(i,3),1)], [Node_xy(Elem_num(i,2),2) Node_xy(Elem_num(i,3),2)],color);
                hold on;
                plot( [Node_xy(Elem_num(i,3),1) Node_xy(Elem_num(i,1),1)], [Node_xy(Elem_num(i,3),2) Node_xy(Elem_num(i,1),2)],color);
                hold on; 
                j=j+1;                  
             end        
            
             
             if j == ON_NUM_max
                 break;
             end             
        
            j_max = j+1; 
    end
    
end