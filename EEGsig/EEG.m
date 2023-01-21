function varargout = EEG(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EEG_OpeningFcn, ...
                   'gui_OutputFcn',  @EEG_OutputFcn, ...
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


% --- Executes just before EEG is made visible.
function EEG_OpeningFcn(hObject, eventdata, handles, varargin)


% Choose default command line output for EEG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = EEG_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

clc
clear all
dis1= 'hi this is EEGsig GUI for EEG signal processing . ';  
dis2= 'if you want to start enter your data in txt format.';
dis3= 'then enter sampling rate of your data and press enter .';
dis=strcat(dis1,dis2,dis3);
helpdlg(dis,'EEGsig GUI');  

% --- Executes on button press in pre_processing_button.
function pre_processing_button_Callback(hObject, eventdata, handles)



% --- Executes on button press in classification_button.
function classification_button_Callback(hObject, eventdata, handles)



% --- Executes on button press in feature_extraction_button.
function feature_extraction_button_Callback(hObject, eventdata, handles)




% --- Executes on button press in Convert_data_format_button.
function Convert_data_format_button_Callback(hObject, eventdata, handles)



% --- Executes on button press in enter_data_button.
function enter_data_button_Callback(hObject, eventdata, handles)

global fs          % sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y           %temp variable / single channel 
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn



%get data from input and find number of raw and column

[fn,pn,in]=uigetfile();
data=load([pn fn]);
m_data=data';
[lenR,lenC]=size(m_data);

% plot one channel of data
stat_plot=1;
t=1:lenC;
y=m_data;
axes(handles.axes2); 
plot(t,y);
title('plot eeg data')
xlabel('sample');
ylabel('eeg data');


if stat_plot==1
    set(handles.plot_panel11,'visible','on')
    set(handles.plot_panel10,'visible','off')
    set(handles.plot_panel12,'visible','off')
    set(handles.plot_panel14,'visible','off')
    set(handles.plot_panel15,'visible','off')
    set(handles.plot_panel16,'visible','off')
    set(handles.plot_panel17,'visible','off')
    set(handles.plot_panel18,'visible','off')
    set(handles.plot_panel19,'visible','off')
    set(handles.plot_panel21,'visible','off')
    set(handles.plot_panel22,'visible','off')
    set(handles.plot_panel23,'visible','off')
    set(handles.plot_panel24,'visible','off')
    set(handles.plot_panel25,'visible','off')
    
    n=lenR;
    axes(handles.axes3);
    for i=1:n
    dis1='eeg row ';
    dis2=num2str(i);
    dis=strcat(dis1,dis2);  
    subplot(n,1,i);plot(t,m_data(i,:));ylabel(dis);
    end
    xlabel('sample');  
end



% define notification bar to show detail of dataset

dis1=num2str(lenR);dis2=num2str(lenC);
dis3='your data have : ';dis4=' Raw => ';dis5=' column => ';
dis=strcat(dis3,dis4,dis1,dis5,dis2);
helpdlg(dis,'data');        
pause(50);


% --- Executes on selection change in plot_popupmenu.
function plot_popupmenu_Callback(hObject, eventdata, handles)

global fs          % sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y   
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn



    if stat_plot==1
        y=m_data;
        plot_stat=get(handles.plot_popupmenu,'Value');
        switch plot_stat   
            case 1
                axes(handles.axes2);
                plot(t,y(1,:));xlabel('sample');ylabel('eeg row 1');              
            case 2
                axes(handles.axes2);
                plot(t,y(2,:));xlabel('sample');ylabel('eeg row 2');              
            case 3
                axes(handles.axes2);
                plot(t,y(3,:));xlabel('sample');ylabel('eeg row 3');              
            case 4
                axes(handles.axes2);
                plot(t,y(4,:));xlabel('sample');ylabel('eeg row 4');                        
            case 5
                axes(handles.axes2);
                plot(t,y(5,:));xlabel('sample');ylabel('eeg row 5');   
            case 6
                axes(handles.axes2);
                plot(t,y(6,:));xlabel('sample');ylabel('eeg row 6');  
        end
    elseif stat_plot==2 || stat_plot==3
        y=r_data;
        plot_stat=get(handles.plot_popupmenu,'Value');
        switch plot_stat   
            case 1
                axes(handles.axes2);
                plot(t,y(1,:));xlabel('sample');ylabel('eeg row 1');              
            case 2
                axes(handles.axes2);
                plot(t,y(2,:));xlabel('sample');ylabel('eeg row 2');              
            case 3
                axes(handles.axes2);
                plot(t,y(3,:));xlabel('sample');ylabel('eeg row 3');              
            case 4
                axes(handles.axes2);
                plot(t,y(4,:));xlabel('sample');ylabel('eeg row 4');                        
            case 5
                axes(handles.axes2);
                plot(t,y(5,:));xlabel('sample');ylabel('eeg row 5');   
            case 6
                axes(handles.axes2);
                plot(t,y(6,:));xlabel('sample');ylabel('eeg row 6');  
        end
    elseif stat_plot==4 || stat_plot==5 || stat_plot==6 || stat_plot==7 || stat_plot==8 || stat_plot==9 || stat_plot==10 || stat_plot==11 || stat_plot==12 || stat_plot==13  
 
        y=f_data;
        plot_stat=get(handles.plot_popupmenu,'Value');
        switch plot_stat   
            case 1
                axes(handles.axes2);
                plot(y(1,:));xlabel('sample');ylabel('eeg row 1');              
            case 2
                axes(handles.axes2);
                plot(y(2,:));xlabel('sample');ylabel('eeg row 2');              
            case 3
                axes(handles.axes2);
                plot(y(3,:));xlabel('sample');ylabel('eeg row 3');              
            case 4
                axes(handles.axes2);
                plot(y(4,:));xlabel('sample');ylabel('eeg row 4');                        
            case 5
                axes(handles.axes2);
                plot(y(5,:));xlabel('sample');ylabel('eeg row 5');   
            case 6
                axes(handles.axes2);
                plot(y(6,:));xlabel('sample');ylabel('eeg row 6');  
        end
    elseif stat_plot==14 
        y=f_data;
        plot_stat=get(handles.plot_popupmenu,'Value');
        switch plot_stat   
            case 1
                axes(handles.axes2);
                plot(abs(fftshift(y(1,:))));xlabel('sample');ylabel('eeg row 1');              
            case 2
                axes(handles.axes2);
                plot(abs(fftshift(y(2,:))));xlabel('sample');ylabel('eeg row 2');              
            case 3
                axes(handles.axes2);
                plot(abs(fftshift(y(3,:))));xlabel('sample');ylabel('eeg row 3');              
            case 4
                axes(handles.axes2);
                plot(abs(fftshift(y(4,:))));xlabel('sample');ylabel('eeg row 4');                        
            case 5
                axes(handles.axes2);
                plot(abs(fftshift(y(5,:))));xlabel('sample');ylabel('eeg row 5');   
            case 6
                axes(handles.axes2);
                plot(abs(fftshift(y(6,:))));xlabel('sample');ylabel('eeg row 6');  
        end
    end





% --- Executes during object creation, after setting all properties.
function plot_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in subplot.
function subplot_Callback(hObject, eventdata, handles)

global fs          %  sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y   
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn





  



function edit_FS_Callback(hObject, eventdata, handles)

global fs          %sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y   
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn



editBoxContents = get(handles.edit_FS,'String');
fs = str2double(char(editBoxContents));
dis1='sampling rate of data is :  ';dis2=num2str(fs);dis3='HZ';
dis=strcat(dis1,dis2,dis3);
helpdlg(dis,'data');  


% --- Executes during object creation, after setting all properties.
function edit_FS_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in denoising_popupmenu.
function denoising_popupmenu_Callback(hObject, eventdata, handles)

global fs          %  sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR        %lenght of raw
global t       
global y  
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn


% tempx=zeros(lenR,lenC);
for i=1:lenR
    temx=filetring_1to60eeg(m_data(i,:),fs);
    tempx(i,:)=temx; 
end


denarti_Method_stat=get(handles.denoising_popupmenu,'Value');
switch denarti_Method_stat   
    case 1
        temp=[];
        for i=1:lenR
               ar = ICA(tempx(i,:),1); % using ica for artifact remove
               temp=[temp;ar];
        end
        r_data=temp;
        stat_plot=2;   
        if stat_plot==2
            set(handles.plot_panel10,'visible','on')
            set(handles.plot_panel11,'visible','off')
            set(handles.plot_panel12,'visible','off')
            set(handles.plot_panel14,'visible','off')
            set(handles.plot_panel15,'visible','off')
            set(handles.plot_panel16,'visible','off')
            set(handles.plot_panel17,'visible','off')
            set(handles.plot_panel18,'visible','off')
            set(handles.plot_panel19,'visible','off')
            set(handles.plot_panel21,'visible','off')
            set(handles.plot_panel22,'visible','off')
            set(handles.plot_panel23,'visible','off')
            set(handles.plot_panel24,'visible','off')
            set(handles.plot_panel25,'visible','off')

            n=lenR;
            axes(handles.axes1);
            for i=1:n
            dis1='eeg row ';
            dis2=num2str(i);
            dis=strcat(dis1,dis2);  
            subplot(n,1,i);plot(t,r_data(i,:));ylabel(dis);
            end
            xlabel('sample');
        %elseif stat_plot==3
        end
        
%     case 2
%         
%         temp=[];
%         for i=1:lenR
%                ar = kalmanfilter(m_data(i,:),1);          % using ica for artifact remove
%                temp=[temp;ar];
%         end
%         r_data=temp;
%         stat_plot=3; 
%             if stat_plot==3
%             set(handles.plot_panel12,'visible','on')
%             set(handles.plot_panel10,'visible','off')
%             set(handles.plot_panel11,'visible','off')
%             set(handles.plot_panel15,'visible','off')
%             set(handles.plot_panel16,'visible','off')
%             set(handles.plot_panel17,'visible','off')
%             set(handles.plot_panel18,'visible','off')
%             set(handles.plot_panel19,'visible','off')
%             set(handles.plot_panel21,'visible','off')
%             set(handles.plot_panel22,'visible','off')
%             set(handles.plot_panel23,'visible','off')
%             set(handles.plot_panel24,'visible','off')
%             set(handles.plot_panel25,'visible','off')
%             n=lenR;
%             axes(handles.axes4);
%             for i=1:n
%             dis1='eeg raw ';
%             dis2=num2str(i);
%             dis=strcat(dis1,dis2);  
%             subplot(n,1,i);plot(t,r_data(i,:));ylabel(dis);
%             end
%             xlabel('sample');
%         %elseif stat_plot==3
        end





% --- Executes during object creation, after setting all properties.
function denoising_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to denoising_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in feature_popupmenu.
function feature_popupmenu_Callback(hObject, eventdata, handles)


global fs          %  sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR        %lenght of raw
global t       
global y  
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn



featureval=get(handles.feature_popupmenu,'Value');
switch featureval   %define popup menu for feature extraction
    
%-------------------------- alpha wave -----------------------------------%   
    case 1          
        temp1=[];
        for i=1:lenR
             alpha=alpha_wave(r_data(i,:));
             temp1=[temp1;alpha];   
        end
        f_data=temp1;
        stat_plot=4;
        if stat_plot==4
            set(handles.plot_panel14,'visible','on')
            set(handles.plot_panel15,'visible','off')
            set(handles.plot_panel11,'visible','off')
            set(handles.plot_panel10,'visible','off')
            set(handles.plot_panel12,'visible','off')
            set(handles.plot_panel16,'visible','off')
            set(handles.plot_panel17,'visible','off')
            set(handles.plot_panel18,'visible','off')
            set(handles.plot_panel19,'visible','off')
            set(handles.plot_panel21,'visible','off')
            set(handles.plot_panel22,'visible','off')
            set(handles.plot_panel23,'visible','off')
            set(handles.plot_panel24,'visible','off')
            set(handles.plot_panel25,'visible','off')
            n=lenR;
            axes(handles.axes5);
            for i=1:n
                dis1='eeg row ';
                dis2=num2str(i);
                dis=strcat(dis1,dis2);  
                subplot(n,1,i);plot(t,f_data(i,:));ylabel(dis);
            end
            xlabel('sample');  
        end
%-------------------------- beta wave ------------------------------------%            
    case 2         
        
        temp1=[];
        for i=1:lenR
             beta=beta_wave(r_data(i,:));
             temp1=[temp1;beta];   
        end
        f_data=temp1;
        stat_plot=5;
        if stat_plot==5
            set(handles.plot_panel15,'visible','on')
            set(handles.plot_panel14,'visible','off')
            set(handles.plot_panel11,'visible','off')
            set(handles.plot_panel10,'visible','off')
            set(handles.plot_panel12,'visible','off')
            set(handles.plot_panel16,'visible','off')
            set(handles.plot_panel17,'visible','off')
            set(handles.plot_panel18,'visible','off')
            set(handles.plot_panel19,'visible','off')
            set(handles.plot_panel21,'visible','off')
            set(handles.plot_panel22,'visible','off')
            set(handles.plot_panel23,'visible','off')
            set(handles.plot_panel24,'visible','off')
            set(handles.plot_panel25,'visible','off')
            n=lenR;
            axes(handles.axes6);
            for i=1:n
                dis1='eeg row ';
                dis2=num2str(i);
                dis=strcat(dis1,dis2);  
                subplot(n,1,i);plot(t,f_data(i,:));ylabel(dis);
            end
            xlabel('sample');  
        end
%-------------------------- gama wave ------------------------------------%        
    case 3          
        
        temp1=[];
        for i=1:lenR
             gama=gama_wave(r_data(i,:));
             temp1=[temp1;gama];   
        end
        f_data=temp1;
        stat_plot=6;
        if stat_plot==6
            set(handles.plot_panel16,'visible','on')
            set(handles.plot_panel15,'visible','off')
            set(handles.plot_panel14,'visible','off')
            set(handles.plot_panel11,'visible','off')
            set(handles.plot_panel10,'visible','off')
            set(handles.plot_panel12,'visible','off')
            set(handles.plot_panel17,'visible','off')
            set(handles.plot_panel18,'visible','off')
            set(handles.plot_panel19,'visible','off')
            set(handles.plot_panel21,'visible','off')
            set(handles.plot_panel22,'visible','off')
            set(handles.plot_panel23,'visible','off')
            set(handles.plot_panel24,'visible','off')
            set(handles.plot_panel25,'visible','off')
            n=lenR;
            axes(handles.axes7);
            for i=1:n
                dis1='eeg row ';
                dis2=num2str(i);
                dis=strcat(dis1,dis2);  
                subplot(n,1,i);plot(t,f_data(i,:));ylabel(dis);
            end
            xlabel('sample');  
        end
%-------------------------- delta wave -----------------------------------%
    case 4          
        
        temp1=[];
        for i=1:lenR
             delta=delta_wave(r_data(i,:));
             temp1=[temp1;delta];   
        end
        f_data=temp1;
        stat_plot=7;
        if stat_plot==7
            set(handles.plot_panel17,'visible','on')
            set(handles.plot_panel16,'visible','off')
            set(handles.plot_panel15,'visible','off')
            set(handles.plot_panel14,'visible','off')
            set(handles.plot_panel11,'visible','off')
            set(handles.plot_panel10,'visible','off')
            set(handles.plot_panel12,'visible','off')
            set(handles.plot_panel18,'visible','off')
            set(handles.plot_panel19,'visible','off')
            set(handles.plot_panel21,'visible','off')
            set(handles.plot_panel22,'visible','off')
            set(handles.plot_panel23,'visible','off')
            set(handles.plot_panel24,'visible','off')
            set(handles.plot_panel25,'visible','off')
            n=lenR;
            axes(handles.axes8);
            for i=1:n
                dis1='eeg row ';
                dis2=num2str(i);
                dis=strcat(dis1,dis2);  
                subplot(n,1,i);plot(t,f_data(i,:));ylabel(dis);
            end
            xlabel('sample');  
        end

%-------------------------- teta wave ------------------------------------%
    case 5         
        
        temp1=[];
        for i=1:lenR
             teta=teta_wave(r_data(i,:));
             temp1=[temp1;teta];   
        end
        f_data=temp1;
        stat_plot=8;
        if stat_plot==8
            set(handles.plot_panel18,'visible','on')
            set(handles.plot_panel16,'visible','off')
            set(handles.plot_panel15,'visible','off')
            set(handles.plot_panel14,'visible','off')
            set(handles.plot_panel11,'visible','off')
            set(handles.plot_panel10,'visible','off')
            set(handles.plot_panel12,'visible','off')
            set(handles.plot_panel17,'visible','off')
            set(handles.plot_panel19,'visible','off')
            set(handles.plot_panel21,'visible','off')
            set(handles.plot_panel22,'visible','off')
            set(handles.plot_panel23,'visible','off')
            set(handles.plot_panel24,'visible','off')
            set(handles.plot_panel25,'visible','off')
            n=lenR;
            axes(handles.axes9);
            for i=1:n
                dis1='eeg row ';
                dis2=num2str(i);
                dis=strcat(dis1,dis2);  
                subplot(n,1,i);plot(t,f_data(i,:));ylabel(dis);
            end
            xlabel('sample');  
        end
%-------------------------- power of alpha -------------------------------%
    case 6  
        temp=[];
        for i=1:lenR
            [ar,w] = power_of_alpha(r_data(i,:));
            ar=ar';
            temp=[temp;ar];
        end
        f_data=temp; 
        stat_plot=9;
        if stat_plot==9
            set(handles.plot_panel19,'visible','on')
            set(handles.plot_panel15,'visible','off')
            set(handles.plot_panel16,'visible','off')
            set(handles.plot_panel14,'visible','off')
            set(handles.plot_panel11,'visible','off')
            set(handles.plot_panel10,'visible','off')
            set(handles.plot_panel12,'visible','off')
            set(handles.plot_panel17,'visible','off')
            set(handles.plot_panel18,'visible','off')
            set(handles.plot_panel21,'visible','off')
            set(handles.plot_panel22,'visible','off')
            set(handles.plot_panel23,'visible','off')
            set(handles.plot_panel24,'visible','off')
            set(handles.plot_panel25,'visible','off')
            n=lenR;
            axes(handles.axes10);
            for i=1:n
                dis1='eeg row ';
                dis2=num2str(i);
                dis=strcat(dis1,dis2);  
                subplot(n,1,i);plot(w,f_data(i,:));ylabel(dis);
            end
            xlabel('sample');  
        end   
       
%-------------------------- power of beta --------------------------------%      
    case 7          
        
        temp=[];
        for i=1:lenR
            [ar,w] = power_of_beta(r_data(i,:));
            ar=ar';
            temp=[temp;ar];
        end
        f_data=temp;
        stat_plot=10;
        if stat_plot==10
            set(handles.plot_panel21,'visible','on')
            set(handles.plot_panel19,'visible','off')
            set(handles.plot_panel15,'visible','off')
            set(handles.plot_panel16,'visible','off')
            set(handles.plot_panel14,'visible','off')
            set(handles.plot_panel11,'visible','off')
            set(handles.plot_panel10,'visible','off')
            set(handles.plot_panel12,'visible','off')
            set(handles.plot_panel17,'visible','off')
            set(handles.plot_panel18,'visible','off')
            set(handles.plot_panel22,'visible','off')
            set(handles.plot_panel23,'visible','off')
            set(handles.plot_panel24,'visible','off')
            set(handles.plot_panel25,'visible','off')

            n=lenR;
            axes(handles.axes12);
            for i=1:n
                dis1='eeg row ';
                dis2=num2str(i);
                dis=strcat(dis1,dis2);  
                subplot(n,1,i);plot(w,f_data(i,:));ylabel(dis);
            end
            xlabel('sample');  
        end

%-------------------------- power of gama --------------------------------%      
    case 8          
        
        temp=[];
        for i=1:lenR
            [ar,w] = power_of_gama(r_data(i,:));
            ar=ar';
            temp=[temp;ar];
        end
        f_data=temp;
        stat_plot=11;
        if stat_plot==11
            set(handles.plot_panel22,'visible','on')
            set(handles.plot_panel21,'visible','off')
            set(handles.plot_panel19,'visible','off')
            set(handles.plot_panel15,'visible','off')
            set(handles.plot_panel16,'visible','off')
            set(handles.plot_panel14,'visible','off')
            set(handles.plot_panel11,'visible','off')
            set(handles.plot_panel10,'visible','off')
            set(handles.plot_panel12,'visible','off')
            set(handles.plot_panel17,'visible','off')
            set(handles.plot_panel18,'visible','off')
            set(handles.plot_panel23,'visible','off')
            set(handles.plot_panel24,'visible','off')
            set(handles.plot_panel25,'visible','off')

            n=lenR;
            axes(handles.axes13);
            for i=1:n
                dis1='eeg row ';
                dis2=num2str(i);
                dis=strcat(dis1,dis2);  
                subplot(n,1,i);plot(w,f_data(i,:));ylabel(dis);
            end
            xlabel('sample');  
        end

%-------------------------- power of delta -------------------------------%       
    case 9              
        
        temp=[];
        for i=1:lenR
            [ar,w] = power_of_delta(r_data(i,:));
            ar=ar';
            temp=[temp;ar];
        end
        f_data=temp;
        stat_plot=12;
        if stat_plot==12
            set(handles.plot_panel23,'visible','on')
            set(handles.plot_panel22,'visible','off')
            set(handles.plot_panel21,'visible','off')
            set(handles.plot_panel19,'visible','off')
            set(handles.plot_panel15,'visible','off')
            set(handles.plot_panel16,'visible','off')
            set(handles.plot_panel14,'visible','off')
            set(handles.plot_panel11,'visible','off')
            set(handles.plot_panel10,'visible','off')
            set(handles.plot_panel12,'visible','off')
            set(handles.plot_panel17,'visible','off')
            set(handles.plot_panel18,'visible','off')
            set(handles.plot_panel24,'visible','off')
            set(handles.plot_panel25,'visible','off')

            n=lenR;
            axes(handles.axes14);
            for i=1:n
                dis1='eeg row ';
                dis2=num2str(i);
                dis=strcat(dis1,dis2);  
                subplot(n,1,i);plot(w,f_data(i,:));ylabel(dis);
            end
            xlabel('sample');  
        end

%-------------------------- power of teta --------------------------------%       
    case 10   
        
        temp=[];
        for i=1:lenR
            [ar,w] = power_of_teta(r_data(i,:));
            ar=ar';
            temp=[temp;ar];
        end
        f_data=temp; 
        stat_plot=13;
        if stat_plot==13
            set(handles.plot_panel24,'visible','on')
            set(handles.plot_panel23,'visible','off')
            set(handles.plot_panel22,'visible','off')
            set(handles.plot_panel21,'visible','off')
            set(handles.plot_panel19,'visible','off')
            set(handles.plot_panel15,'visible','off')
            set(handles.plot_panel16,'visible','off')
            set(handles.plot_panel14,'visible','off')
            set(handles.plot_panel11,'visible','off')
            set(handles.plot_panel10,'visible','off')
            set(handles.plot_panel12,'visible','off')
            set(handles.plot_panel17,'visible','off')
            set(handles.plot_panel18,'visible','off') 
            set(handles.plot_panel25,'visible','off')

            n=lenR;
            axes(handles.axes15);
            for i=1:n
                dis1='eeg row ';
                dis2=num2str(i);
                dis=strcat(dis1,dis2);  
                subplot(n,1,i);plot(w,f_data(i,:));ylabel(dis);
            end
            xlabel('sample');  
        end
%-------------------------- entropy --------------------------------------%       
    case 11   
        
       main_dis=[];
       for i=1:lenR  
           dis1 = 'entropy of eeg signal (for channel	 ';
           dis2 = num2str(i);
           dis3 = ' ) :	 ';
           temp1=entropy(r_data(i,:));
           dis4 = num2str(temp1);
           dis5 =' ----> ';
           temp2 = strcat(dis1,dis2,dis3,dis4,dis5);
           main_dis=[main_dis temp2];
       end      
       helpdlg(main_dis,'entropy');
       pause(50);
        
%-------------------------- fft  -----------------------------------------%       
    case 12         
        temp=[];
        for i=1:lenR
            ft=fft(r_data(1,:));
            temp=[temp;ft];
          
        end
        f_data=temp;
         
        stat_plot=14;
        if stat_plot==14
            set(handles.plot_panel25,'visible','on')
            set(handles.plot_panel24,'visible','off')
            set(handles.plot_panel23,'visible','off')
            set(handles.plot_panel22,'visible','off')
            set(handles.plot_panel21,'visible','off')
            set(handles.plot_panel19,'visible','off')
            set(handles.plot_panel15,'visible','off')
            set(handles.plot_panel16,'visible','off')
            set(handles.plot_panel14,'visible','off')
            set(handles.plot_panel11,'visible','off')
            set(handles.plot_panel10,'visible','off')
            set(handles.plot_panel12,'visible','off')
            set(handles.plot_panel17,'visible','off')
            set(handles.plot_panel18,'visible','off') 
           

            n=lenR;
            axes(handles.axes16);
            for i=1:n
                dis1='eeg row ';
                dis2=num2str(i);
                dis=strcat(dis1,dis2);  
                subplot(n,1,i);plot(abs(fftshift(f_data(i,:))));ylabel(dis);
            end
            xlabel('sample'); 
        end
        
%-------------------------- mean -----------------------------------------%       
    case 13        
        
       main_dis=[];
       for i=1:lenR  
           dis1 = 'entropy of eeg signal (for channel	 ';
           dis2 = num2str(i);
           dis3 = ' ) :	 ';
           temp1= mean (r_data(i,:));
           dis4 = num2str(temp1);
           temp2 = strcat(dis1,dis2,dis3,dis4);
           main_dis=[main_dis temp2];
       end      
       helpdlg(main_dis,'entropy');
       pause(50);

%-------------------------- std ------------------------------------------%       
    case 14         
       
              main_dis=[];
       for i=1:lenR  
           dis1 = 'std of eeg signal (for channel	';
           dis2 = num2str(i);
           dis3 = ' )  :	 ';
           temp1=std(r_data(i,:));
           dis4 = num2str(temp1);
           temp2 = strcat(dis1,dis2,dis3,dis4);
           main_dis=[main_dis temp2];
       end      
       helpdlg(main_dis,'std');
       pause(50);

        
end




% --- Executes during object creation, after setting all properties.
function feature_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to feature_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset_pushbutton.
function reset_pushbutton_Callback(hObject, eventdata, handles)


axes(handles.axes2);
cla reset

% axes(handles.axes1);
% cla reset
% axes(handles.axes3);
% cla reset
% axes(handles.axes4);
% cla reset
% axes(handles.axes5);
% cla reset
% axes(handles.axes6);
% cla reset
% axes(handles.axes7);
% cla reset
% axes(handles.axes8);
% cla reset
% axes(handles.axes9);
% cla reset
% axes(handles.axes10);
% cla reset
% axes(handles.axes12);
% cla reset
% axes(handles.axes13);
% cla reset
% axes(handles.axes14);
% cla reset
% axes(handles.axes15);
% cla reset
% axes(handles.axes16);
% cla reset
clc
clear all 





% --- Executes on button press in close_pushbutton.
function close_pushbutton_Callback(hObject, eventdata, handles)
close all


% --- Executes on button press in save_pushbutton.
function save_pushbutton_Callback(hObject, eventdata, handles)
global fs          % sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y           %temp variable / single channel 
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn
save('r_data.txt')
save('f_data.txt')
save('r_data.mat')
save('f_data.mat')

dis='your feature data and removed artifact data seved in .txt and .mat format ';
helpdlg(dis,'save data');        
pause(50);







% --- Executes on button press in data_classification_button.
function data_classification_button_Callback(hObject, eventdata, handles)

global fs          % sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y           %temp variable / single channel 
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn


[fn,pn,in]=uigetfile();
temp_data=load([pn fn]);
clasification_data=temp_data;
[lenR_c_data,lenC_c_data]=size(clasification_data);
dis1=num2str(lenR_c_data);dis2=num2str(lenC_c_data);
dis3='your data have : ';dis4=' Raw => ';dis5=' column => ';
dis=strcat(dis3,dis4,dis1,dis5,dis2);
helpdlg(dis,'data');        
pause(50);



% --- Executes on button press in label_classification_button.
function label_classification_button_Callback(hObject, eventdata, handles)

global fs          % sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y           %temp variable / single channel 
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn

[fn,pn,in]=uigetfile();
temp_data=load([pn fn]);
label_data=temp_data;
[lenR_label,lenC_label]=size(label_data);
dis1=num2str(lenR_label);dis2=num2str(lenC_label);
dis3='your label have : ';dis4=' Raw => ';dis5=' column => ';
dis=strcat(dis3,dis4,dis1,dis5,dis2);
helpdlg(dis,'data');        
pause(50);


% --- Executes on button press in RUN_NN_button.
function RUN_NN_button_Callback(hObject, eventdata, handles)

global fs          % sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y           %temp variable / single channel 
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn

dis1='please waite ...  ';
dis=strcat(dis1);
helpdlg(dis,'NN');  
[ Acc_tr,Acc_ts,sen_tr,sen_ts,spe_tr,spe_ts ] = NN_function( clasification_data, label_data , num_nur , ttp);
dis2=num2str(Acc_tr);dis4=num2str(Acc_ts);
dis6=num2str(sen_tr);dis8=num2str(sen_ts);
dis10=num2str(spe_tr);dis12=num2str(spe_ts);
dis1='accuracy of train data : '; dis3=' accuracy of test data : ';
dis5=' sensitivity of train data : ';dis7=' sensitivity of test data : ';
dis9=' specificity of train data : ';dis11=' specificity of test data : ';
disx=' _ ';
%sensitivity and accuracy and specificity
dis1x=strcat(dis1,dis2,disx,dis3,dis4,dis5,dis6,disx);
dis2x=strcat(dis7,dis8,dis9,dis10,disx,dis11,dis12);
dis=strcat(dis1x,dis2x);
helpdlg(dis,'NN result');  
 
 
 
 
 


function enter_num_nur_Callback(hObject, eventdata, handles)
global fs          % sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y           %temp variable / single channel 
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of hidden layer neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn

editBoxContents = get(handles.enter_num_nur,'String');
num_nur = str2double(char(editBoxContents));
dis1=' number of hidden layer neurons  ';dis2=num2str(num_nur);dis3=' : ';
dis=strcat(dis1,dis3,dis2);
helpdlg(dis,'NN parameter');  


% --- Executes during object creation, after setting all properties.
function enter_num_nur_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ttp_Callback(hObject, eventdata, handles)
global fs          % sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y           %temp variable / single channel 
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn

editBoxContents = get(handles.ttp,'String');
ttp = str2double(char(editBoxContents));
dis1=' train percent ';dis2=num2str(ttp);dis3='%';dis4=' : ';
dis=strcat(dis1,dis4,dis2,dis3);
helpdlg(dis,'NN parameter');  


% --- Executes during object creation, after setting all properties.
function ttp_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ttp_knn_edit_Callback(hObject, eventdata, handles)

global fs          % sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y           %temp variable / single channel 
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn

editBoxContents = get(handles.ttp_knn_edit,'String');
ttp_knn = str2double(char(editBoxContents));
dis1=' train percent for knn ';dis2=num2str(ttp_knn);dis3='%';dis4=' : ';
dis=strcat(dis1,dis4,dis2,dis3);
helpdlg(dis,'Knn parameter');  


% --- Executes during object creation, after setting all properties.
function ttp_knn_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ttp_knn_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in knn_pushbutton.
function knn_pushbutton_Callback(hObject, eventdata, handles)
global fs          % sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y           %temp variable / single channel 
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent of nn
global ttp_knn   % train percent of knn

dis1='please waite ...  ';
dis=strcat(dis1);
helpdlg(dis,'K-NN');  
[acc_tr,acc_ts,se_tr,se_ts,sp_tr,sp_ts] = KNN_function( clasification_data , label_data , ttp_knn);
dis2=num2str(acc_tr);dis4=num2str(acc_ts);
dis6=num2str(se_tr);dis8=num2str(se_ts);
dis10=num2str(sp_tr);dis12=num2str(sp_ts);
dis1='accuracy of train data : '; dis3=' accuracy of test data : ';
dis5=' sensitivity of train data : ';dis7=' sensitivity of test data : ';
dis9=' specificity of train data : ';dis11=' specificity of test data : ';
disx=' _ ';
%sensitivity and accuracy and specificity
dis1x=strcat(dis1,dis2,disx,dis3,dis4,disx,dis5,dis6,disx);
dis2x=strcat(dis7,dis8,disx,dis9,dis10,disx,dis11,dis12);
dis=strcat(dis1x,dis2x);
helpdlg(dis,'K-NN result');  


% --- Executes on button press in svmpushbutton.
function svmpushbutton_Callback(hObject, eventdata, handles)
global fs          % sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y           %temp variable / single channel 
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent of nn
global ttp_knn   % train percent of knn
global ttp_svm 

dis1='please waite ...  ';
dis=strcat(dis1);
helpdlg(dis,'SVM');  
[acc_tr,acc_ts,se_tr,se_ts,sp_tr,sp_ts] = SVM_function( clasification_data , label_data , ttp_svm);
dis2=num2str(acc_tr);dis4=num2str(acc_ts);
dis6=num2str(se_tr);dis8=num2str(se_ts);
dis10=num2str(sp_tr);dis12=num2str(sp_ts);
dis1='accuracy of train data : '; dis3=' accuracy of test data : ';
dis5=' sensitivity of train data : ';dis7=' sensitivity of test data : ';
dis9=' specificity of train data : ';dis11=' specificity of test data : ';
disx=' _ ';
%sensitivity and accuracy and specificity
dis1x=strcat(dis1,dis2,disx,dis3,dis4,disx,dis5,dis6,disx);
dis2x=strcat(dis7,dis8,disx,dis9,dis10,disx,dis11,dis12);
dis=strcat(dis1x,dis2x);
helpdlg(dis,'SVM result');  



function svmedit_Callback(hObject, eventdata, handles)
global fs          % sampling rate
global r_data      %removed artifact data
global f_data      %feature data
global result
global m_data      %main data
global data        %temp variable data
global lenC        %lenght of column
global lenR  %lenght of raw
global t       
global y           %temp variable / single channel 
global stat_plot   % this is variabel for chissing ploting state
global lenR_label  % this is variable to keep len raw of label
global lenR_c_data % this is variable to keep len raw of data for classification
global lenC_label  % this is variable to keep len column of label
global lenC_c_data % this is variable to keep len column of data for classification
global clasification_data
global label_data
global num_nur   %number of neurons
global ttp       % tain percent
global ttp_knn   % train percent of knn
global ttp_svm 

editBoxContents = get(handles.ttp_knn_edit,'String');
ttp_svm = str2double(char(editBoxContents));
dis1=' train percent for svm ';dis2=num2str(ttp_svm);dis3='%';dis4=' : ';
dis=strcat(dis1,dis4,dis2,dis3);
helpdlg(dis,'Knn parameter');  

% --- Executes during object creation, after setting all properties.
function svmedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to svmedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
