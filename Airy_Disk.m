function readFileForPlot()
  
  wavelength = 0.000001064 # ����� �����, �
  r = 0.03  # ������ �����, �
  z = 0.100 # ���������� �� ��������� �� ��������� �����������, �
  
  #-----------------------------------------------
  format long
  norm_10plus6 = 10^6;
  norm_10minus6 = 10^-6;
  
  x = linspace(0, 5, 100000);
  x = x * norm_10minus6;
  a = 2 * pi * r * x / (wavelength * z );
  
  J2 = besselj (0, a).* besselj (0, a);
  J2 = J2 / J2(1,1);
  I = 4 * besselj (1, a).* besselj (1, a)./a.^2;
  x = x * 10^6;

  plot(x, I, 'r', "linewidth",  2);
  ylabel('������������� ���������, ���.��', "fontsize", 16)
  xlabel('���������� �� ��� � ��������� �����������, ���', "fontsize", 16)
  axis([0, 5, 0, 1]);
  set(gca,"linewidth", 1,  "fontsize", 16)
  grid minor on
  
endfunction
