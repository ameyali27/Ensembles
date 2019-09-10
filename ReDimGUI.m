function varargout = ReDimGUI(varargin)
% REDIMGUI MATLAB code for ReDimGUI.fig
%      REDIMGUI, by itself, creates a new REDIMGUI or raises the existing
%      singleton*.
%
%      H = REDIMGUI returns the handle to a new REDIMGUI or the handle to
%      the existing singleton*.
%
%      REDIMGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REDIMGUI.M with the given input arguments.
%
%      REDIMGUI('Property','Value',...) creates a new REDIMGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ReDimGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ReDimGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ReDimGUI

% Last Modified by GUIDE v2.5 10-Sep-2019 11:39:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ReDimGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ReDimGUI_OutputFcn, ...
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


% --- Executes just before ReDimGUI is made visible.
function ReDimGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ReDimGUI (see VARARGIN)


% Choose default command line output for ReDimGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ReDimGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ReDimGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in br_file.
function br_file_Callback(hObject, eventdata, handles)
% hObject    handle to br_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.mat');
%Loading file
myVars = {'Spikes'}; %Changes 'Spikes' by the real name of your matrix
browse = load(file,myVars{:});
handles.browse = browse;
x = handles.browse.Spikes; %Changes 'Spikes' by the real name of your matrix
handles.x = x;
guidata(hObject, handles);



% --- Executes on button press in hiera.
function hiera_Callback(hObject, eventdata, handles)
% hObject    handle to hiera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%data ser hiera

if isfield(handles,'Y_lle') %isfield Determines If Input Names Are Field Names
    Y_lle = handles.Y_lle;
    Y = pdist(Y_lle); %distance values
    Z = linkage(Y,'ward'); %linkage values
    I = inconsistent(Z); %inconsistency values
    % T = clusterdata(x,'Linkage','ward','SaveMemory','on','Maxclust',5);
    % scatter(x(:,1),x(:,2),100,T,'filled')
    c = cluster(Z,'cutoff',1.1,'Criterion','inconsistent'); %none of the links in the cluster hierarchy had an inconsistency coefficient greater than 1.2
    scatter(Y_lle(:,1),Y_lle(:,2),40,c,'filled')
else
    datosPCA = handles.datosPCA;
    Y = pdist(datosPCA); %distance values
    Z = linkage(Y,'ward'); %linkage values
    I = inconsistent(Z); %inconsistency values
%     T = clusterdata(datosPCA,'Linkage','ward','SaveMemory','on','Maxclust',5);
%     scatter(datosPCA(:,1),datosPCA(:,2),40,T,'filled')
    c = cluster(Z,'cutoff',1.1,'Criterion','inconsistent'); %none of the links in the cluster hierarchy had an inconsistency coefficient greater than 1.2
    %Criterion for defining clusters, specified as 'inconsistent' or 'distance'
    scatter(datosPCA(:,1),datosPCA(:,2),40,c,'filled')
    
end

% x = handles.x;
% Y = pdist(x); %distance values
% Z = linkage(Y,'ward'); %linkage values
% I = inconsistent(Z); %inconsistency values
% % T = clusterdata(x,'Linkage','ward','SaveMemory','on','Maxclust',5);
% % scatter(x(:,1),x(:,2),100,T,'filled')
% c = cluster(Z,'Maxclust',3);
% scatter(x(:,1),x(:,2),60,c,'filled')



% --- Executes on button press in km.
function km_Callback(hObject, eventdata, handles)
% hObject    handle to km (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%data set k-means
if isfield(handles,'datosPCA') %isfield Determines If Input Names Are Field Names 
    datosPCA = handles.datosPCA;
    idx =kmeans(datosPCA,2);%datosPCA(:,1:3),2);   
    colores=[0.9290, 0.6940, 0.1250;0.4940, 0.1840, 0.5560;0.4660, 0.6740, 0.1880];
    for n=1:size(datosPCA,1)
        h=plot(datosPCA(n,1),datosPCA(n,2),'+','Color',colores(idx(n),:));hold on
        set(h,'MarkerFaceColor',colores(idx(n),:),'LineWidth',2)
    end
else
    Y_lle = handles.Y_lle;
    idx =kmeans(Y_lle,2);%datosPCA(:,1:3),2);   
    colores=[0.9290, 0.6940, 0.1250;0.4940, 0.1840, 0.5560;0.4660, 0.6740, 0.1880];
    for n=1:size(Y_lle,1)
        h=plot(Y_lle(n,1),Y_lle(n,2),'+','Color',colores(idx(n),:));hold on
        set(h,'MarkerFaceColor',colores(idx(n),:),'LineWidth',2)
    end
    
    
end



% x = handles.x;
% idx =kmeans(x,2);   
% colores=[0.9290, 0.6940, 0.1250;0.4940, 0.1840, 0.5560;0.4660, 0.6740, 0.1880];
% for n=1:size(x,1)
%     h=plot(x(n,1),x(n,2),'+','Color',colores(idx(n),:));hold on
%     set(h,'MarkerFaceColor',colores(idx(n),:),'LineWidth',2)
% end
handles.h = h;
%label = xlabel('PCA1'),ylabel('PCA2')
guidata(hObject, handles);


% --- Executes on button press in pca.
function pca_Callback(hObject, eventdata, handles)
% hObject    handle to pca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%data set PCA
x = handles.x;
[coeff,datosPCA,latent] = pca(x');
%PCA = datosPCA;
handles.datosPCA = datosPCA;
p = plot(datosPCA(:,1),datosPCA(:,2),'ok')
label = xlabel('PCA1'),ylabel('PCA2')
guidata(hObject, handles);


% --- Executes on button press in LLE.
function LLE_Callback(hObject, eventdata, handles)
% hObject    handle to LLE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%data set LLE
x = handles.x;
[Y_lle] = lle(x);
handles.Y_lle = Y_lle;
plot(Y_lle(:,1),Y_lle(:,2),'ob')
xlabel('LLE1'),ylabel('LLE2')
guidata(hObject, handles);
