function readFileNplotRNZ_ARSA()
   filename = "C1yauza_elcetron_osc00010.txt";
   data = dlmread(filename, ',');
  [last_shift, column_size] = size(data);
  first_shift = 6;  
  step_read=1;
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
 
  ave_offset= power_sum/iter;

  RNZ = -1*(10*log10(power)-10*log10( ave_offset));

##  ------------------------------------  
  third_ax=zeros(1,size(RNZ));
  
##  third_ax+1
  plot(time_new,log(RNZ),'b')
  grid minor on
  
  set(gca,"linewidth", 1,  "fontsize", 16) 
##  axis([-0.0004, 0.001]);
endfunction
