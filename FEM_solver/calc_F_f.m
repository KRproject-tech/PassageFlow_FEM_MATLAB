%% ���̗͎Z�o�@(�@�� �P�ʒ���������@)

%%���ӈ��͕��z�v�Z
pressure_r = new_U(2*NEW_NODE_NUM_max+hold_ff(3,:));

%%���̗�
F_f(:,itime) = sum(repmat(pressure_r',2,1).*hold_ff(1:2,:),2);

if EXE_flag == 1
    set(handles.F_D_tag,'String',num2str(F_f(1,itime)));
end