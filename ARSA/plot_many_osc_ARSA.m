function plot_many_osc_ARSA()

  f = "Arsa_data.txt";
 
  
  [z,k,Z,T,Umon,wave,oscnum,Dose]=getdataArsa(f);

  oscnum;

  
  
oscillograms = [3:13,15:20]
[s5,s6]=size(oscillograms)
## global dataApprox = zeros (s6, 2);
##  k=zeros (s6, 1)
##  l=zeros (s6, 1);
##for(kapa=1:1:s6)
kapa=11

  OSCnum =oscillograms(kapa)
##OSCnum =8
  
  plotName=strcat("T",int2str( T(OSCnum)),"_wave",int2str( wave(OSCnum)),"_dose" ,int2str( Dose(OSCnum)/10^(8)),"e+8_osc",int2str( oscnum(OSCnum)),".png")         ;
  Umon(OSCnum);
  T(OSCnum);
  wave(OSCnum);
  oscnum(OSCnum);
  filename = returnFileName(oscnum(OSCnum));
  str1= strsplit(filename,{"osc",".t"});
  oscilNumber=str2double(str1(1,2));
  dataNum= oscilNumber+1;

  data = dlmread(filename, ',');
  [last_shift, column_size] = size(data)
  first_shift = 6;  
  step_read=round( last_shift/90000);
  time = data(first_shift:step_read: last_shift, 1);
  volt = data(first_shift:step_read: last_shift, 2);
  order = 13;
  sgf = sgolayfilt(volt,order,order+2);
  sgf1 = filtfilt(ones(1,10)/10,6,sgf);
##  hold on
  time_new = time(10:size(time)-10);
  volt_new = sgf1(10:size(sgf1)-10);

  


  power = p(volt_new,wave(OSCnum));
  
  
  [i, iw]=min(power); 
  iter=0;
  power_sum=0;
  for k=1:iw
    power_sum=power_sum+power(k);    
    iter=iter+1;
  endfor

##  t=time_new(iter-10:size(time_new));
  ave_offset= power_sum/iter;
  RNZ =-10*(log10(power/ave_offset));    
  [a,b]=size(time_new);
  [c,d]= max(RNZ);
  
  amp = 50
  x0= [1,1,(RNZ(round(iter*1.05)+amp)+ RNZ(round(iter*1.05))+RNZ(round(iter*1.05)-amp))/3,time_new(round(iter*1.05)),(RNZ(round(a/2))+RNZ(round(a/2)-amp)+RNZ(round(a/2)+amp))/3,time_new(round(a/2)),(RNZ(round(a*0.9)+amp)+RNZ(round(a*0.9))+RNZ(round(a*0.9)-amp))/3,time_new(round(a*0.9)),RNZ(round(d*0.3)),time_new(round(d*0.3))];;
  [x, fval, info] = fsolve (@f,x0);
  k=x(1)
  l=x(2)

  

  for(i=1:1:a)
    t_WB(i)= time_new(i);
    if(t_WB(i)<=0)
    y(i) = 0;
    else
    y(i) = k/l*(t_WB(i)/l).^(k-1).*exp(-(t_WB(i)./l).^k);
    endif
  endfor
  
  
  
  sgf3 = filtfilt(ones(1,10)/10,1,y);
  hf = figure ();
  plot(time_new,RNZ,'b',time_new,sgf3,'r');
  grid minor on
  ylabel ("RNZ, dB");
  xlabel ( "T, s");  
  mainPath=pwd
  cd ("Graphs")

  print (hf, plotName,"-solid");
  
  
 strArr =strcat( int2str( T(OSCnum)),",",int2str( wave(OSCnum)),"," ,num2str( Dose(OSCnum)),"," ,int2str( oscnum(OSCnum)),"," ,num2str(k) , ',',num2str(l),'\n')
  fout = fopen('output.txt', 'at+');
  fprintf (fout,strArr);
  
  
  fclose(fout);
  cd (mainPath)
##  close(hf)
  
##  
##  dataApprox(kapa,1)=k
##  dataApprox(kapa,2)=l

   
  
##  endfor

  
endfunction




function  y = f (x)
  y = zeros (3, 1);
  persistent R1= x(3);
  persistent R2= x(5);
  persistent R3= x(5);
  persistent T1= x(4);
  persistent T2= x(6);
  persistent T3= x(8);
  y(1) = x(1)/x(2)*(T1/x(2))^(x(1)-1)*exp(-(T1/x(2))^x(1))-R1;
  y(2) = x(1)/x(2)*(T2/x(2))^(x(1)-1)*exp(-(T2/x(2))^x(1))-R2;
  y(3) = x(1)/x(2)*(T3/x(2))^(x(1)-1)*exp(-(T3/x(2))^x(1))-R3;
endfunction



function power = p(volt_new,wave)
  if (wave == 1550) 
        power= volt_new *0.148315667734024+0.001240916854482;
  endif
  if (wave == 1310)
      power = volt_new *0.277207551672137+0.002315948133696;
  endif
  if (wave == 850)
      power = volt_new *0.987266707402605+0.01008908904627;
  endif
  if (wave == 1300)
      power = volt_new *0.277207551672137+0.002315948133696;
  endif
endfunction


function    filename = returnFileName(OSCnum)
  [s1,s2]=size(ls);
  listOfOSc= dir();
  for(i=3:1:s1)
  numOflist(i)= str2double(strsplit(listOfOSc(i).name,{"osc",".t"})(1,2));
  endfor
  [s3,s4] = size(numOflist);

  for(k=3:1:s4)
  if(OSCnum- numOflist(k)==0)
  filename= listOfOSc(k).name  
  endif
endfor


endfunction


function    [z,k,Z,T,Umon,wave,oscnum,Dose]=getdataArsa(f)
  [a,b,c]= importdata (f);
  [z,k]=size(a.data);
  Z=a.data(1:z,2);
  T=a.data(1:z,3);
  Umon=a.data(1:z,4);
  wave=a.data(1:z,5);
  oscnum=a.data(1:z,6);
  for(i=1:1:z)
  Dose(i)=Umon(i)*39769/(Z(i)+5.2).^2.086*2*10^8;
  endfor
endfunction
