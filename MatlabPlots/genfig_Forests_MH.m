function []=genfig_Forests_MH(arg1)

%% plot Forests_MH.pdf
folderName =  '~/Codes/RandomForestExp/';
folderName = strcat(folderName, arg1);

fNameDT = strcat(folderName, '/sumDT.txt');
fNameRF = strcat(folderName, '/sumRF.txt');

fDT = fopen(fNameDT,'r');
if fDT == -1
  error('Author:Function:OpenFile', 'Cannot open file: %s', fNameDT);
end
C_titleDT = textscan(fDT, '%s', 3, 'Delimiter',',');
C_dataDT = textscan(fDT,'%d %f %f', 'Delimiter',',');
fclose(fDT);

fRF = fopen(fNameRF,'r');
if fRF == -1
  error('Author:Function:OpenFile', 'Cannot open file: %s', fNameRF);
end
C_titleRF = textscan(fRF, '%s', 4, 'Delimiter',',');
C_dataRF = textscan(fRF,'%d %d %f %f', 'Delimiter',',');
fclose(fRF);

plot(C_dataRF{2}, C_dataRF{4},  '-r', 'MarkerSize', 6, 'LineWidth', 1.5);
hold on;
plot([1 1000],[C_dataDT{3} C_dataDT{3}],  '-b', 'MarkerSize', 6, 'LineWidth', 1.5);
hold off;

xlabel('Forest size')
ylabel('Accuracy on Testing%')
xlim([1 1000])
ylim([0.5 1])

hleg1 = legend('Random Forest', 'Decision Tree');
set(hleg1, 'Location','SouthEast')

% Set figure background color to white
set(gcf,'color','w');

%% export the figure to pdf
addpath ~/.matlab/export_fig/
% exportfigure(gcf, '~/test.pdf', [4 3], 300)
plotPath = './';
plotPath = strcat(plotPath, arg1);
plotPath = strcat(plotPath, '.pdf');
export_fig (plotPath, '-transparent')

end
