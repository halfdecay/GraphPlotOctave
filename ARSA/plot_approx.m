function plot_approx()

  f = "output.txt";
  [a,b,c]= importdata (f)
  [s1,s2]=size(a)
  iter =0
  for(i=1:1:s1)
    if(a(i,2)==1310)
    iter=iter+1
      l(iter)= a(i,6)
  Dose(iter)=a(i,3)
  T(iter)=a(i,1)
  a(i,2)

    endif
    
  endfor
  xi=2.5e+11
  yi=-60
  zi  = interp2 (Dose, T, l, xi, yi,"linear" )
##  zi=interp
  plot3(T,Dose,l,"*r")
  grid on
  
 

  
endfunction

