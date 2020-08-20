function readFileForPlot()

  fiber_lenght_normalization = 120 / 1000
  dose_rate = 45325/600


  start_time_line1 = 3200
  start_time_line2 = start_time_line1
  
  #last_point_RNZ = - start_time_line + 85
  
  axisX = 6000
  axisY = 80
  
  filename1 = "Время.txt";
  
  filename2 = "Столбец 1.txt";
  
  filename3 = "Столбец 2.txt";
  
  #-----------------------------------------------
  data = dlmread(filename1, '\t');
  [last_shift, column_size] = size(data)
  data (1, column_size);
  first_shift = 1;
  
  t = data(first_shift: last_shift, 1);
  
  
  data = dlmread(filename2, '\t');
  [last_shift, column_size] = size(data)
  data (1 + start_time_line1, column_size);
  first_shift1 = 1 + start_time_line1;
  P_With_Zero1 = data(first_shift1: last_shift, 1);

  
  data = dlmread(filename3, '\t');
  [last_shift, column_size] = size(data)
  data (1 + start_time_line2, column_size);
  first_shift2 = 1 + start_time_line2;
  P_With_Zero2 = data(first_shift2: last_shift, 1);
 
  j = 1;
  k = 1;

  
  
  for i = 1:last_shift - first_shift1 + 1
    if (P_With_Zero2(i, 1) == 0)
      t1(j, 1) = t(i, 1);
      P1(j, 1) = P_With_Zero1(i, 1);
      j = j + 1;
    endif 
    if (P_With_Zero1(i, 1) == 0)
      t2(k, 1) = t(i, 1);
      P2(k, 1) = P_With_Zero2(i, 1);
      k = k  + 1;
    endif
  endfor

  
  maxP1 = max (P1)
  
  maxP2 = max (P2)   
      
   
  
  P1 = (10 * log10(P1 / 0.000001) - 10 * log10(maxP1 / 0.000001)) * (-1) / fiber_lenght_normalization;
  P2 = (10 * log10(P2 / 0.000001) - 10 * log10(maxP2 / 0.000001)) * (-1) / fiber_lenght_normalization;
  
  t1 = t1 - t1(1);
  t2 = t2 - t2(1);
 
  P1 = P1(1:axisX);
  t1 = t1(1:axisX);
  
  P2 = P2(1:axisX);
  t2 = t2(1:axisX);
  
  [maxRNZ1 maxRNZ_time1] = max (P1)
  [maxRNZ2 maxRNZ_time2] = max (P2)
 
  x1 = [t1(maxRNZ_time1), t1(maxRNZ_time1) ]
  y1 = [0, maxRNZ1]
  
  x2 = [t2(maxRNZ_time2+13), t2(maxRNZ_time2+13)]
  y2 = [0, maxRNZ2]
  
  A10 = P2(150:150:3901)
  A11 = P2(4050:150:6002)
  
  t10 = t2(150:150:3901)
 
  t11 = t2(4050:150:6002)
  
  d10 = t2(150:150:3901)
  d10 = d10 * dose_rate / 1000
  
  Amax = P2(3900)
  tmax = t2(3915)
  dmax = tmax * dose_rate / 1000
 
  #P1 = P1(1:axisX);
  #P2 = P2(1:axisX);
  #t = t(1:axisX);
  
  #fig1 = plot( t1, P1, 'r', "linewidth",  1.4, x1, y1,  '--',"linewidth",  1.4);
  fig2 = plot( t2, P2, 'r', "linewidth",  1.4, x2, y2,  '--',"linewidth",  1.4);
  axis([0, axisX, 0, axisY]);
  
  
  xlabel( 't, c', "fontsize", 16)
  #xlabel( 'Д, {\cdot}10^3 ед.', "fontsize", 16)
  
  ylabel('РНЗ, дБ/км', "fontsize", 16)
  set(gca,"linewidth", 1,  "fontsize", 16)
  grid minor on

  legend ('РНЗ', 'Начало отжига', "location", "southoutside")
  
  
  

endfunction
