function varargout = guiG(varargin)
% GUI MATLAB code for gui.fig
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
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 16-Apr-2018 02:25:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load1.
function load1_Callback(hObject, eventdata, handles)
% hObject    handle to load1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[nazwaPliku,sciezkaPliku]=uigetfile('*.fasta','Plik sekwencji 1');
[header,dane]=fastaread([sciezkaPliku nazwaPliku]);

set(handles.reczna1,'String',dane);


% --- Executes on button press in load2.
function load2_Callback(hObject, eventdata, handles)
% hObject    handle to load2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[nazwaPliku,sciezkaPliku]=uigetfile('*.fasta','Plik sekwencji 2');
[header,dane]=fastaread([sciezkaPliku nazwaPliku]);

set(handles.reczna2,'String',dane);

function reczna1_Callback(hObject, eventdata, handles)
% hObject    handle to reczna1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reczna1 as text
%        str2double(get(hObject,'String')) returns contents of reczna1 as a double


% --- Executes during object creation, after setting all properties.
function reczna1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reczna1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function reczna2_Callback(hObject, eventdata, handles)
% hObject    handle to reczna2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reczna2 as text
%        str2double(get(hObject,'String')) returns contents of reczna2 as a double


% --- Executes during object creation, after setting all properties.
function reczna2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reczna2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clear all

global macierzPunktow;

sekwencja1 = findobj('Tag', 'reczna1');
sekwencja2 = findobj('Tag', 'reczna2');
brak1 = findobj('Tag', 'brak');
kara1 = findobj('Tag', 'kara');
nagroda1 = findobj('Tag','nagroda');
w1=sekwencja1.String;
w2=sekwencja2.String;
brak2 = str2double(brak1.String);
kara2 = str2double(kara1.String);
nagroda2 = str2double(nagroda1.String);
if ~isempty(sekwencja1) && ~isempty(sekwencja2) && ~isempty(brak1) && ~isempty(kara1)&& ~isempty(nagroda1)
   [E, macierzPunktow, fig, trasy, druki, msg] = funkcjaG(w1,w2,kara2,nagroda2,brak2)
    for i = 1:length(druki)
       
       h = msgbox(druki{i}, 'Wynik');
       ah = get( h, 'CurrentAxes' );
       ch = get( ah, 'Children' );
       set(ch, 'FontName', 'Courier', 'FontSize', 12);
   end
   %msgbox(msg, 'Wynik')
end

function brak_Callback(hObject, eventdata, handles)
% hObject    handle to brak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of brak as text
%        str2double(get(hObject,'String')) returns contents of brak as a double


% --- Executes during object creation, after setting all properties.
function brak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nagroda_Callback(hObject, eventdata, handles)
% hObject    handle to nagroda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nagroda as text
%        str2double(get(hObject,'String')) returns contents of nagroda as a double


% --- Executes during object creation, after setting all properties.
function nagroda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nagroda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function kara_Callback(hObject, eventdata, handles)
% hObject    handle to nagroda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nagroda as text
%        str2double(get(hObject,'String')) returns contents of nagroda as a double


% --- Executes during object creation, after setting all properties.
function kara_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nagroda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global macierzPunktow
zapis(macierzPunktow);
close(guiG)
