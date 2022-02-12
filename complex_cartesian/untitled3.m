function output=caps(mystring)

remainder=mystring;

[first,remainder]=strtok(remainder);

y=[upper(first(1)) lower(first(end:))]