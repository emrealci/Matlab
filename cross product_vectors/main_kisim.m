arr=input('give the p matrix');

max=arr[1]; % ilk elemanı maxa atadık
count=1; % ilk eleman hep güneş görecek

for ii=1:length(arr)
    if arr[ii]>max
        count=count+1;
        max=arr[ii];
    end
end

fprintf('%d',count);


