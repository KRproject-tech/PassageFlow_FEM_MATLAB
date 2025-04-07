%% �`��
if GUI_plot_flag == 0 
    figure(50);
end

%%�����ʕ���
u_vec = new_U(1:NEW_NODE_NUM_max);
v_vec = new_U(NEW_NODE_NUM_max+1:2*NEW_NODE_NUM_max);
pressure = new_U(2*NEW_NODE_NUM_max+1:GLOBAL_MATRIX_NUM);

%u
if GUI_plot_flag == 1 
    axes(handles.axes8);
else
    subplot(3,2,1)
end
tri = delaunay(Node_xy(1:NEW_NODE_NUM_max,1), Node_xy(1:NEW_NODE_NUM_max,2));
trisurf(tri, Node_xy(1:NEW_NODE_NUM_max,1), Node_xy(1:NEW_NODE_NUM_max,2), u_vec ,'FaceColor','interp','Marker','o','MarkerEdgeColor','none','LineStyle','none');%�}�[�J�[��`���ƂȂ����֊s���͂����肷��D
colorbar
axis equal%���Ԋu�̖ڐ�
view(2) %2D���_
drawnow;

%v
if GUI_plot_flag == 1 
    axes(handles.axes10);
else
    subplot(3,2,2)
end
tri = delaunay(Node_xy(1:NEW_NODE_NUM_max,1), Node_xy(1:NEW_NODE_NUM_max,2));
trisurf(tri, Node_xy(1:NEW_NODE_NUM_max,1), Node_xy(1:NEW_NODE_NUM_max,2), v_vec ,'FaceColor','interp','Marker','o','MarkerEdgeColor','none','LineStyle','none' );%�}�[�J�[��`���ƂȂ����֊s���͂����肷��D
colorbar
axis equal%���Ԋu�̖ڐ�
view(2) %2D���_
drawnow;

if GUI_plot_flag == 1 
    axes(handles.axes11);
else
    subplot(3,2,3)
end
%p
tri = delaunay(Node_xy(1:NODE_NUM_max,1), Node_xy(1:NODE_NUM_max,2));
trisurf(tri, Node_xy(1:NODE_NUM_max,1), Node_xy(1:NODE_NUM_max,2), pressure ,'FaceColor','interp','Marker','o','MarkerEdgeColor','none' ,'LineStyle','none');%�}�[�J�[��`���ƂȂ����֊s���͂����肷��D
colorbar
axis equal%���Ԋu�̖ڐ�
view(2) %2D���_   
drawnow;

if GUI_plot_flag == 1 
    axes(handles.axes12);
else
    subplot(3,2,5:6)
end
%���x��x�N�g��
quiver(Node_xy(1:NEW_NODE_NUM_max,1),Node_xy(1:NEW_NODE_NUM_max,2),u_vec(1:length(u_vec)),v_vec(1:length(v_vec)));
axis equal   %���Ԋu�̖ڐ� 
drawnow;