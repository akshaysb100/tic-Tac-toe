#!/bin/bash -x

echo "Welcome Tic-Tac-Toe Program"

#CONSTANTS
MAX_BOARD_POSITION=9

#VARIABLE
player=""
computer=""
whoPlay=""
winner=false

#ARRAYS
declare -a playerBoardPosition

function initialisingBoard()
{
	for (( i=1; i<=$MAX_BOARD_POSITION; i++ ))
	do
		playerBoardPosition[$i]=$i
	done
}

function playerSymbol() {
	
	local chooseSymbol=$(( RANDOM % 2 ))
	if [ $chooseSymbol -eq 0 ]
	then
		player="X"
	else
		player="O"	
	fi
        
}

function computerSymbol() {
  	playerSymbol
	if [ "$player" = "X" ]
	then
		computer="O"
	else
		computer="X"
	fi
}

function toss() {
	
        local checkPlayFirst=$(( RANDOM % 2 ))
	if [ $checkPlayFirst -eq 0 ]
	then
		whoPlay=$player
        else
		whoPlay=$computer
	fi
	echo $whoPlay
}

function playerPlay() {       
	
	if [ ${playerBoardPosition[1]} != $computer ]
	then 
		read -p "Enter the player position to insert the $player :" position 
	        playerBoardPosition[$position]=$player
        fi
}

function ComputerPlay() {
	
	if [ ${playerBoardPosition[1]} != $player ]
	then
		read -p "Enter the player position to insert the $computer :" position 
	        playerBoardPosition[$position]=$computer
        fi
	
}
function displayBoard() {
      
	echo "     ___ ___ ___ "
        echo "    | ${playerBoardPosition[1]} | ${playerBoardPosition[2]} | ${playerBoardPosition[3]} |"
        echo "    |___|___|___|"
        echo "    | ${playerBoardPosition[4]} | ${playerBoardPosition[5]} | ${playerBoardPosition[6]} |"
        echo "    |___|___|___|"
        echo "    | ${playerBoardPosition[7]} | ${playerBoardPosition[8]} | ${playerBoardPosition[9]} |"
        echo "    |___|___|___|"

}

function checkWinnerRowColumn() {

	local loopCounter=0
        local rowPosi=1
        local columPosi=1
	while [ $loopCounter != 3 ]
	do
                 checkWinner ${playerBoardPosition[$rowPosi]} ${playerBoardPosition[$rowPosi+1]} ${playerBoardPosition[$rowPosi+2]}  
                 checkWinner ${playerBoardPosition[$columPosi]} ${playerBoardPosition[$columPosi+3]} ${playerBoardPosition[$columPosi+6]}  
		 columPosi=$(($columPosi+1))		 
		 rowPosi=$(($rowPosi+3))
		 loopCounter=$(($loopCounter+1))
	done        
	
}

function checkWinner() {
                
	if [[ $1 == $2  ]] && [[ $1 == $3 ]] && [[ $2 == $3 ]]  
	then
		echo " $player wins "
		exit
		
	fi      
}

function checkWinnerDiagonal() {

	local loopCounter=0
        local positions=1
        
        checkWinner ${playerBoardPosition[$positions]} ${playerBoardPosition[$positions+4]} ${playerBoardPosition[$positions+8]}  
	checkWinner ${playerBoardPosition[$positions+2]} ${playerBoardPosition[$positions+4]} ${playerBoardPosition[$positions+6]}  
		
}

initialisingBoard
playerSymbol
computerSymbol
swithPlayerCount=0
while [ $swithPlayerCount -le $MAX_BOARD_POSITION ]
do
	
	echo "play"
	playerPlay
	displayBoard
	checkWinnerRowColumn
	#checkWinnerColumn
	checkWinnerDiagonal
        ((swithPlayerCount++))
done


