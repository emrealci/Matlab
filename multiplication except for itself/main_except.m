a=input('pls enter a matrix')
b=[];

for ii=1:length(a)
     b(ii)=1;
    for jj=1:length(a)
       
        if a(ii)~=a(jj)

             b(ii)=b(ii)*a(jj);
        end
    end
end
disp(b);


