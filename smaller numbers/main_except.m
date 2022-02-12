a =input('Pls enter a matrices');
b=[];
for ii=1:length(a)
    count=0;
    for jj=(ii+1):length(a)

        if a(ii)>a(jj)
            count=count+1;
        end
    end
    b(ii)=count;
end
disp(b);