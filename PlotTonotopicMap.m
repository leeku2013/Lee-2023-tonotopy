tData = readtable('data.xlsx');
tData.Properties.VariableNames = {'x','y','TEMP'};
% Apply interpolation
%[x1,y1] = meshgrid(-0.045:0.00005:-0.02, 0.01:0.00005:0.035);
%[x1,y1] = meshgrid(1:0.5:5000, 1:0.5:5000);
[x1,y1] = meshgrid(50:10:500, 50:10:500);
  %z1 = griddata(tData(:,1), tData(:,2),tData(:,3), x1, y1);
z1 = griddata(tData.x, tData.y, tData.TEMP, x1, y1);
% Set the TEMPs outside the measured area to NaN
%     k = boundary(tData.x, tData.y, 1);
%     pgon = polyshape(tData.x(k), tData.y(k),'Simplify',false);
%     idx = isinterior(pgon,x1(:),y1(:));
%     idx = reshape(idx,size(x1));
%     z1(~idx) = nan;
% Show the result
figure
contourf(x1,y1,z1); %,'ShowText','on'
%caxis([-50 441]);
axis equal
xlabel('x, (mm)')
ylabel('y, (mm)')
title('contour plot')
colorbar

%% plot scatter tonotopic map%
%figure; scatter(tData(:,1), tData(:,2), [],tData(:,3)); colormap('pink')
figure; scatter(tData.x, tData.y, [],tData.TEMP);
i1 = imgaussfilt(z1,4, 'Padding' ,'circular');
contourf(x1,y1,i1);

figure; scatter(tData.x, tData.y, 20,tData.TEMP, 'filled', 'MarkerEdgeColor',[0.2 0.2 0.2],...
'LineWidth',0.25); colormap('jet');axis equal;axis off
axis([50 500 50 500])
%% plot density heatmap
% Normally distributed sample points:
x = randn(1, 10000);
y = randn(1, 10000);

% Bin the data:
pts = linspace(-4, 4, 101);
N = histcounts2(y(:), x(:), pts, pts);

% Plot scattered data (for comparison):
subplot(1, 2, 1);
scatter(x, y, 'r.');
axis equal;
set(gca, 'XLim', pts([1 end]), 'YLim', pts([1 end]));

% Plot heatmap:
subplot(1, 2, 2);
imagesc(pts, pts, N);
axis equal;
set(gca, 'XLim', pts([1 end]), 'YLim', pts([1 end]), 'YDir', 'normal');

% Plot error in the background:
y = []; 
x = [];
std_dev = [];
y=y'; x=x'; std_dev=std_dev'; figure;
curve1 = y + std_dev;
curve2 = y - std_dev;
loglog(x, y, 'k', 'LineWidth', 2);hold on;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];
fill(x2, inBetween, 'r');
loglog(x, y, 'k', 'LineWidth', 2)
