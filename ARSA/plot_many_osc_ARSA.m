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



   filename = "C1yauza_elcetron_osc00003.txt";
     
   data = dlmread(filename, ',');
  [last_shift, column_size] = size(data);
  first_shift = 6;  
  step_read=10;
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
  
##  k_new(d),time_k_new(d),k_new(a/2),time_k_new(a/2),k_new(a),time_new(a)



  k=3;
  l=3;
  x0= [k,l,RNZ(d+10),time_new(d+10),RNZ(round(a/2)),time_new(round(a/2)),RNZ(a),time_new(a)]
##x0= [k,l,RNZ(d),time_new(d),RNZ(a/2),time_new(a/2),RNZ(a),time_new(a)]
##gvar
##gvar
[x, fval, info] = fsolve (@f,x0)
k=x(1)
l=x(2)
y = k/l*(time_new/l).^(k-1).*exp(-(time_new./l).^k);
  
  plot(time_new,RNZ,'b')
  plot(time_new,y,'r')
  grid minor on
##   axis([-0.00004, 0.002,-0.05,0.7]);
endfunction




function  y = f (x)
##y(1) = k/l*(x/l)^(k-1)*exp(-(x/l)^k)
  y = zeros (3, 1);
  persistent R1= x(3)
   persistent R2= x(5)
   persistent R3= x(5)
     persistent T1= x(4)
   persistent T2= x(6)
   persistent T3= x(8)
  y(1) = x(1)/x(2)*(T1/x(2))^(x(1)-1)*exp(-(T1/x(2))^x(1))-R1;
  y(2) = x(1)/x(2)*(T2/x(2))^(x(1)-1)*exp(-(T2/x(2))^x(1))-R2;
  y(2) = x(1)/x(2)*(T3/x(2))^(x(1)-1)*exp(-(T3/x(2))^x(1))-R3;
##  y(2) =  3*x(1)^2 - 2*x(1)*x(2)^2 + 3*cos(x(1)) + 4;

endfunction
