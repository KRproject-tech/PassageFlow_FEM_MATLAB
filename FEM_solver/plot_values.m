%% �`��

figure(50);
scrsz = get(0, 'ScreenSize');    % �X�N���[���T�C�Y�̎擾
% Figure�E�C���h�E�̈ʒu�ƃT�C�Y�̃f�t�H���g
set(0, 'defaultFigurePosition', [900 scrsz(4)-900 2*480 2*360]);

%%�����ʕ���
u_vec = new_U(1:NEW_NODE_NUM_max);
v_vec = new_U(NEW_NODE_NUM_max+1:2*NEW_NODE_NUM_max);
pressure = new_U(2*NEW_NODE_NUM_max+1:GLOBAL_MATRIX_NUM);

%u
subplot(3,1,1)
tri = delaunay(Node_xy(1:NEW_NODE_NUM_max,1), Node_xy(1:NEW_NODE_NUM_max,2));
trisurf(tri, Node_xy(1:NEW_NODE_NUM_max,1), Node_xy(1:NEW_NODE_NUM_max,2), u_vec ,'FaceColor','interp','Marker','o','MarkerEdgeColor','none','LineStyle','none');%�}�[�J�[��`���ƂȂ����֊s���͂����肷��D
colorbar
% axis equal%���Ԋu�̖ڐ�
view(2) %2D���_

%v
subplot(3,1,2)
tri = delaunay(Node_xy(1:NEW_NODE_NUM_max,1), Node_xy(1:NEW_NODE_NUM_max,2));
trisurf(tri, Node_xy(1:NEW_NODE_NUM_max,1), Node_xy(1:NEW_NODE_NUM_max,2), v_vec ,'FaceColor','interp','Marker','o','MarkerEdgeColor','none','LineStyle','none' );%�}�[�J�[��`���ƂȂ����֊s���͂����肷��D
colorbar
% axis equal%���Ԋu�̖ڐ�
view(2) %2D���_


subplot(3,1,3)
%p
tri = delaunay(Node_xy(1:NODE_NUM_max,1), Node_xy(1:NODE_NUM_max,2));
trisurf(tri, Node_xy(1:NODE_NUM_max,1), Node_xy(1:NODE_NUM_max,2), pressure ,'FaceColor','interp','Marker','o','MarkerEdgeColor','none' ,'LineStyle','none' );%�}�[�J�[��`���ƂȂ����֊s���͂����肷��D
colorbar
% axis equal%���Ԋu�̖ڐ�
view(2) %2D���_   

drawnow;


figure(55);
% Figure�E�C���h�E�̈ʒu�ƃT�C�Y�̃f�t�H���g
set(0, 'defaultFigurePosition', [200 scrsz(4)-1200 2*480 3*360]);

%���x��x�N�g��
quiver(Node_xy(1:NEW_NODE_NUM_max,1),Node_xy(1:NEW_NODE_NUM_max,2),u_vec(1:length(u_vec)),v_vec(1:length(v_vec)));
% axis equal   %���Ԋu�̖ڐ� 
drawnow;