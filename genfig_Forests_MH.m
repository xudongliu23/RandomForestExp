datasets_names = {                                                              
    'BreastCancerWisconsinDownsampled'                                          
    'CarEvaluation'                                                             
    'CreditApprovalDownsampledFurther'                                          
    'GermanCreditDownsampledFurther'                                            
    'IonosphereDownsampledFurther'                                              
    'MammographicMassDownsampled'                                              
    'MushroomDownsampled'                                                       
    'SpectHeartDownsampledFurther'                                              
    'TicTacToe'                                                                 
    'VehicleDownsampledFurther'                                                 
    'WineDownsampled'                                                           
    'NurseryDownsampledFurther'                                                 
};

E = zeros(28,4);
F = zeros(28,4);
G = zeros(28,4);
T = zeros(1,3);

for i = [50 100 200]
	for j = 1:numel(datasets_names)
        folderNameTree=  '~/Codes/RandomForestExp/';
        folderNameTree= strcat(folderNameTree, datasets_names(j));
        fNameTree = strcat(folderNameTree, '/sumDT.txt');
        fTree = fopen(char(fNameTree),'r');
        if fTree == -1
            error('Author:Function:OpenFile', 'Cannot open file: %s', fNameTree);
        end
        C_titleTree = textscan(fTree, '%s', 3, 'Delimiter',',');
        C_dataTree = textscan(fTree,'%f %f %f', 'Delimiter',',');
        fclose(fTree);
        
        if i == 50
			T = T + cell2mat(C_dataTree);
        end
        
		folderNameForest=  '~/Codes/RandomForestExp/';
		folderNameForest= strcat(folderNameForest, datasets_names(j));
		fNameForest = strcat(folderNameForest, '/sumRF');
		fNameForest = strcat(fNameForest, num2str(i));
		fNameForest = strcat(fNameForest, '.txt');
		fForest = fopen(char(fNameForest),'r');
		if fForest == -1
		  error('Author:Function:OpenFile', 'Cannot open file: %s', fNameForest);
		end
		C_titleForest = textscan(fForest, '%s', 4, 'Delimiter',',');
		C_dataForest = textscan(fForest,'%f %f %f %f', 'Delimiter',',');
		fclose(fForest);

		if i == 50
			E = E + cell2mat(C_dataForest);
		elseif i == 100
			F = F + cell2mat(C_dataForest);
		else
			G = G + cell2mat(C_dataForest);
		end
	end
end

T = T./numel(datasets_names);
E = E./numel(datasets_names);
F = F./numel(datasets_names);
G = G./numel(datasets_names);

plot([1 1000],[T(1,3) T(1,3)],  '-b', 'MarkerSize', 6, 'LineWidth', 1.5);
hold on;
plot(E(:,2), E(:,4),  '-r', 'MarkerSize', 6, 'LineWidth', 1.5);
plot(F(:,2), F(:,4),  '-k', 'MarkerSize', 6, 'LineWidth', 1.5);
plot(G(:,2), G(:,4),  '-g', 'MarkerSize', 6, 'LineWidth', 1.5);
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
plotPath = './RF.pdf';
export_fig (plotPath, '-transparent')

