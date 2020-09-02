function Arsa_analyze()
filename = "arsa\C1yauza_elcetron_osc00011.txt";
time = importfileTime(filename);
volt = importfileVolt(filename);
% save time
% save volt

order = 13;
  sgf = sgolayfilt(volt,order,order+2);
  sgf1 = filtfilt(ones(1,10)/10,1,sgf);
  hold on
  time_new = time(10:size(time)-10);
  volt_new = volt(10:size(sgf1)-10);
  wave=1310;
  
% ##  ------------------------------------
  if (wave == 1550) 
        power= volt_new *0.148315667734024+0.001240916854482;
  end
  if (wave == 1310)
      power = volt_new *0.277207551672137+0.002315948133696;
  end
  if (wave == 850)
      power = volt_new *0.987266707402605+0.01008908904627;
  end
  if (wave == 1300)
      power = volt_new *0.277207551672137+0.002315948133696;
  end
  [i, iw]=min(power); 
  iter=0;
  power_sum=0;
  
  for k=1:iw
    power_sum=power_sum+power(k);    
    iter=iter+1;
  end

  
  
  t=time_new(iter-15:size(time_new));

  Dr=10^12;
  R1=20;
  R2=20;
  t1=10^-8;
  C=10^-1;
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

%   [K1,T1,K2,T2,K3,T3]= variables(k_new(d),time_k_new(d),k_new(a/2),time_k_new(a/2),k_new(a),time_new(a))
  


save time_k_new 
save k_new
a =    0.004873 ;
       b =      0.7254  ;
       
        f = a*b*time_k_new.^(b-1).*exp(-a*time_k_new.^b);

%  plot(time_k_new,k_new/k_teor ,'b')
  plot(time_k_new,k_new,'b')
  plot(time_k_new,f,'r')
%   plot(t,k_teor,'r')

grid  on
axis([-0.000001, 0.00001,-0.05,0.35]);
% save data
end
