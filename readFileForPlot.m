function readFileForPlot()

  fiber_lenght= 0.12
  dose_rate= 88.375

  filename = "МОВ 1300 Минус.txt";
  data= dlmread(filename,'\t');
  [last_shist,b]= size(data);
  data(36,2);
  first_shift =34 ;
  x=data(first_shift:last_shist,1);
  y=data(first_shift:last_shist,2);
  x=x/1000*dose_rate-3.09;
  [c h]= min(y)
  maxY= max(y)
  y=(-10*log10(y*1000)+10*log10(maxY*1000))/fiber_lenght;

  x1= [x(h),x(h)]
  y1=[0,y(h-1)]
  xh=x1(2)
  xl=0
  yl=0
  yh=y(h+1)
  xh
  
 fig= plot( x, y, 'r',"linewidth", 1.4,x1,y1,'b',"linewidth", 1.4)
##  fig= plot( x, y, 'r',"linewidth", 2.4)

  axis([xl*1.1 ,xh*1.1, yl*1.1, yh*1.1]);

  xlabel( 'Д, {\cdot}10^3 ед', "fontsize", 16)
  ylabel('РНЗ, дБ/км', "fontsize", 16)
  set(gca,"linewidth", 1,  "fontsize", 16)
  grid minor on

  saveas(fig,"fg31.bmp")
  
  

endfunction
