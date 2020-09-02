function plot_many_osc_ARSA()

  f = "Arsa_data.txt";
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


  OSCnum = 3
  filename1 = returnFileName(OSCnum)
  
   filename = "C1yauza_elcetron_osc00003.txt";
   str1= strsplit(filename,{"osc",".t"})
  oscilNumber=str2double(str1(1,2))
  dataNum= oscilNumber+1;

  data = dlmread(filename, ',');
  [last_shift, column_size] = size(data)
  first_shift = 6;  
  step_read=last_shift/90000;
  time = data(first_shift:step_read: last_shift, 1);
  volt = data(first_shift:step_read: last_shift, 2);
  order = 13;
  sgf = sgolayfilt(volt,order,order+2);
  sgf1 = filtfilt(ones(1,10)/10,6,sgf);
  hold on
  time_new = time(10:size(time)-10);
  volt_new = sgf1(10:size(sgf1)-10);
  wave=1310;
  

##  ------------------------------------
  power = p(volt_new,wave);
  
  
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

    
  [a,b]=size(time_new)
  [c,d]= max(RNZ);
  
##  k_new(d),time_k_new(d),k_new(a/2),time_k_new(a/2),k_new(a),time_new(a)


  k=1;
  l=1;
##    x0= [k,l,RNZ(round(d*0.01)),time_new(round(d*0.01)),RNZ(round(a/2)),time_new(round(a/2)),RNZ(a),time_new(a),RNZ(round(d*0.3)),time_new(round(d*0.3))]
  x0= [k,l,RNZ(round(iter*1.1)),time_new(round(iter*1.1)),RNZ(round(a/2)),time_new(round(a/2)),RNZ(round(a*0.9)),time_new(round(a*0.9)),RNZ(round(d*0.3)),time_new(round(d*0.3))];
##x0= [k,l,RNZ(d),time_new(d),RNZ(a/2),time_new(a/2),RNZ(a),time_new(a)]
##gvar
##gvar;
[x, fval, info] = fsolve (@f,x0);
k=x(1);
l=x(2);

for(i=1:1:a)
 
 t_WB(i)= time_new(i);
 if(t_WB(i)<=0)
  y(i) = 0;
else
  y(i) = k/l*(t_WB(i)/l).^(k-1).*exp(-(t_WB(i)./l).^k);
 endif
 
 
endfor

##y = k/l*(t_WB/l).^(k-1).*exp(-(t_WB./l).^k);
  
  plot(time_new,RNZ,'b')
  plot(time_new,y,'r')
  grid minor on
##   axis([-0.00004, 0.002,-0.05,0.7]);
endfunction




function  y = f (x)

  y = zeros (3, 1);
persistent R1= x(3);
persistent R2= x(5);
persistent R3= x(5);
##persistent R4= x(7);
persistent T1= x(4);
persistent T2= x(6);
persistent T3= x(8);
##persistent T4= x(10)
y(1) = x(1)/x(2)*(T1/x(2))^(x(1)-1)*exp(-(T1/x(2))^x(1))-R1;
y(2) = x(1)/x(2)*(T2/x(2))^(x(1)-1)*exp(-(T2/x(2))^x(1))-R2;
y(3) = x(1)/x(2)*(T3/x(2))^(x(1)-1)*exp(-(T3/x(2))^x(1))-R3;
##y(4) = x(1)/x(2)*(T4/x(2))^(x(1)-1)*exp(-(T4/x(2))^x(1))-R4;


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
  
   filename= "test";
   [s1,s2]=size(ls);
   listOfOSc= dir()
##   listOfOSc= dir()(4,1)
   for(i=3:1:s1)
   i
##  listOfOSc(i).name

##   strsplit(listOfOSc(i).name,{"osc",".t"})(1,2)
     numOflist(i)= str2double(strsplit(listOfOSc(i).name,{"osc",".t"})(1,2))
##      if(OSCnum==numOflist(i))
####   numOflist
####   listOfOSc= dir()(i,1).name;
####    dir()(i,1).name
##   
##      endif
      
    
   endfor
   
   numOflist(3)
   
##   strsplit(listOfOSc,"\n")
##  str1= strsplit(filename,{"osc",".t"})
##  oscilNumber=str2double(str1(1,2))
##  dataNum= oscilNumber+1;
##  
endfunction
