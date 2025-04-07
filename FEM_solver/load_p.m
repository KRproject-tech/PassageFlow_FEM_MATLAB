%%   ���b�V���f�[�^��load�C�m�F   %%
global GUI_plot_flag LOAD_mesh file_num_gap NEW_NODE_NUM_max NODE_NUM_max ELEM_NUM_max  Elem_num;

%% ���b�V���f�[�^�ǂݍ���
if LOAD_mesh == 1
    fp0 = fopen([num2str(file_num_gap),'.VOR'],'r');
else
    fp0 = fopen('Fluid.VOR','r');
end

%%�m�[�h���W�ǂݍ���
% �_�~�[���[�h
dummy = textscan(fp0, '%s\n');
dummy = textscan(fp0, '%s %s %s\n');
dummy = textscan(fp0, '%s %s %s\n');
% �m�[�h�ԍ� ���W
node_xy = textscan(fp0, '%f %f %f');%[mm]
Node_xy = cell2mat({node_xy{2} node_xy{3}})*1e-3;%[m]


%%�v�f�ԍ��ǂݍ���
% �_�~�[���[�h
dummy = textscan(fp0, '%s %s %s\n');
% �v�f�ԍ�
elem_num = textscan(fp0, '%f %f %f');
Elem_num =  cell2mat(elem_num);


%%�֊s�w��_�̏o��
% �_�~�[���[�h
dummy = textscan(fp0, '%s\n');
dummy = textscan(fp0, '%s %s %s\n');
% �֊s�w��_���W
line_xy = textscan(fp0, '%f %f %f');


%%�֊s����̃f�[�^�o��
% �_�~�[���[�h
dummy = textscan(fp0, '%s\n');
dummy = textscan(fp0, '%s %s %s\n');
% �֊s�w��_���W
on_line_xy = textscan(fp0, '%f %f %f');
On_line_xy = cell2mat({on_line_xy{2} on_line_xy{3}});%[-]


if GUI_plot_flag == 1 
    axes(handles.axes3)%GUI plot
    plot(node_xy{2},node_xy{3},'Marker','.','LineStyle','none');
    axes(handles.axes4)%GUI plot
    plot(line_xy{2},line_xy{3},'Marker','.');
    axes(handles.axes5)%GUI plot
    plot(on_line_xy{2},on_line_xy{3},'Marker','.');
else
    figure(1);
    %%�v�f�ԍ��ǂݍ���
    subplot(3,1,1);%1�s3��̃O���t�z��ŕ����\��
    plot(node_xy{2},node_xy{3},'Marker','.','LineStyle','none');
    %%�֊s�w��_�̏o��
    subplot(3,1,2);
    plot(line_xy{2},line_xy{3},'Marker','.');
    %%�֊s����̃f�[�^�o��
    subplot(3,1,3);
    plot(on_line_xy{2},on_line_xy{3},'Marker','.');
end
ELEM_NUM_max = length(Elem_num(:,1));
NODE_NUM_max = length(Node_xy(:,1));
ON_NUM_max = length(On_line_xy(:,1));

%% 2���O�p�`�v�f�ɕ⊮
h = waitbar(0,'Creating nodes...'); 
new_node_num = NODE_NUM_max+1;
n_num=1;
Node_num_hold(n_num,:) = zeros(1,2);
hold_n_num12=0;
hold_n_num23=0;
hold_n_num31=0;
flag_12=1;
flag_23=1;
flag_31=1;
for i=1:1:ELEM_NUM_max    

    for j=1:n_num-1        
        if ~isempty(find(Node_num_hold(j,:) == Elem_num(i,1),1)) && ~isempty(find(Node_num_hold(j,:) == Elem_num(i,2),1))
            flag_12 = 0;
            hold_n_num12 = j+NODE_NUM_max;
            break;
        else
            flag_12 = 1;
        end
    end
    for j=1:n_num-1
        if ~isempty(find(Node_num_hold(j,:) == Elem_num(i,2),1)) && ~isempty(find(Node_num_hold(j,:) == Elem_num(i,3),1))
            flag_23 = 0;
            hold_n_num23 = j+NODE_NUM_max;
            break;
        else
            flag_23 = 1;
        end
    end
    for j=1:n_num-1
        if ~isempty(find(Node_num_hold(j,:) == Elem_num(i,3),1)) && ~isempty(find(Node_num_hold(j,:) == Elem_num(i,1),1))
            flag_31 = 0;
            hold_n_num31 = j+NODE_NUM_max;
            break;
        else
            flag_31 = 1;
        end
    end
    if flag_12 == 1 %�ߓ_���d�����Ȃ�����
        Elem_num(i,4) = new_node_num;
        Node_xy(new_node_num,:) = (Node_xy(Elem_num(i,1),:) + Node_xy(Elem_num(i,2),:))/2;
        Node_num_hold(n_num,:) = [Elem_num(i,1) Elem_num(i,2)];        
        new_node_num = new_node_num+1;
        n_num = n_num+1;
    else
        Elem_num(i,4) = hold_n_num12;
    end
    if flag_23 == 1 %�ߓ_���d�����Ȃ�����
        Elem_num(i,5) = new_node_num;
        Node_xy(new_node_num,:) = (Node_xy(Elem_num(i,2),:) + Node_xy(Elem_num(i,3),:))/2;
        Node_num_hold(n_num,:) = [Elem_num(i,2) Elem_num(i,3)];        
        new_node_num = new_node_num+1;
        n_num = n_num+1;
    else   
        Elem_num(i,5) = hold_n_num23;
    end
    if flag_31 == 1 %�ߓ_���d�����Ȃ�����
        Elem_num(i,6) = new_node_num;
        Node_xy(new_node_num,:) = (Node_xy(Elem_num(i,3),:) + Node_xy(Elem_num(i,1),:))/2;
        Node_num_hold(n_num,:) = [Elem_num(i,3) Elem_num(i,1)];        
        new_node_num = new_node_num+1;
        n_num = n_num+1;
    else
        Elem_num(i,6) = hold_n_num31;
    end

    flag_12=0;
    flag_23=0;
    flag_31=0;
    
    waitbar(i/ELEM_NUM_max);  
    
end
NEW_NODE_NUM_max = new_node_num - 1;
close(h);


%% ���b�V���\��


if GUI_plot_flag == 1
    axes(handles.axes2)%GUI plot
    hold off;
else
    figure(2);
end
set(gcf,'Renderer','OpenGL');

%% ���E�ʁE���ԓ_�\�� 
elem_x_max = max(Node_xy(:,1));
elem_x_min = min(Node_xy(:,1));
elem_y_max = max(Node_xy(:,2));
elem_y_min = min(Node_xy(:,2));
for i=1:1:ELEM_NUM_max;
    color = 'b-';
    inlet=0;
    outlet=0;
            
    %% ���E���o
    Boundary;
    
    if inlet == 1;
        color = 'g-';
    elseif outlet == 1;
        color = 'r-';
    end
    
    %%�v�f���C���`��
    plot( [Node_xy(Elem_num(i,1),1) Node_xy(Elem_num(i,2),1)], [Node_xy(Elem_num(i,1),2) Node_xy(Elem_num(i,2),2)],color);
    hold on;
    plot( [Node_xy(Elem_num(i,2),1) Node_xy(Elem_num(i,3),1)], [Node_xy(Elem_num(i,2),2) Node_xy(Elem_num(i,3),2)],color);
    hold on;
    plot( [Node_xy(Elem_num(i,3),1) Node_xy(Elem_num(i,1),1)], [Node_xy(Elem_num(i,3),2) Node_xy(Elem_num(i,1),2)],color);
    hold on;
    
    %%���Ԑߓ_�`��
    if GUI_plot_flag ~= 1
        plot( Node_xy(Elem_num(i,4),1) ,Node_xy(Elem_num(i,4),2),color,'Marker','.');
        hold on;
        plot( Node_xy(Elem_num(i,5),1) ,Node_xy(Elem_num(i,5),2),color,'Marker','.');
        hold on;
        plot( Node_xy(Elem_num(i,6),1) ,Node_xy(Elem_num(i,6),2),color,'Marker','.');
        hold on;
    end
    
end
fclose(fp0);

