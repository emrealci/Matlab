a =input('Pls enter a matrices');
b=[];
count=0;
for ii=1:length(a)
    if a(ii)==ii
        count=1;
        break
    end
end
if count==1
    fprintf('%d',a(ii));
else
    fprintf('No fixed point exists');
end
