function output=crosspro(v1,v2)  %output yani v3
 
if length(v1)~=3
    error('error')
end

  if length(v2)~=3
    error('error')
  end
  
output(1)=v1(2)*v2(3) -v2(2)*v1(3);
output(2)=v1(3)*-v2(3)*v1(1);
output(3)=v1(1)*v2(2) -v2(1)*v1(2);

end
