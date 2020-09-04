function plot_approx()

  f = "output.txt";
  [a,b,c]= importdata (f)
  [s1,s2]=size(a)
  iter =0
  for(i=1:1:s1)
    if(a(i,2)==1310 && a(i,1)==-60 )
    iter=iter+1
      l(iter)= a(i,6)
  Dose(iter)=a(i,3)
  T(iter)=a(i,1)
  a(i,2)

    end
    
  end
  
  x=linspace(10e+8, Dose(iter),200)
   a =  9.436e+108  
       b =      -9.272 
  
%   f = a.*b.*x.^(b-1).*exp(-a.*x.^b)
  f = a*x.^b

  
    
  plot(Dose,l,"r",x,f,"b")
  grid on
  
 save l
 save Dose

  
    end

