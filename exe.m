clc
clear all
% close all hidden

%% Path
addpath(genpath('.\FEM_solver'));
addpath(genpath('.\FEM_solver\SUPG'));
addpath(genpath('.\MEX_folder'));
addpath(genpath('.\tensor_toolbox'));
addpath(genpath('.\tensor_toolbox\met')); %<-- Add the tensor toolbox to the MATLAB path
addpath(genpath('.\FEM_solver\HS_nonlinear'));
 

handles=0;
EXE_flag=0;%���E�����̊m�F�C0:�O���O���t�C1:�����O���t
GUI_plot_flag=0;%�ǂݍ��݃f�[�^�\���C0:�O���O���t�C1:�����O���t
LOAD_mesh=0;%�ǂݍ��݃t�@�C�����I��, 0:'Fluid.VOR', 1:'n(����).VOR'

%% �}���`�X���b�h�ݒ�
maxNumCompThreads(12);%core i7 3970X: core 6/12

%% parameter setting
param_setting;

%% ���b�V���f�[�^�ǂݍ���
load_p;

%% fem���
const_MAT;%�����}�g���N�X�\��
const_supg_MAT;%SUPG���p�萔�}�g���N�X�쐬

const_Convect;%�Η����}�g���N�X�\��
const_supg_Convect;%SUPG�Η����}�g���N�X�\��
const_supg_Diff;%SUPG�g�U���}�g���N�X�\��
const_supg_Pxy;%SUPG���͍��}�g���N�X�\��

const_F2;%���E�����}�g���N�X�\��
const_Global;%�O���[�o���}�g���N�X�g���i���`�����j
const_BC;% B.C.�v�Z
time_evolution;


delete handles.mat