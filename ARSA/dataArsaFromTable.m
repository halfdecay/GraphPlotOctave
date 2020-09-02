function dataArsaFromTable()
  f = "Arsa_data.txt";
[a,b,c]= importdata (f);
  [z,k]=size(a.data);
  Z=a.data(1:z,2);
  T=a.data(1:z,3);
  Umon=a.data(1:z,4);
  wave=a.data(1:z,5);
  oscnum=a.data(1:z,6);
  for(i=1:1:z)
    Dose(i)=Umon(i)*39769/(Z(i)+5.2).^2.086*2*10^8;
  endfor

##Dose=Umon*39769/(Z+5.2).^2.086

endfunction
