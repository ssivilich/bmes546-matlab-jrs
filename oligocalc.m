function varargout = oligocalc(varargin)
% OLIGOCALC MATLAB code for oligocalc.fig
%      OLIGOCALC, by itself, creates a new OLIGOCALC or raises the existing
%      singleton*.
%
%      H = OLIGOCALC returns the handle to a new OLIGOCALC or the handle to
%      the existing singleton*.
%
%      OLIGOCALC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OLIGOCALC.M with the given input arguments.
%
%      OLIGOCALC('Property','Value',...) creates a new OLIGOCALC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before oligocalc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to oligocalc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help oligocalc

% Last Modified by GUIDE v2.5 01-Dec-2014 20:30:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @oligocalc_OpeningFcn, ...
                   'gui_OutputFcn',  @oligocalc_OutputFcn, ...
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


% --- Executes just before oligocalc is made visible.
function oligocalc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to oligocalc (see VARARGIN)

% Choose default command line output for oligocalc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes oligocalc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = oligocalc_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ChooseFile.
function ChooseFile_Callback(hObject, eventdata, handles)
% hObject    handle to ChooseFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, filedir] = uigetfile('*.fasta', 'Choose a FASTA sequence file');
filepath = [filedir filename];
[header, test_seq] = fastaread(filepath);
set(handles.Longseqdisplay, 'String', test_seq);
handles.longsequence = test_seq;
set(handles.seq_label, 'String', header);
guidata(hObject, handles);

% --- Executes on button press in Getprimers.
function Getprimers_Callback(hObject, eventdata, handles)
% hObject    handle to Getprimers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Set exonjunction position
str_exonjunction = get(handles.exonjunction_widget, 'String');
handles.exonjunction = str2num(str_exonjunction);
if numel(handles.exonjunction) ~= 1
    errstring = 'Invalid exon junction position';
    set(handles.status_label, 'String', errstring);
    errordlg(errstring);
    error(errstring);
end
opts.exonjunction = handles.exonjunction;

% Set Tm selection
str_tm = get(handles.tm_widget, 'String');
handles.tm_opt = str2num(str_tm);
if numel(handles.tm_opt) ~= 1
    errstring = 'Invalid Tm';
    set(handles.status_label, 'String', errstring);
    errordlg(errstring);
    error(errstring);
end
opts.tm_opt = handles.tm_opt;

% Set number of individual primers selection
str_n_single = get(handles.tm_widget, 'String');
handles.n_top_score = str2num(str_n_single);
if numel(handles.n_top_score) ~= 1
    errstring = 'Invalid number of individual primers';
    set(handles.status_label, 'String', errstring);
    errordlg(errstring);
    error(errstring);
end
opts.n_top_score = handles.n_top_score;

% Set number of primer pairs selection
str_n_pair = get(handles.tm_widget, 'String');
handles.n_top_pair_score = str2num(str_n_pair);
if numel(handles.n_top_pair_score) ~= 1
    errstring = 'Invalid number of primer pairs';
    set(handles.status_label, 'String', errstring);
    errordlg(errstring);
    error(errstring);
end
opts.n_top_pair_score = handles.n_top_pair_score;

% Get the sequence from a fasta file
test_seq = handles.longsequence;
[filename, filedir] = uiputfile('*.fasta', 'Choose an output file name');
filepath = [filedir filename];
set(handles.status_label, 'String', 'please wait...');
if fname == 0
    errstring = 'Please select a file'
    set(handles.status_label, 'String', errstring);
end
try
    primerpairs = select_primers(test_seq, opts);
catch err
    errstring = 'There was a problem during primer selection';
    set(handles.status_label, 'String', errstring);
    errordlg(errstring);
    rethrow(err);
end
generate_report(filepath, primerpairs);
set(handles.status_label, 'String', 'Done!');

msgbox(['Congratulations, check ' filepath ' for your results']);

function exonjunction_widget_Callback(hObject, eventdata, handles)
% hObject    handle to exonjunction_widget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exonjunction_widget as text
%        str2double(get(hObject,'String')) returns contents of exonjunction_widget as a double


% --- Executes during object creation, after setting all properties.
function exonjunction_widget_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exonjunction_widget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tm_widget_Callback(hObject, eventdata, handles)
% hObject    handle to tm_widget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tm_widget as text
%        str2double(get(hObject,'String')) returns contents of tm_widget as a double


% --- Executes during object creation, after setting all properties.
function tm_widget_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tm_widget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_singles_widget_Callback(hObject, eventdata, handles)
% hObject    handle to n_singles_widget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_singles_widget as text
%        str2double(get(hObject,'String')) returns contents of n_singles_widget as a double


% --- Executes during object creation, after setting all properties.
function n_singles_widget_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_singles_widget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_pairs_widget_Callback(hObject, eventdata, handles)
% hObject    handle to n_pairs_widget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_pairs_widget as text
%        str2double(get(hObject,'String')) returns contents of n_pairs_widget as a double


% --- Executes during object creation, after setting all properties.
function n_pairs_widget_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_pairs_widget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
