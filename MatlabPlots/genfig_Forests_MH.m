function []=genfig_Forests_MH(arg1)

%% plot Forests_MH.pdf
folderName =  '~/Codes/RandomForestExp/';
folderName = strcat(folderName, arg1);

fNameDT = strcat(folderName, '/sumDT.txt');
fNameRF50 = strcat(folderName, '/sumRF50.txt');
fNameRF100 = strcat(folderName, '/sumRF100.txt');
fNameRF200 = strcat(folderName, '/sumRF200.txt');

fDT = fopen(fNameDT,'r');
if fDT == -1
  error('Author:Function:OpenFile', 'Cannot open file: %s', fNameDT);
end
C_titleDT = textscan(fDT, '%s', 3, 'Delimiter',',');
C_dataDT = textscan(fDT,'%d %f %f', 'Delimiter',',');
fclose(fDT);

fRF50 = fopen(fNameRF50,'r');
if fRF50 == -1
  error('Author:Function:OpenFile', 'Cannot open file: %s', fNameRF50);
end
C_titleRF50 = textscan(fRF50, '%s', 4, 'Delimiter',',');
C_dataRF50 = textscan(fRF50,'%d %d %f %f', 'Delimiter',',');
fclose(fRF50);

fRF100 = fopen(fNameRF100,'r');
if fRF100 == -1
  error('Author:Function:OpenFile', 'Cannot open file: %s', fNameRF100);
end
C_titleRF100 = textscan(fRF100, '%s', 4, 'Delimiter',',');
C_dataRF100 = textscan(fRF100,'%d %d %f %f', 'Delimiter',',');
fclose(fRF100);

fRF200 = fopen(fNameRF200,'r');
if fRF200 == -1
  error('Author:Function:OpenFile', 'Cannot open file: %s', fNameRF200);
end
C_titleRF200 = textscan(fRF200, '%s', 4, 'Delimiter',',');
C_dataRF200 = textscan(fRF200,'%d %d %f %f', 'Delimiter',',');
fclose(fRF200);

plot([1 1000],[C_dataDT{3} C_dataDT{3}],  '-b', 'MarkerSize', 6, 'LineWidth', 1.5);
hold on;
plot(C_dataRF50{2}, C_dataRF50{4},  '-r', 'MarkerSize', 6, 'LineWidth', 1.5);
plot(C_dataRF100{2}, C_dataRF100{4},  '-k', 'MarkerSize', 6, 'LineWidth', 1.5);
plot(C_dataRF200{2}, C_dataRF200{4},  '-g', 'MarkerSize', 6, 'LineWidth', 1.5);
hold off;

xlabel('Forest size')
ylabel('Accuracy on Testing%')
xlim([1 1000])
ylim([0.5 1])

hleg1 = legend('Decision Tree', 'Random Forest (50)', 'Random Forest (100)', 'Random Forest (200)');
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
