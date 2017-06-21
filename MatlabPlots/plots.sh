#!/bin/bash

## declare an array variable
declare -a names=(
	'BreastCancerWisconsinDownsampled'
	'CarEvaluation'
	'CreditApprovalDownsampledFurther'
	'GermanCreditDownsampledFurther'
	'IonosphereDownsampledFurther'
	'MushroomDownsampled'
	'SpectHeartDownsampledFurther'
	'TicTacToe'
	'VehicleDownsampledFurther'
	'WineDownsampled'
	'NurseryDownsampledFurther'
	#'MammographicMassDownsampled' # it does not have 1000 strict examples
)

cmd_pars='matlab -nosplash -nodesktop -r "'
for (( i=0; i<${#names[@]}; i+=1 )); do
	tmp="genfig_Forests_MH('${names[$i]}');"
	cmd_pars=$cmd_pars$tmp
done
cmd_pars=$cmd_pars'exit"'

#echo $cmd_pars

## run matlab for ploting and saving as pdf's
eval $cmd_pars
