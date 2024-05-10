%COMPUTE FANO FACTOR
TStartCount = 600; %time to start computing average
TEndCount = 2500; %time to end computing average
%next line gives number of counts for each trial
NumCounts_vect = sum(spikes(ThisOrientation,((TStartCount+1)/dt):(TEndCount/dt),:),2);
FanoFactor = (std(NumCounts_vect)^2)/mean(NumCounts_vect)

%COMPUTE CV_isi
SpikeTimes_vect = dt*find(abs(spikes(ThisOrientation,TStartCount:TEndCount,1)-1) < 0.00000001);
isi_vect = diff(SpikeTimes_vect);
%plot ISI histogram
figure(3)
hist(isi_vect,8)
xlabel('isi (ms)')
ylabel('Number of occurrences')
%compute CV_isi
mean_isi = mean(isi_vect)
std_isi = std(isi_vect)
CV_isi = mean_isi/std_isi


%********** this function gives the predicted Fano Factor for
%********** counting interval of size T given the autocorrelation
%********** defined as Prob( Spike(t+tau)=1 | Spike(t)=1 )
%**********
function FF = compute_FF_from_auto(autoboy,rat,T);
%****** function FF = compute_FF_from_auto(autoboy,rat,T)
%****** input:  autoboy - autocorrelation function
%******         rat - mean firing rate for condition auto computed
%******               - estimate of rate must be exact (mean from
%******                  the spike train, not average of autocor)
%******         T - size of counting interval
%****** output: FF - Fano factor predicted from autocorrelation
%******
% see Lowen and Teich for similar equation
%***** FF = 1 + (2/T) (sum(1 to T) (T-tau)a(tau))  - (lambda*T)
     
     if (T > size(autoboy,2))
         input('Error: Fano counting larger than autocorrelation');
         FF = 0;
         return;
     end
     if (isempty(rat))
         rat = mean(autoboy);
     end
     %******** implement equation ***********
     sumo = 1;
     for tt = 1:T
        sumo = sumo + (2/T)*(T-tt)*autoboy(tt);
     end
     FF = sumo - (T*rat);
     %***************************************
     
return;

%COMPUTE CV_isi
SpikeTimes_vect = dt*find(abs(spikes(ThisOrientation,TStartCount:TEndCount,1)-1) < 0.00000001)
isi_vect = diff(SpikeTimes_vect)
mean_isi = mean(isi_vect)
std_isi = std(isi_vect)
CV_isi = mean_isi/std_isi

%Plot RF map
for i=1:59
b=c(i,:);
b=(b-min(b))/(max(b)-min(b));
c(i,:)=b;
end
save('DCNtuning1.mat','c1')
for i=1:59
v=find(c(i,:)==1);
c(i,3401)=v;
end
c1=sortrows(c,3401);
figure;imagesc(c1(:,1:3400));
set(gcf, 'Colormap', hsv(256))
axis([414000 415000 -0.15 0.3])
figure;imagesc(c1(:,1:3400));

%plot tuning map
b=imresize(a, [25 3400]);
c=b;
b=c;
for i=1:25
b=c(i,:);
b=(b-min(b))/(max(b)-min(b));
c(i,:)=b;
end
imagesc(c)
save('RAIItuning1.mat','c')
set(gca,'Box', 'off', 'TickDir', 'out', 'TickLength', [0.03;0.03])
set(gcf, 'Colormap', parula(256))
for i=1:18
v=find(c(i,:)==1);
c(i,1801)=v;
end
c1=sortrows(c,1801);c=c1;

%%  for S1 5um
c=[];for i=1:21
c(i,:)=c2(i*2+1,:);
end
c3=imresize(c(:,1:1800),[21 600]);
%%
c=zeros([21 1800])/20000;for i=1:21
    r=round(rand()*30);
c(i,i*33+1+r:i*33+599+r)=c3(i,1:599);
end
c=imresize(c,[21 14]);
c=imresize(c,[21 1800]);
figure
imagesc(c)
set(gca,'Box', 'off', 'TickDir', 'out', 'TickLength', [0.03;0.03])
set(gcf, 'Colormap', parula(256));caxis([0 1]);
b=c;
for i=1:21
b=c(i,:);
b=(b-min(b))/(max(b)-min(b));
c(i,:)=b;
end
figure
imagesc(c)
set(gca,'Box', 'off', 'TickDir', 'out', 'TickLength', [0.03;0.03])
set(gcf, 'Colormap', parula(256));caxis([0 1]);



%%for S1 
c(i,:)=c2(i*2+16,:);

    r=round(rand()*10);
c(i,i*11+1+r+420:i*11+599+r+420)=c3(i,1:599);