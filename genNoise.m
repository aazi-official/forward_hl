% Generate noise for measurements.
for i=1:72
if mod(i,2)==1
sigma=0.75;
else
sigma=0.125;
end
data_noised(:,i)=normrnd(data_clean(:,i),sigma);
end