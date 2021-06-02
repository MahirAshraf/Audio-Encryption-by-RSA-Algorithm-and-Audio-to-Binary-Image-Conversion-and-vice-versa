function varargout = guitest1(varargin)
% GUITEST1 MATLAB code for guitest1.fig
%      GUITEST1, by itself, creates a new GUITEST1 or raises the existing
%      singleton*.
%
%      H = GUITEST1 returns the handle to a new GUITEST1 or the handle to
%      the existing singleton*.
%
%      GUITEST1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITEST1.M with the given input arguments.
%
%      GUITEST1('Property','Value',...) creates a new GUITEST1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guitest1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guitest1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guitest1

% Last Modified by GUIDE v2.5 14-Jul-2020 00:01:05

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guitest1_OpeningFcn, ...
                   'gui_OutputFcn',  @guitest1_OutputFcn, ...
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


% --- Executes just before guitest1 is made visible.
function guitest1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guitest1 (see VARARGIN)

% Choose default command line output for guitest1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guitest1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guitest1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[fname path]=uigetfile('*.*','Enter message Audio');
fname=strcat(path,fname);


[w, Fs]=audioread(fname);

setappdata(0,'app_w',w);
setappdata(0,'app_Fs',Fs);
assignin('base','w',w);
assignin('base','Fs',Fs);




% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EncryptionTimer=1;
setappdata(0,'app_EncTimer',EncryptionTimer);



fid2= fopen('private key 2.txt','r');
C = textscan(fid2,'%f');
fclose(fid2);
celldisp(C);
formatSpec = '%f';
fid2= fopen('private key 2.txt','r');
A = fscanf(fid2 ,formatSpec);
fclose(fid2);





N=A(3);            
phi_N=A(4);
e=A(5);


w=getappdata(0,'app_w');
Fs=getappdata(0,'app_Fs');



len002=length(w);
channel01=w(:,1);
channel02=w(:,2);

    

D=channel01(1:len002);
figure(2)

plot(D);
grid on
title('Original Audio channel 1');
xlabel('Samples');
ylabel('Amplitude');


D2=channel02(1:len002);
figure(3)

plot(D2);
grid on
title('Original Audio channel 2');
xlabel('Samples');
ylabel('Amplitude');



len01=length(w);
Nc=zeros(len01,2);

for i=1:2
    for i02=1:len01;
        if w(i02,i)<0;
           Nc(i02,i)=1;
        else  Nc(i02,i)=0;
        end
    end
end

setappdata(0,'app_Nc',Nc);

w_org=w;

setappdata(0,'app_worg',w_org);




len21=length(w);
max121=max(w);
w121=w(:,1);
w121=w121*(1/max121(1));
w221=w(:,2);
w231=w221*(1/max121(1));
new_w2=[w121 w231];
round_wyt=round(new_w2,2);


for(i=1:2)
	w1=w(:,i);
	mx=max(abs(w1));
	w1=w1/mx;
	w(:,i)=w1;
end
w=abs(w);
w2=w*1000;

len01=length(w2);
setappdata(0,'app_len01',len01);

EnC=zeros(len01,2);
Decr=zeros(len01,2);

w2=round(w2);
assignin('base','w2',w2);

for i=1:2
    for i02=1:len01;
        me=(w2(i02,i))^e;
        c=mod(me,N);
        EnC(i02,i)=c;
    end
end
EnC=powermod(w2,e,N);


assignin('base','N',N);            
assignin('base','phi_N',phi_N);
assignin('base','e',e);

setappdata(0,'app_N',N);
setappdata(0,'app_phi_N',phi_N);
setappdata(0,'app_e',e);


assignin('base','EnC',EnC);
setappdata(0,'app_EnC',EnC);
EncryptionTimer=56;
assignin('base','EncryptionTimer',EncryptionTimer);
setappdata(0,'app_EncTimer',EncryptionTimer);
FileName01='Encrypted_Audio.wav';
Fs=getappdata(0,'app_Fs');
audiowrite(FileName01,EnC,Fs);
msg0001=msgbox('Encryption Complete');

len002=length(EnC);
channel01=EnC(:,1);
channel02=EnC(:,2);

    

D3=channel01(1:len002);
figure(6)

plot(D3);
grid on
title('Encrypted Audio channel 1');
xlabel('Samples');
ylabel('Amplitude');


D4=channel02(1:len002);
figure(7)

plot(D4);
grid on
title('Encrypted Audio channel 2');
xlabel('Samples');
ylabel('Amplitude');





% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

w=getappdata(0,'app_w');
Fs=getappdata(0,'app_Fs');


player5 = audioplayer(w,Fs);

audioObject5=player5;
assignin('base','audioObject5',audioObject5);

playblocking(player5);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

w=getappdata(0,'app_w');
Fs=getappdata(0,'app_Fs');


player1 = audioplayer(w,Fs);

audioObject=player1;
assignin('base','audioObject',audioObject);

%setappdata(0,'app_EnC',EnC);

playblocking(player1);




% --- Executes on button press in pushbutton11.


function pushbutton11_Callback(hObject, eventdata, handles)

% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%------key generator---------


x1=randi([1e2,1e3]);
prime1  =prevprime(x1);
x2=randi([1e2,1e3]);
prime2  =prevprime(x2);
N=prime1*prime2;
phi_N=(prime1-1)*(prime2-1);

a=randi([1,50]);
b=phi_N;
cond=0;
while cond==0;
    r=gcd(a,b);
    if r==1;
    break
    end
    a=randi([1,50]);
end
e=a;


    
% factors for 1st number


K=1:a;
D1 = K(rem(a,K)==0)
% factors for 2nd number
K=1:b;
D2 = K(rem(b,K)==0)
n1=length(D1);
n2=length(D2);

r = 1;
for i=2:n1
        for o=2:n2
                if (D1(i)==D2(o))
                r=0;
                break
                else
                    if (D1(i)~=D2(o))
                            r=1;
                        end
        end
        if r == 0
           break
        end
        end
if r==1
    break
end
end

fid=fopen('private key 2.txt','w');
fprintf(fid, '%f \n', [prime1 prime2 N phi_N e]);
fclose(fid)



% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

EnC=getappdata(0,'app_EnC');
Fs=getappdata(0,'app_Fs');

player2 = audioplayer(EnC,Fs);

audioObject2=player2;
assignin('base','audioObject2',audioObject2);


playblocking(player2);




% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.text6,'string','Proccessing...');

EnC=getappdata(0,'app_EnC');
Fs=getappdata(0,'app_Fs');
N=getappdata(0,'app_N');
phi_N=getappdata(0,'app_phi_N');
e=getappdata(0,'app_e');

w_org=getappdata(0,'app_worg');

DecryptTimer=1;
assignin('base','DecryptTimer',DecryptTimer);
setappdata(0,'app_DecryptTimer',DecryptTimer);


a1=1;
b1=0;
a2=0;
b2=1;
a3=a1;
b3=a1;
a=[a1; a2; a3];
b=[b1; b2; b3];


y1=phi_N;
y2=e;

y=[y1;y2;0];
k=[0 0 0]
k(2)=floor(y(1)/y(2));
cond02=0;

len01=getappdata(0,'app_len01');

Decr=zeros(len01,2);

len01=getappdata(0,'app_len01');

    while cond02==0;
       
        k(2)=floor(y(1)/y(2));
        a3=a(1)-a(2)*k(2);
        b3=b(1)-b(2)*k(2);
        y3=y(1)-y(2)*k(2);
       
       if y3==1
            break
        end
        
        a(1)=a(2);
        a(2)=a3;
  
        b(1)=b(2);
        b(1)=b(2);
        b(2)=b3;
        
        
        y(1)=y(2);
        y(2)=y3;
       
 end
    d=b3;
    if d>0;
        d=d+phi_N;
    else
        d=mod(d,phi_N);
    end
    EnC=round(EnC);
    
    
    
    
   
    
for j=1:2
    for j02=1:len01;
        
        
        x=EnC(j02,j);
        p=d;
        

%Compute x^p mod N, 
% x, p and N are integers
A=1;	
while( p > 0 )
	if mod(p,2)==1, A = mod( A*x, N ); 
    end
   	x = mod( x*x, N );
	p = floor( p/2 );
end
        
        %m=powermod(EnC(j02,j),d,N);
        j02;
        Decr(j02,j)=x;
    end
end



EnC_round=round(EnC);
Decr=powermod(EnC_round,d,N);


Decr=Decr/1000;

Nc=getappdata(0,'app_Nc');

for i=1:2
    for i02=1:len01;
        if Nc(i02,i)==1;
            Decr(i02,i)=Decr(i02,i)*(-1);
            
        end
    end
end

    Decr1=Decr(:,1);
	mx1=max(w_org(:,1));
	Decr1=Decr1*mx1;
	Decr2=Decr(:,2);
    mx2=max(w_org(:,2));
	Decr2=Decr2*mx2;
    Decr=[Decr1 Decr2];

setappdata(0,'app_Decr',Decr);
DecryptTimer=1000;
assignin('base','DecryptTimer',DecryptTimer); 
setappdata(0,'app_DecryptTimer',DecryptTimer);

assignin('base','Decr',Decr);

FileName02='Decrypted_Audio.wav';
Fs=getappdata(0,'app_Fs');
audiowrite(FileName02,Decr,Fs);
msg002=msgbox('Decryption Complete');


len002=length(Decr);
channel01=Decr(:,1);
channel02=Decr(:,2);

D5=channel01(1:len002);
figure(7)

plot(D5);
grid on
title('Decrypted Audio channel 1');
xlabel('Samples');
ylabel('Amplitude');


D6=channel02(1:len002);
figure(8)

plot(D6);
grid on
title('Decrypted Audio channel 2');
xlabel('Samples');
ylabel('Amplitude');




% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



Decr=getappdata(0,'app_Decr');
Fs=getappdata(0,'app_Fs');
player3=audioplayer(Decr,Fs);

audioObject3=player3;
assignin('base','audioObject3',audioObject3);

playblocking(player3);



% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

player2 = evalin('base','audioObject2');

stop(player2);


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
player3 = evalin('base','audioObject3');

stop(player3);




% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
player1 = evalin('base','audioObject');

stop(player1);


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
player5 = evalin('base','audioObject5');

stop(player5);



% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4

msg_a=('You may can now start recording');
Choose_recording = 15;
setappdata(0,'app_Choose_recording',Choose_recording);


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Choose_recording=getappdata(0,'app_Choose_recording');
if Choose_recording == 15;
    Fs=getappdata(0,'app_Fs');
    nBits=getappdata(0,'app_nBits');
    record_time=getappdata(0,'app_record_time');
    sig = audiorecorder(Fs, nBits, 2);
    recordblocking(sig,record_time);
    w = getaudiodata(sig);
    FileName1='Recorded_audio.wav';
    audiowrite(FileName1,w,Fs);
    assignin('base','w',w);
    setappdata(0,'app_w',w);
else msgbox('You havent chosen Recording yet');
end
    
    
    



% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

EncryptionTimer=getappdata(0,'app_EncTimer');
if EncryptionTimer==56
    set(handles.text3,'string','Encryption Complete');
elseif EncryptionTimer==1
    set(handles.text3,'string','Proccessing...');
else set(handles.text3,'string','Error!');
end


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

DecryptTimer=getappdata(0,'app_DecryptTimer');
if DecryptTimer==1000
    set(handles.text6,'string','Decrpytion Complete');
elseif DecryptTimer==1
    set(handles.text6,'string','Proccessing...');
else set(handles.text6,'string','Error!');
end


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

b=getappdata(0,'app_b');


len002=length(b);
chknum=sqrt(len002);
chknum=floor(chknum);

for i=1:(len002)/2
    chk02=mod(len002,chknum)
    if chk02==0;
        break;
    end
    chknum=chknum+1;
end

chknum01=chknum;
chknum02=len002/chknum;


channel01=b(:,1);
channel02=b(:,2);

D=channel01(1:len002);
figure(1)
plot(D);
grid on
xlabel('Samples');
ylabel('Amplitude');


x=1;
y=chknum01;
for i=1:chknum02
    L=D(x:y);
    N=L';
    A(i,:)=N;
    x=x+chknum01;
    y=y+chknum01;
    
end

imwrite(A,'testimg1.jpg');


D=channel02(1:len002);
figure(2)
plot(D);
grid on
xlabel('Samples');
ylabel('Amplitude');



x=1;
y=chknum01;
for i=1:chknum02
    L=D(x:y);
    N=L';
    A(i,:)=N;
    x=x+chknum01;
    y=y+chknum01;
    
end

imwrite(A,'testimg2.jpg');
setappdata(0,'app_chknum02',chknum02);





% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

b=getappdata(0,'app_b');
chknum02 = getappdata(0,'app_chknum02');


Aajpg=imread('testimg1.jpg');
Aajpg=im2double(Aajpg);

Jpeg01=[;];
for i=1:chknum02
    w=Aajpg(i,:);
    m=w';
    Jpeg01=vertcat(Jpeg01,m);
end


Aajpg02=imread('testimg2.jpg');
Aajpg02=im2double(Aajpg02);

Jpeg02=[;];
for i=1:chknum02
    w=Aajpg02(i,:);
    m=w';
    Jpeg02=vertcat(Jpeg02,m);
end
 Towrite=[Jpeg01 Jpeg02];

i=1;
FileName='testaudio.wav';
Fs=getappdata(0,'app_Fs');

len002=length(Towrite);

channel01=Towrite(:,1);
channel02=Towrite(:,2);

D=channel01(1:len002);
figure(10)
plot(D);
grid on
xlabel('Samples');
ylabel('Amplitude');

D=channel02(1:len002);
figure(11)
plot(D);
grid on
xlabel('Samples');
ylabel('Amplitude');

Fs=getappdata(0,'app_Fs');
audiowrite(FileName,Towrite,Fs);
setappdata(0,'app_Towrite',Towrite);




% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

contents=cellstr(get(hObject,'string'));
pop_choice01=contents{get(hObject,'Value')};

pop_choice01
if(strcmp(pop_choice01,'Browse..'))
    dep_ix=100;
    setappdata(0,'app_dep_ix',dep_ix);
elseif(strcmp(pop_choice01,'Use the Encrypted Audio'))
    dep_ix=200;
     setappdata(0,'app_dep_ix',dep_ix);
elseif(strcmp(pop_choice01,'Use the Decrypted Audio'))
    dep_ix=300;
     setappdata(0,'app_dep_ix',dep_ix);
%else dep_ix=400;
end

value_audio_to_img=get(handles.popupmenu2,'Value');


% place the value next to the field


if value_audio_to_img==2
    dep_ix=100;
     setappdata(0,'app_dep_ix',dep_ix);
elseif value_audio_to_img==3
    dep_ix=200;
     setappdata(0,'app_dep_ix',dep_ix);
elseif value_audio_to_img==4
    dep_ix=300;
     setappdata(0,'app_dep_ix',dep_ix);
%else  dep_ix=400;
end


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dep_ix=getappdata(0,'app_dep_ix');
if dep_ix==100;
[fname path]=uigetfile('*.*','Enter message Audio');
fname=strcat(path,fname);
[w, Fs]=audioread(fname);
b=w;
C=b(b>=0);
setappdata(0,'app_Fs',Fs);

elseif dep_ix==200;
    EnC=getappdata(0,'app_EnC');
    Fs=getappdata(0,'app_Fs');
    w=EnC;
    b=w;
    C=b(b>=0);
    
elseif dep_ix==300;
    Decr=getappdata(0,'app_Decr');
    Fs=getappdata(0,'app_Fs');
    w=Decr;
    b=w;
    C=b(b>=0);
else filenotselected=msgbox('You havent selected the file properly');
end

setappdata(0,'app_b',b);

    
    
    
        
% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Towrite = getappdata(0,'app_Towrite');
Fs=getappdata(0,'app_Fs');


player4 = audioplayer(Towrite,Fs);

audioObject4=player4;
assignin('base','audioObject4',audioObject4);

%setappdata(0,'app_EnC',EnC);

playblocking(player4);


% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

player4 = evalin('base','audioObject4');

stop(player4);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Choose_recording=getappdata(0,'app_Choose_recording');
if Choose_recording == 15;
    record_time01=get(handles.edit1,'string');
    record_time=str2double(record_time01);
    setappdata(0,'app_record_time',record_time);
    Fs01=get(handles.edit2,'string');
    Fs=str2double(Fs01);
    setappdata(0,'app_Fs',Fs);
    nBits01=get(handles.edit3,'string');
    nBits=str2double(nBits01);
    setappdata(0,'app_nBits',nBits);
    assignin('base','record_time',record_time);
    assignin('base','Fs',Fs);
    assignin('base','nBits',nBits);
else msgbox('You havent chosen Recording yet');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fname path]=uigetfile('*.*','Enter message Audio');
fname=strcat(path,fname);
[w, Fsa]=audioread(fname);
player1 = audioplayer(w,Fsa);


num=[1,zeros(1,4800),0.95];
den=[1];
x=filter(num,den,w);
pecho=audioplayer(x,Fsa);


FileName='Yokai.wav';
audiowrite(FileName,x,Fsa);
setappdata(0,'app_Echoed',x);
setappdata(0,'app_Fsa',Fsa);


% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



[fname path]=uigetfile('*.*','Enter message Audio');
fname=strcat(path,fname);
[x, Fsa]=audioread(fname);
Fsa=getappdata(0,'app_Fsa');

den=[1,zeros(1,4800),0.95];
num=[1];
r=filter(num,den,x);
nopecho=audioplayer(r,Fsa);
setappdata(0,'app_nonecho',r);




% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

echoed=getappdata(0,'app_Echoed');
Fsa=getappdata(0,'app_Fsa');


player6 = audioplayer(echoed,Fsa);

audioObject6=player6;
assignin('base','audioObject6',audioObject6);

playblocking(player6);



% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



r=getappdata(0,'app_nonecho');

Fsa=getappdata(0,'app_Fsa');


player7 = audioplayer(r,Fsa);

audioObject7=player7;
assignin('base','audioObject7',audioObject7);

playblocking(player7);


% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
player6 = evalin('base','audioObject6');

stop(player6);



% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
player7 = evalin('base','audioObject7');

stop(player7);
