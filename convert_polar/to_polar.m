function [mag,theta]=to_polar(x)

mag=abs(x);

theta= angle(x)*180/pi; 