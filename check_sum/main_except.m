a =input('Pls enter a matrices');

flag=0;
k=input('number');

for ii=1:length(a)
    for jj=(ii+1):length(a)

        if a(ii)+a(jj)==k
            flag=1;
            
        end
    end
end
 if flag==1
     fprintf('True');
 else
     fprintf('False');
 end




