function readFileNplotRNZ_ARSA()
   filename = "C1yauza_elcetron_osc00003.txt";
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
  plot(time,sgf1,'b')
  grid minor on
  set(gca,"linewidth", 1,  "fontsize", 16)
  axis([-0.0004, 0.001]);
endfunction
