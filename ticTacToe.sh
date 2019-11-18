#!/bin/bash -x

echo "Welcome Tic-Tac-Toe Program"

#CONSTANTS
MAX_BOARD_POSITION=9

#VARIABLE
player=""
computer=""
whoPlay=""
winner=false
swithPlayerCount=0
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
	
}

function playerPlay() {       
	
        read -p "Enter the player position to insert the $player :" position 
	if [[ ${playerBoardPosition[$position]} != $player ]] && [[ ${playerBoardPosition[$position]} != $computer ]]
	then 
	        playerBoardPosition[$position]=$player
        else
		echo "the position is already filled retry"
                playerPlay
	fi
}

function computerPlay() {       
	
        local computerPosition=$((RANDOM%9+1))
	if [[ ${playerBoardPosition[$computerPosition]} != $player ]] && [[ ${playerBoardPosition[$computerPosition]} != $computer ]]
	then 
                echo "insert computer position"
	        playerBoardPosition[$computerPosition]=$computer
        else
		echo "coputer weong move"
                computerPlay
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
 		displayBoard
		if [ $whoPlay == $player ]
		then			
			echo "player win"
                else
			echo "computer win"
		fi
		
		exit
		
	fi      
}

function checkWinnerDiagonal() {

	local loopCounter=0
        local positions=1
        
        checkWinner ${playerBoardPosition[$positions]} ${playerBoardPosition[$positions+4]} ${playerBoardPosition[$positions+8]}  
	checkWinner ${playerBoardPosition[$positions+2]} ${playerBoardPosition[$positions+4]} ${playerBoardPosition[$positions+6]}  
		
}


echo  "--------------------------- main function --------------------------------"

initialisingBoard
playerSymbol
computerSymbol
toss
echo "computer symbole" $computer
echo "player symbole" $player
echo "play first " $whoPlay
while [ $swithPlayerCount -le $(($MAX_BOARD_POSITION-1)) ]
do
       
       if [ $whoPlay == $player ]
	then    
		playerPlay
		checkWinnerRowColumn
                checkWinnerDiagonal 
                whoPlay=$computer
	else
		computerPlay
	        checkWinnerRowColumn
                checkWinnerDiagonal 
		whoPlay=$player
	fi

	displayBoard
        ((swithPlayerCount++))
done

echo "tie"


