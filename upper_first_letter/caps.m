function output=caps(mystring)

remainder=mystring;
y=[];
while(remainder>0)
[first,remainder]=strtok(remainder);

y=[y upper(first(1)) lower(first(2:end)) ' '];
end
output=y;

end
