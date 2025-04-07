function varargout = GUI(varargin)
% GUI M-file for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 10-Jan-2013 10:59:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% CREATE MESH
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%pathを通す
addpath(genpath('.\calc_area2\Release'));
addpath(genpath('.\calc_area2\Release\HiMacroEx'));
open('calc_mode(canti_lever).exe');
open('HiMacroEx.exe');
open('voro95.exe');


%% FEA(calculating C_D)
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global EXE_flag GUI_plot_flag LOAD_mesh;
LOAD_mesh = 0;
EXE_flag=1;
GUI_plot_flag=1;

addpath(genpath('.\FEM_solver'));
addpath(genpath('.\FEM_solver\SUPG'));
addpath(genpath('.\FEM_solver\HS_nonlinear'));
addpath(genpath('.\MEX_folder'));
addpath(genpath('.\tensor_toolbox'));
addpath(genpath('.\tensor_toolbox\met')); %<-- Add the tensor toolbox to the MATLAB path

param_setting;
load_p;
%%fem解析
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



%% LOAD MESH
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GUI_plot_flag LOAD_mesh;
LOAD_mesh = 0;
GUI_plot_flag=1;
param_setting;
load_p;


%% CLOSE ALL
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all


%% PARAMETER SETTING
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('param_setting.m');



function C_D_tag_Callback(hObject, eventdata, handles)
% hObject    handle to C_D_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C_D_tag as text
%        str2double(get(hObject,'String')) returns contents of C_D_tag as a double


% --- Executes during object creation, after setting all properties.
function C_D_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_D_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F_D_tag_Callback(hObject, eventdata, handles)
% hObject    handle to F_D_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F_D_tag as text
%        str2double(get(hObject,'String')) returns contents of F_D_tag as a double


% --- Executes during object creation, after setting all properties.
function F_D_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F_D_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%  continuous FEA(calculating C_D)
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
save('handles.mat','handles');
clear all
load handles.mat

global EXE_flag GUI_plot_flag LOAD_mesh file_num_gap u_in_value;
global F_f C_L C_D d_Time;
EXE_flag=1;
GUI_plot_flag=1;
LOAD_mesh=1;

clc
delete g_data.mat

%%pathを通す
addpath(genpath('.\FEM_solver'));
addpath(genpath('.\FEM_solver\SUPG'));
addpath(genpath('.\FEM_solver\HS_nonlinear'));
addpath(genpath('.\MEX_folder'));
addpath(genpath('.\tensor_toolbox'));
addpath(genpath('.\tensor_toolbox\met')); %<-- Add the tensor toolbox to the MATLAB path

%%pathを通す
addpath(genpath('.\calc_area2\Release'));

LIST = ls('calc_area2\Release\*.VOR');%%'VOR'ファイル名を全て取得
LIST = cellstr(LIST);
LIST = regexprep(LIST,'.VOR','');%'.VOR'をNULLで置き換え
LIST = cellstr(LIST);
for i=1:1:length(LIST)
    list_Gap(i) = str2double(LIST{i,1}(1));
end

file_num_gap_max = max(list_Gap);%最大値を取得

%%parameter setting
param_setting;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% すき間幅変化
for file_num_gap=1:1:file_num_gap_max+1
    
    gap_num = 10^((log10(gap_max)-log10(gap_min))*(file_num_gap-1)/(CNT-1) + log10(gap_min));
    Gap_num(file_num_gap) = gap_num;
    
    %%メッシュデータ読み込み
    load_p;
    
	%%fem解析
	const_MAT;%部分マトリクス構成
	const_supg_MAT;%SUPG項用定数マトリクス作成

	const_Convect;%対流項マトリクス構成
	const_supg_Convect;%SUPG対流項マトリクス構成
 	const_supg_Diff;%SUPG拡散項マトリクス構成
	const_supg_Pxy;%SUPG圧力項マトリクス構成
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%　流入流速変化
    for u_num=1:1:u_num_max
        
        %%流入流速更新
        u_in_value = 10^((log10(U_in_max)-log10(U_in_min))*(u_num-1)/(CNT-1) + log10(U_in_min));
        U_in_value(u_num) = u_in_value;

        set(handles.i_num_tag,'String',num2str(file_num_gap));
        set(handles.j_num_tag,'String',num2str(u_num));

        set(handles.U_in_tag,'String',num2str(U_in_value(u_num)));
        set(handles.Gap_width_tag,'String',num2str(gap_num));    
        set(handles.C_D_tag,'String',num2str(C_D));  
        
        
        %% 解析刻み時間設定[s]: 高レイノルズ数領域では短い刻み時間
        d_Time = 10^((log10(0.25e-2) - log10(0.5))/(0.1 - 0.1e-3)*(u_in_value - 0.1e-3) + log10(0.5));


        %%fem解析    
        const_F2;%境界条件マトリクス構成
        const_Global;%グローバルマトリクス組立（線形部分）
        const_BC;% B.C.計算
        time_evolution;          
        
        F_f_h(file_num_gap,u_num) = {F_f};
        C_D_h(file_num_gap,u_num) = C_D;
        C_L_h(file_num_gap,u_num) = C_L;
       
        if file_num_gap == 1
            save('C_D_data','F_f_h','C_D_h','U_in_value','Gap_num','C_L_h');
        end
        save('C_D_data','F_f_h','C_D_h','C_L_h','U_in_value','Gap_num','-append');
        
    end
end


delete handles.mat
LOAD_mesh = 0;





%% テキストボックス

function i_num_tag_Callback(hObject, eventdata, handles)
% hObject    handle to i_num_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of i_num_tag as text
%        str2double(get(hObject,'String')) returns contents of i_num_tag as a double


% --- Executes during object creation, after setting all properties.
function i_num_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to i_num_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function j_num_tag_Callback(hObject, eventdata, handles)
% hObject    handle to j_num_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of j_num_tag as text
%        str2double(get(hObject,'String')) returns contents of j_num_tag as a double


% --- Executes during object creation, after setting all properties.
function j_num_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to j_num_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function U_in_tag_Callback(hObject, eventdata, handles)
% hObject    handle to U_in_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of U_in_tag as text
%        str2double(get(hObject,'String')) returns contents of U_in_tag as a double


% --- Executes during object creation, after setting all properties.
function U_in_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to U_in_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Gap_width_tag_Callback(hObject, eventdata, handles)
% hObject    handle to Gap_width_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Gap_width_tag as text
%        str2double(get(hObject,'String')) returns contents of Gap_width_tag as a double


% --- Executes during object creation, after setting all properties.
function Gap_width_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gap_width_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_tag_Callback(hObject, eventdata, handles)
% hObject    handle to time_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_tag as text
%        str2double(get(hObject,'String')) returns contents of time_tag as a double


% --- Executes during object creation, after setting all properties.
function time_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


