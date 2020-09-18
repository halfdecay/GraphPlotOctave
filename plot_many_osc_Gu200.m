function plot_many_osc_Gu200()

    len_fiber =0.12

  
  filename = "мов 1300 нку оов 1310 минус (copy).txt";
##  filename = "Multi_01.txt";
  [data1,data2,data3]= importdata (filename);
  [last_shift, column_size] = size(data1)
  first_shift = 49;  
  step_read=1;
 data4 =  data1(first_shift:step_read: last_shift, 1); 
 iter=0
  for k=1:1:size(data4)-1 
##    str2num(cell2mat(strsplit(char(data4(k)), "\t")(3)))
    if( isnan(str2num(cell2mat(strsplit(char(data4(k)), "\t")(2))))==0)    
    iter=iter+1;
    power(iter)=str2num(cell2mat(strsplit(char(data4(k)), "\t")(2)));
    time(iter)=str2num(cell2mat(strsplit(char(data4(k)), "\t")(1)))    ;
    endif
  endfor

    
  [i, iw]=max(power); 
  iter=0;
  power_sum=0;
  for k=1:iw
    power_sum=power_sum+power(k);    
    iter=iter+1;
  endfor

  ave_offset= power_sum/iter;

RNZ =(10 * log10(power / 0.001)-10 * log10(ave_offset / 0.001) ) * (-1)  /0.120 ;



  
  
  
##    filename = "мов 1300 нку оов 1310 минус.txt";
  filename = "Multi_01.txt";
  [data1,data2,data3]= importdata (filename);
  [last_shift, column_size] = size(data1)
  first_shift = 49;  
  step_read=1;
 data4 =  data1(first_shift:step_read: last_shift, 1); 
 iter=0
  for k=1:1:size(data4)-1 
##    str2num(cell2mat(strsplit(char(data4(k)), "\t")(3)))
    if( isnan(str2num(cell2mat(strsplit(char(data4(k)), "\t")(4))))==0)    
    iter=iter+1;
    power1(iter)=str2num(cell2mat(strsplit(char(data4(k)), "\t")(4)));
    time1(iter)=str2num(cell2mat(strsplit(char(data4(k)), "\t")(1)))    ;
    endif
  endfor
      

    
  [i, iw]=max(power1); 
  iter=0;
  power_sum1=0;
  for k=1:iw
    power_sum1=power_sum1+power1(k);    
    iter=iter+1;
  endfor

  ave_offset1= power_sum1/iter;

RNZ1 =(10 * log10(power1 / 0.001) -10 * log10(ave_offset1 / 0.001)) * (-1)  /0.120 ;


  plot(time*80-1000,RNZ,'bk', "linewidth",  1.4,time1*20-800,RNZ1,'--r', "linewidth",  1.4);
##  plot(time*80-1000,RNZ,'bk');
  grid minor on
  ylabel ("РНЗ, дБ/км", "fontsize", 14);
  xlabel ( "Д, ед.", "fontsize", 14); 
  legend ({' T=-40\pm5\degC 	\lambda = 1310 нм   P = 86 ед./с',' T=-40\pm5\degC 	\lambda = 1310 нм   P = 20 ед./с'}, "location", "east");
  
  set(gca,"linewidth", 1,  "fontsize", 14)
  grid minor on
gra  hold on
 legend hide
 legend show
 
 
  

  
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
