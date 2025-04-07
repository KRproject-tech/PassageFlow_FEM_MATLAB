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
EXE_flag=0;%境界条件の確認，0:外部グラフ，1:内部グラフ
GUI_plot_flag=0;%読み込みデータ表示，0:外部グラフ，1:内部グラフ
LOAD_mesh=0;%読み込みファイル名選択, 0:'Fluid.VOR', 1:'n(整数).VOR'

%% マルチスレッド設定
maxNumCompThreads(12);%core i7 3970X: core 6/12

%% parameter setting
param_setting;

%% メッシュデータ読み込み
load_p;

%% fem解析
const_MAT;%部分マトリクス構成
const_supg_MAT;%SUPG項用定数マトリクス作成

const_Convect;%対流項マトリクス構成
const_supg_Convect;%SUPG対流項マトリクス構成
const_supg_Diff;%SUPG拡散項マトリクス構成
const_supg_Pxy;%SUPG圧力項マトリクス構成

const_F2;%境界条件マトリクス構成
const_Global;%グローバルマトリクス組立（線形部分）
const_BC;% B.C.計算
time_evolution;


delete handles.mat