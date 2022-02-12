arr1=input('give an array');
 
max_element=arr1(1); 
count=1;

for ii=1:length(arr1)
    if arr1(ii)>max_element
        count=count+1;
        max_element=arr1(ii);
    end
end

fprintf('%d',count);

