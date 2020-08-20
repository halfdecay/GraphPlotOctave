function readFileForPlot()

  fiber_lenght_normalization = 120 / 1000
  dose_rate = 58175/600

  first_line = 34
  start_time_line = 24
  
  #last_point_RNZ = - start_time_line + 85
  
  axisX = 4000
  axisY = 40
  
  filename = "ООВ 1310 нку 250к .txt";
  
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
  #t = t * dose_rate / 1000;
  [maxRNZ maxRNZ_time] = max (P)
  
  xxxxxxxxx = P(2)
  A10 = P(1:100:(maxRNZ_time+13))
  A11 = P(301:50:1002)
  
  
  
  t10 = t(1:100:(last_shift - first_shift))
 

  t11 = t(301:50:1002)
  
  d10 = t(1:100:3001)
  d10 = d10 * dose_rate / 1000
  
  Amax = P(maxRNZ_time)
  tmax = t(maxRNZ_time+52)
  dmax = tmax * dose_rate / 1000
 
  x1 = [t(maxRNZ_time+52), t(maxRNZ_time+52)]
  y1 = [0, maxRNZ]
  
 
  P = P(1:(last_shift - first_shift));
  t = t(1:(last_shift - first_shift));
  
  fig = plot( t, P, 'r', "linewidth",  1.4, x1, y1,  '--',"linewidth",  1.4);
  axis([0, axisX, 0, axisY]);
  
  
  xlabel( 't, c', "fontsize", 16)
  #xlabel( 'Д, {\cdot}10^3 ед.', "fontsize", 16)
  
  ylabel('РНЗ, дБ/км', "fontsize", 16)
  set(gca,"linewidth", 1,  "fontsize", 16)
  grid minor on

  legend ('РНЗ', 'Начало отжига', "location", "southoutside")
  
  
  

endfunction
