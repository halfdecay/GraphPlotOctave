

function test_ARSA()
  global K1
  global T1
  global K2
  global T2
  global K3
  global T3

  
  
  filename = "C1yauza_elcetron_osc00003.txt";
  data = dlmread(filename, ',');
  [last_shift, column_size] = size(data);
  first_shift = 6;  
  step_read=10;
  time = data(first_shift:step_read: last_shift, 1);
  volt = data(first_shift:step_read: last_shift, 2);
  order = 13;
  sgf = sgolayfilt(volt,order,order+2);
  sgf1 = filtfilt(ones(1,10)/10,1,sgf);
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

  
  
  t=time_new(iter-15:size(time_new));

  Dr=10^12;
  R1=200000000000;
  R2=200000000;
  t1=10^-8;
  C=10^-16;
  A=((R1+R2)/R1/R2/C);

  part1 = (Dr/R1/R2/C);
  part2 = -1/((R1+R2)/R1/R2/C)^2*(Dr/R1/R2/C)*(exp(-((R1+R2)/R1/R2/C)*t)-1)*(exp(((R1+R2)/R1/R2/C)*t1)-1);
  part3 = 1/((R1+R2)/R1/R2/C)*(Dr/R1/R2/C)*(exp(-((R1+R2)/R1/R2/C)*(t-t1))+1/((R1+R2)/R1/R2/C)*(exp(-((R1+R2)/R1/R2/C)*(t-t1))-exp(((R1+R2)/R1/R2/C)*t1)));

  k_teor=-1/((R1+R2)/R1/R2/C)^2*(Dr/R1/R2/C)*(exp(-((R1+R2)/R1/R2/C)*t)-1)*(exp(((R1+R2)/R1/R2/C)*t1)-1)+1/((R1+R2)/R1/R2/C)*(Dr/R1/R2/C)*(exp(-((R1+R2)/R1/R2/C)*(t-t1))+1/((R1+R2)/R1/R2/C)*(exp(-((R1+R2)/R1/R2/C)*(t-t1))-exp(((R1+R2)/R1/R2/C)*t1)));
  ave_offset= power_sum/iter;

  k = -1*log(power/ave_offset);
  k_new = k(iter-15:size(t));
  k(1)
  time_k_new=time_new(iter-15:size(t));
  
  [a,b]=size(time_k_new);
  [c,d]= max(k_new);

  [K1,T1,K2,T2,K3,T3]= variables(k_new(d),time_k_new(d),k_new(a/2),time_k_new(a/2),k_new(a),time_new(a))
  

##  ------------------------------------  
##  third_ax=zeros(1,size(RNZ));
  
##  third_ax+1


##  k_new, k_teor
##   kapa=k_new/k_teor
##  plot(time_k_new,k_new/k_teor ,'b')
  plot(time_k_new,k_new,'b')
##  plot(t,k_teor,'r')
##  plot(t,part2,'g')
##  plot(t,part3,'p')
##   plot(t,part3,'p')

  
  
 
##
## ax(1) = subplot (221);
## set (ax(1), "tag", "1");
## plot (time_k_new,k_new ,'b');
## title ("k new");
##   grid minor on
## xlabel xlabel;
## ylabel ylabel;
## ax(2) = subplot (222);
## set (ax(2), "tag", "2");
## plot (t,k_teor,'r');
##   grid minor on
## title ("k teor");
## xlabel xlabel;
## ylabel ylabel;
## ax(3) = subplot (223);
## set (ax(3), "tag", "3");
## plot (t,part2,'g');
##   grid minor on
## title ("part2");
## xlabel xlabel;
## ylabel ylabel;
## ax(4) = subplot (224);
## set (ax(4), "tag", "4");
## plot (t,part3,'p');
## title ("part3");
## xlabel xlabel;
## ylabel ylabel;
 grid minor on  
##  set(gca,"linewidth", 1,  "fontsize", 16) 
##  axis([-0.00004, 0.001,-0.05,0.2]);

##
x0= [R1,R2,C];

[x, fval, info] = fsolve (@f,x0)

endfunction

function  y = f (x)
y = zeros (3, 1);
y(1) = x(1)-x(2)+x(3);
y(2) = 2*x(1)-x(2)*2+x(3);
y(3) = 9*x(1)-x(2)+x(3);
  


endfunction



function [K1,T1,K2,T2,K3,T3] = variables(a1,a2,a3,a4,a5,a6)
  
    

  K1=  a1;
  T1=  a2;
  K2=  a3;
  T2=  a4;
  K3=  a5;
  T3=  a6;
endfunction



