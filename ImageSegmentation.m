function varargout = ImageSegmentation(varargin)
% IMAGESEGMENTATION MATLAB code for ImageSegmentation.fig
%      IMAGESEGMENTATION, by itself, creates a new IMAGESEGMENTATION or raises the existing
%      singleton*.
%
%      H = IMAGESEGMENTATION returns the handle to a new IMAGESEGMENTATION or the handle to
%      the existing singleton*.
%
%      IMAGESEGMENTATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGESEGMENTATION.M with the given input arguments.
%
%      IMAGESEGMENTATION('Property','Value',...) creates a new IMAGESEGMENTATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageSegmentation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageSegmentation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageSegmentation

% Last Modified by GUIDE v2.5 03-Apr-2018 13:10:22

% Begin initialization code - result03 NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageSegmentation_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageSegmentation_OutputFcn, ...
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
% End initialization code - result03 NOT EDIT


% --- Executes just before ImageSegmentation is made visible.
function ImageSegmentation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageSegmentation (see VARARGIN)

% Choose default command line output for ImageSegmentation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageSegmentation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageSegmentation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open1.
function open1_Callback(hObject, eventdata, handles)
% hObject    handle to open1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inImg1
[filename,path] = uigetfile({'*.jpg';'*.jpeg';'*.bmp';'*.png';'*.tif'},...
    'Choose an image');
if ~isequal(filename,0)
    Info = imfinfo(fullfile(path,filename));
    if Info.BitDepth == 24
    inImg1 = imread([path,filename]);
    axes(handles.axes1)
    imshow(inImg1);
    else
        msgbox('Please choose an image color RGB !');
        return
    end
else
    return
end

set(handles.name1,'Visible','on')
set(handles.name1,'string',filename);
set(handles.pop1,'Enable','on')
set(handles.process1,'Enable','on')
set(handles.htg01,'Enable','on')

% --- Executes on button press in open2.
function open2_Callback(hObject, eventdata, handles)
% hObject    handle to open2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inImg2
[filename,path] = uigetfile({'*.jpg';'*.jpeg';'*.bmp';'*.png';'*.tif'},...
    'Choose an image');
if ~isequal(filename,0)
    Info = imfinfo(fullfile(path,filename));
    if Info.BitDepth == 24
    inImg2 = imread([path,filename]);
    axes(handles.axes3)
    imshow(inImg2);
    else
        msgbox('Please choose an image color RGB !');
        return
    end
else
    return
end
set(handles.name2,'Visible','on')
set(handles.name2,'string',filename);
set(handles.pop2,'Enable','on')
set(handles.process2,'Enable','on')
set(handles.htg02,'Enable','on')

% --- Executes on button press in process1.
function process1_Callback(hObject, eventdata, handles)
% hObject    handle to process1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inImg1 outImg1
inImg = inImg1;
nBins = 5;
winSize = 5;
pop1 = get(handles.pop1,'value');

switch pop1
    case 1
        nClass = 2;
    case 2
        nClass = 3;
    case 3
        nClass = 4;
    case 4
        nClass = 5;
    case 5
        nClass = 6;
end

tic;
outImg1 = ImgSeg(inImg, nBins, winSize, nClass);
toc;
set(handles.time1,'string',toc);
axes(handles.axes2)
imshow(outImg1);
colormap('default');

index255 = 0;%255
index213 = 0;%213
index204 = 0;%201
index191 = 0;%191
index170 = 0;%170
index153 = 0;%153
index128 = 0;%128
index102 = 0;%102
index85 = 0;%85
index64 = 0;%64
index51 = 0;%51
index43 = 0;%43

for r = 1:size(outImg1,1)
    for c = 1:size(outImg1,2)
        switch outImg1(r,c)
            case 255
            index255 = index255 + 1;

            case 213
            index213 = index213 + 1;

            case 204
            index204 = index204 + 1;

            case 191
            index191 = index191 + 1;

            case 170
            index170 = index170 + 1;

            case 153
            index153 = index153 + 1;

            case 128
            index128 = index128 + 1;

            case 102
            index102 = index102 + 1;

            case 85
            index85 = index85 + 1;

            case 64
            index64 = index64 + 1;

            case 51
            index51 = index51 + 1;

            case 43
            index43 = index43 + 1;
        end
    end
end

switch pop1
    case 1
        set(handles.result01,'Visible','on')
        set(handles.result01,'BackgroundColor',[128 0 0]/256)
        set(handles.result01,'string',100*index255/(r*c));
        
        set(handles.result02,'Visible','on')
        set(handles.result02,'BackgroundColor',[143 255 112]/256)
        set(handles.result02,'string',100*index128/(r*c));
    
        set(handles.result03,'Visible','off')
    
        set(handles.result04,'Visible','off')

        set(handles.result05,'Visible','off')

        set(handles.result06,'Visible','off')

    case 2
        set(handles.result01,'Visible','on')
        set(handles.result01,'BackgroundColor',[128 0 0]/256)
        set(handles.result01,'string',100*index255/(r*c));
        
        set(handles.result02,'Visible','on')
        set(handles.result02,'BackgroundColor',[255 207 0]/256)
        set(handles.result02,'string',100*index170/(r*c));
    
        set(handles.result03,'Visible','on')
        set(handles.result03,'BackgroundColor',[0 223 255]/256)
        set(handles.result03,'string',100*index85/(r*c));
    
        set(handles.result04,'Visible','off')

        set(handles.result05,'Visible','off')

        set(handles.result06,'Visible','off')
        
    case 3
        set(handles.result01,'Visible','on')
        set(handles.result01,'BackgroundColor',[128 0 0]/256)
        set(handles.result01,'string',100*index255/(r*c));
        
        set(handles.result02,'Visible','on')
        set(handles.result02,'BackgroundColor',[255 128 0]/256)
        set(handles.result02,'string',100*index191/(r*c));
    
        set(handles.result03,'Visible','on')
        set(handles.result03,'BackgroundColor',[143 255 112]/256)
        set(handles.result03,'string',100*index128/(r*c));
    
        set(handles.result04,'Visible','on')
        set(handles.result04,'BackgroundColor',[0 143 255]/256)
        set(handles.result04,'string',100*index64/(r*c));

        set(handles.result05,'Visible','off')

        set(handles.result06,'Visible','off')
        
    case 4
        set(handles.result01,'Visible','on')
        set(handles.result01,'BackgroundColor',[128 0 0]/256)
        set(handles.result01,'string',100*index255/(r*c));
        
        set(handles.result02,'Visible','on')
        set(handles.result02,'BackgroundColor',[255 64 0]/256)
        set(handles.result02,'string',100*index204/(r*c));
    
        set(handles.result03,'Visible','on')
        set(handles.result03,'BackgroundColor',[239 255 16]/256)
        set(handles.result03,'string',100*index153/(r*c));
    
        set(handles.result04,'Visible','on')
        set(handles.result04,'BackgroundColor',[0 80 255]/256)
        set(handles.result04,'string',100*index51/(r*c));

        set(handles.result05,'Visible','on')
        set(handles.result05,'BackgroundColor',[32 255 223]/256)
        set(handles.result05,'string',100*index102/(r*c));

        set(handles.result06,'Visible','off')
        
    case 5     
        set(handles.result01,'Visible','on')
        set(handles.result01,'BackgroundColor',[128 0 0]/256)
        set(handles.result01,'string',100*index255/(r*c));
        
        set(handles.result02,'Visible','on')
        set(handles.result02,'BackgroundColor',[255 207 0]/256)
        set(handles.result02,'string',100*index170/(r*c));
    
        set(handles.result03,'Visible','on')
        set(handles.result03,'BackgroundColor',[255 32 0]/256)
        set(handles.result03,'string',100*index213/(r*c));
    
        set(handles.result04,'Visible','on')
        set(handles.result04,'BackgroundColor',[0 48 255]/256)
        set(handles.result04,'string',100*index43/(r*c));

        set(handles.result05,'Visible','on')
        set(handles.result05,'BackgroundColor',[143 255 112]/256)
        set(handles.result05,'string',100*index128/(r*c));

        set(handles.result06,'Visible','on')
        set(handles.result06,'BackgroundColor',[0 223 255]/256)
        set(handles.result06,'string',100*index85/(r*c));
end
 set(handles.save1,'Enable','on')
 set(handles.clear1,'Enable','on')
 set(handles.htg1,'Enable','on')

% --- Executes on button press in process2.
function process2_Callback(hObject, eventdata, handles)
% hObject    handle to process2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global inImg2 outImg2
inImg = inImg2;
nBins = 5;
winSize = 5;
pop2 = get(handles.pop2,'value');

switch pop2
    case 1
        nClass = 2;
    case 2
        nClass = 3;
    case 3
        nClass = 4;
    case 4
        nClass = 5;
    case 5
        nClass = 6;
end

tic;
outImg2 = ImgSeg(inImg, nBins, winSize, nClass);
toc;
set(handles.time2,'string',toc);
axes(handles.axes4)
imshow(outImg2);
colormap('default');

index255 = 0;%255
index213 = 0;%213
index204 = 0;%201
index191 = 0;%191
index170 = 0;%170
index153 = 0;%153
index128 = 0;%128
index102 = 0;%102
index85 = 0;%85
index64 = 0;%64
index51 = 0;%51
index43 = 0;%43


for r = 1:size(outImg2,1)
    for c = 1:size(outImg2,2)
        switch outImg2(r,c)
            case 255
            index255 = index255 + 1;

            case 213
            index213 = index213 + 1;

            case 204
            index204 = index204 + 1;

            case 191
            index191 = index191 + 1;

            case 170
            index170 = index170 + 1;

            case 153
            index153 = index153 + 1;

            case 128
            index128 = index128 + 1;

            case 102
            index102 = index102 + 1;

            case 85
            index85 = index85 + 1;

            case 64
            index64 = index64 + 1;

            case 51
            index51 = index51 + 1;

            case 43
            index43 = index43 + 1;
        end
    end
end


switch pop2
    case 1
        set(handles.result11,'Visible','on')
        set(handles.result11,'BackgroundColor',[128 0 0]/256)
        set(handles.result11,'string',100*index255/(r*c));
        
        set(handles.result12,'Visible','on')
        set(handles.result12,'BackgroundColor',[143 255 112]/256)
        set(handles.result12,'string',100*index128/(r*c));
    
        set(handles.result13,'Visible','off')
    
        set(handles.result14,'Visible','off')

        set(handles.result15,'Visible','off')

        set(handles.result16,'Visible','off')

    case 2
        set(handles.result11,'Visible','on')
        set(handles.result11,'BackgroundColor',[128 0 0]/256)
        set(handles.result11,'string',100*index255/(r*c));
        
        set(handles.result12,'Visible','on')
        set(handles.result12,'BackgroundColor',[255 207 0]/256)
        set(handles.result12,'string',100*index170/(r*c));
    
        set(handles.result13,'Visible','on')
        set(handles.result13,'BackgroundColor',[0 223 255]/256)
        set(handles.result13,'string',100*index85/(r*c));
    
        set(handles.result14,'Visible','off')

        set(handles.result15,'Visible','off')

        set(handles.result16,'Visible','off')
        
    case 3
        set(handles.result11,'Visible','on')
        set(handles.result11,'BackgroundColor',[128 0 0]/256)
        set(handles.result11,'string',100*index255/(r*c));
        
        set(handles.result12,'Visible','on')
        set(handles.result12,'BackgroundColor',[255 128 0]/256)
        set(handles.result12,'string',100*index191/(r*c));
    
        set(handles.result13,'Visible','on')
        set(handles.result13,'BackgroundColor',[143 255 112]/256)
        set(handles.result13,'string',100*index128/(r*c));
    
        set(handles.result14,'Visible','on')
        set(handles.result14,'BackgroundColor',[0 143 255]/256)
        set(handles.result14,'string',100*index64/(r*c));

        set(handles.result15,'Visible','off')

        set(handles.result16,'Visible','off')
        
    case 4
        set(handles.result11,'Visible','on')
        set(handles.result11,'BackgroundColor',[128 0 0]/256)
        set(handles.result11,'string',100*index255/(r*c));
        
        set(handles.result12,'Visible','on')
        set(handles.result12,'BackgroundColor',[255 64 0]/256)
        set(handles.result12,'string',100*index204/(r*c));
    
        set(handles.result13,'Visible','on')
        set(handles.result13,'BackgroundColor',[239 255 16]/256)
        set(handles.result13,'string',100*index153/(r*c));
    
        set(handles.result14,'Visible','on')
        set(handles.result14,'BackgroundColor',[0 80 255]/256)
        set(handles.result14,'string',100*index51/(r*c));

        set(handles.result15,'Visible','on')
        set(handles.result15,'BackgroundColor',[32 255 223]/256)
        set(handles.result15,'string',100*index102/(r*c));

        set(handles.result16,'Visible','off')
        
    case 5     
        set(handles.result11,'Visible','on')
        set(handles.result11,'BackgroundColor',[128 0 0]/256)
        set(handles.result11,'string',100*index255/(r*c));
        
        set(handles.result12,'Visible','on')
        set(handles.result12,'BackgroundColor',[255 207 0]/256)
        set(handles.result12,'string',100*index170/(r*c));
    
        set(handles.result13,'Visible','on')
        set(handles.result13,'BackgroundColor',[255 32 0]/256)
        set(handles.result13,'string',100*index213/(r*c));
    
        set(handles.result14,'Visible','on')
        set(handles.result14,'BackgroundColor',[0 48 255]/256)
        set(handles.result14,'string',100*index43/(r*c));

        set(handles.result15,'Visible','on')
        set(handles.result15,'BackgroundColor',[143 255 112]/256)
        set(handles.result15,'string',100*index128/(r*c));

        set(handles.result16,'Visible','on')
        set(handles.result16,'BackgroundColor',[0 223 255]/256)
        set(handles.result16,'string',100*index85/(r*c));
end

set(handles.save2,'Enable','on')
set(handles.clear2,'Enable','on')
set(handles.htg2,'Enable','on')

% --- Executes on button press in save1.
function save1_Callback(hObject, eventdata, handles)
% hObject    handle to save1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outImg1
  [filename,pathname]=uiputfile({'*.jpg','JPEG Files(*.jpg)';... 
           '*.bmp','Bitmap Files(*.bmp)';'*.gif','GIF Files(*.gif)';... 
           '*.tif','TIFF Files(*.tif)';... 
           '*.*','all image file'},'Save as!');
  if isequal(filename,0) || isequal(pathname,0)
    disp('Cancel save')
  else
    disp(['Saved to ',fullfile(pathname,filename)])
    imwrite(outImg1,[pathname,filename]);
  end


% --- Executes on button press in save2.
function save2_Callback(hObject, eventdata, handles)
% hObject    handle to save2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outImg2

  [filename,pathname]=uiputfile({'*.jpg','JPEG Files(*.jpg)';... 
           '*.bmp','Bitmap Files(*.bmp)';'*.gif','GIF Files(*.gif)';... 
           '*.tif','TIFF Files(*.tif)';... 
           '*.*','all image file'},'Save as!'); 
  if isequal(filename,0) || isequal(pathname,0)
    disp('Cancel save')
  else
    disp(['Saved to ',fullfile(pathname,filename)])
    imwrite(outImg2,[pathname,filename]);
  end

  
% --- Executes on button press in clear2.
function clear1_Callback(hObject, eventdata, handles)
% hObject    handle to clear2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
cla reset;
set(handles.time1,'string',0)
set(handles.save1,'Enable','off')
set(handles.htg1,'Enable','off')
set(handles.result01,'Visible','off')
set(handles.result02,'Visible','off')
set(handles.result03,'Visible','off')
set(handles.result04,'Visible','off')
set(handles.result05,'Visible','off')
set(handles.result06,'Visible','off')
set(handles.clear1,'Enable','off')

% --- Executes on button press in clear1.
function clear2_Callback(hObject, eventdata, handles)
% hObject    handle to clear1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes4);
cla reset;
set(handles.time2,'string',0)
set(handles.save2,'Enable','off')
set(handles.htg2,'Enable','off')
set(handles.result11,'Visible','off')
set(handles.result12,'Visible','off')
set(handles.result13,'Visible','off')
set(handles.result14,'Visible','off')
set(handles.result15,'Visible','off')
set(handles.result16,'Visible','off')
set(handles.clear2,'Enable','off')

% --- Executes on button press in htg01.
function htg01_Callback(hObject, eventdata, handles)
% hObject    handle to htg01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inImg1
figure('name','Histogram01','numbertitle','off');
imhist(rgb2gray(inImg1));
title('Histogram');

% --- Executes on button press in htg02.
function htg02_Callback(hObject, eventdata, handles)
% hObject    handle to htg02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global inImg2
figure('name','Histogram02','numbertitle','off');
imhist(rgb2gray(inImg2));
title('Histogram');

% --- Executes on button press in htg1.
function htg1_Callback(hObject, eventdata, handles)
% hObject    handle to htg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outImg1
figure('name','Histogram1','numbertitle','off');
imhist(outImg1);
title('Histogram');

% --- Executes on button press in htg2.
function htg2_Callback(hObject, eventdata, handles)
% hObject    handle to htg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outImg2
figure('name','Histogram2','numbertitle','off');
imhist(outImg2);
title('Histogram');


% --- Executes on selection change in pop1.
function pop1_Callback(hObject, eventdata, handles)
% hObject    handle to pop1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop1


% --- Executes during object creation, after setting all properties.
function pop1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in pop2.
function pop2_Callback(hObject, eventdata, handles)
% hObject    handle to pop2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop2

% --- Executes during object creation, after setting all properties.
function pop2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('Do you want to exit !','Exit','Yes','No','No');
switch choice
    case 'Yes'
        close
    case 'No'
end


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web ImageSegmentation.htm

% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,path] = uigetfile({'*.jpg';'*.jpeg';'*.bmp';'*.png';'*.tif'},...
    'Choose an image');
if ~isequal(filename,0)
    Img = imread([path,filename]);
    figure('name','Open Image','numbertitle','off');
    imshow(Img);
    title(filename);
end

% --------------------------------------------------------------------
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('Do you want to quit !','Exit','Yes','No','No');
switch choice
    case 'Yes'
        close
    case 'No'
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function outImg = ImgSeg(inImg, nBins, winSize, nClass)

NbParam = nBins * nBins * nBins;
divis = 256 / nBins ;

s = size(inImg);
N = winSize;

n = (N-1)/2;
r = s(1) + 2*n;
c = s(2) + 2*n;
double temp(r,c,3);
temp = zeros(r,c,3);
% out = zeros(r,c,3);
coarseImg = zeros(r,c);
TabLabel = zeros(1,NbParam);
% inrImg = rgb2gray(inImg);

temp((n+1):(end-n),(n+1):(end-n),1)=inImg(:,:,1);
temp((n+1):(end-n),(n+1):(end-n),2)=inImg(:,:,2);
temp((n+1):(end-n),(n+1):(end-n),3)=inImg(:,:,3);

% temp_color = temp;

for x = n+1:s(1)+ n
    for y = n+1:s(2)+ n
        e = 1;
        for k = x-n:x+n
            f = 1;
            for l = y-n:y+n
                mat(e,f,1) = temp(k,l,1);
                mat(e,f,2) = temp(k,l,2);
                mat(e,f,3) = temp(k,l,3);
                f = f+1;
            end
            e = e + 1;
        end

        sum_lab = 0;
        for i = 1 : winSize
            for j = 1 : winSize
                lab = floor(mat(i,j,1)/divis)*(nBins*nBins);
                lab = lab + floor(mat(i,j,2)/divis)*(nBins);
                lab = lab + floor(mat(i,j,3)/divis);
                lab = lab + 1;
                TabLabel(lab) = TabLabel(lab) + 1;
                sum_lab = sum_lab + lab;
            end
        end
        coarseImg(x,y) = floor(sum_lab / (winSize * winSize));

    end
end
trunCoarseImg(:,:) = coarseImg((n+1):(end-n),(n+1):(end-n));

tempVar = trunCoarseImg(:,:);
inImg_1D = double(tempVar(:));
fusedMap = kmeans(inImg_1D,nClass, 'EmptyAction', 'singleton');
fusedMapShow = uint8(fusedMap.*(255/nClass));
outImg = reshape(fusedMapShow,s(1),s(2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes during object creation, after setting all properties.
function logo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate logo
hust = imread('hust.jpg');
imshow(hust);
