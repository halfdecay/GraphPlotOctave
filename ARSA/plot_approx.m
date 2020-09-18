function plot_approx()

  f = "output.txt";
  [a,b,c]= importdata (f)
  [s1,s2]=size(a)
  iter =0
  for(i=1:1:s1)
    if(a(i,2)==1310 && a(i,1)==-60)
    iter=iter+1;
      l(iter)= log(a(i,6))
  Dose(iter)=a(i,3)/10^8
  
##  T(iter)=a(i,1)
##  a(i,2)

    endif
    
  endfor
  
  l
  Dose
  
  

Dose1 = linspace(Dose(1)*1.3,Dose(iter)*0.6,50)

g =1./Dose1.^0.65*10^3
ltr=10.^g

##y= zeros(size(Dose1))
##  y=  -Dose1./L


plot(Dose,l,"b",Dose1,g,"r")
##plot(Dose1,g,"r")
##plot(Dose1,l)
##hold on

 

  
endfunction

function  y = f (x)
  y = zeros (2, 1);
  persistent l1= x(3);
  persistent D1= x(5);
  persistent l2= x(5);
  persistent D2= x(4);
 y(1) = x(1)/x(2)*(D1/x(2))^(x(1)-1)*exp(-(D1/x(2))^x(1))*125000-l1;
   y(2) = x(1)/x(2)*(D2/x(2))^(x(1)-1)*exp(-(D2/x(2))^x(1))*125000-l2;
endfunction
