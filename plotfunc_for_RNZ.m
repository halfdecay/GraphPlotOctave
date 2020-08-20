function readFileForPlot()

  fiber_lenght_normalization = 120 / 1000
  dose_rate = 5302.5/60

  first_line = 34
  start_time_line = 13
  
  #last_point_RNZ = - start_time_line + 85
  
  axisX = 8
  axisY = 50
  filename = "ÎÎÂ 1550 ìèíóñ.txt";
  
  #-----------------------------------------------
  data = dlmread(filename, '\t');
  [last_shift, column_size] = size(data)
  data (first_line + start_time_line, column_size);
  first_shift = first_line + start_time_line;
  
  t = data(first_shift : last_shift, 1);
  
  t = t - t(1);
  P = data(first_shift: last_shift, 2);
  
  
  minP = min (P)
  maxP = max (P)
  
     
      
     
  
  P = (10 * log10(P / 0.000001) - 10 * log10(maxP / 0.000001)) * (-1) / fiber_lenght_normalization;
  t = t * dose_rate / 1000;
  [maxRNZ maxRNZ_time] = max (P)
  
  xxxxxxxxx = P(2)
  #A10 = P(1:100:(maxRNZ_time))
  #A11 = P(301:50:1002)
  
  
  
  #t10 = t(1:100:(last_shift - first_shift))
 

  #t11 = t(301:50:1002)
  
  #d10 = t(1:100:(3016));
  #d10 = d10 * dose_rate / 1000
  
  Amax = P(maxRNZ_time)
  tmax = t(maxRNZ_time)
  dmax = tmax * dose_rate / 1000
 
  x1 = [t(maxRNZ_time), t(maxRNZ_time)]
  y1 = [0, maxRNZ]
  
 
  P = P(1:maxRNZ_time);
  t = t(1:maxRNZ_time);
  x1 = [t(maxRNZ_time), t(maxRNZ_time)]
  y1 = [0, maxRNZ]
  
  fig = plot( t, P, 'r', "linewidth",  1.4);
  axis([0, axisX, 0, axisY]);
  
  
  #xlabel( 't, c', "fontsize", 16)
  xlabel( 'Ä, {\cdot}10^3 åä.', "fontsize", 16)
  
  ylabel('ÐÍÇ, äÁ/êì', "fontsize", 16)
  set(gca,"linewidth", 1,  "fontsize", 16)
  grid minor on

  
  
  
  

endfunction
