#!/bin/bash -x

echo "Welcome Tic-Tac-Toe Program"

#CONSTANTS
MAX_BOARD_POSITION=9

#VARIABLE
player=""
computer=""
whoPlay=""
movePosition=true
swithPlayerCount=1

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

function computerPlayToWin() {       
	
        if [[ $1 == $computer ]] || [[ $2 == $computer ]] && [[ $1 == $2 ]] && [[ $3 == $4 ]] 
 	then
                echo "insert computer winning position"
	        playerBoardPosition[$4]=$computer
                movePosition=false
                
	fi	
}
function checkWinningPosition() {
	
        local loopCounter=0
	local position=0
        local rowPosi=1	
        while [[ $loopCounter != 3 ]] && [[ $movePosition == true ]]
	do
	position=$rowPosi
        computerPlayToWin ${playerBoardPosition[$rowPosi+$1]} ${playerBoardPosition[$rowPosi+$2]} ${playerBoardPosition[$rowPosi]} $position
        position=$(( $rowPosi + $1 ))
        computerPlayToWin ${playerBoardPosition[$rowPosi]} ${playerBoardPosition[$rowPosi+$2]} ${playerBoardPosition[$rowPosi+$1]} $position
        position=$(( $rowPosi + $2 ))
        computerPlayToWin ${playerBoardPosition[$rowPosi]} ${playerBoardPosition[$rowPosi+$1]} ${playerBoardPosition[$rowPosi+$2]} $position
	rowPosi=$(($rowPosi+$3))
	loopCounter=$(($loopCounter+1))
	done
        
}

function checkWinRow() {
        local rowFirst=1
        local rowSecond=2
        local loopcount=3
        checkWinningPosition $rowFirst $rowSecond $loopcount
        checkWinColumn
        checkWinningPositionDiagonal
        if [ $movePosition == true ]
        then
                ComputerPlay     
        fi
	movePosition=true
        
}

function checkWinColumn() {
        local rowFirst=3
        local rowSecond=6
        local loopcount=1
        checkWinningPosition $rowFirst $rowSecond $loopcount
}

function checkWinningPositionDiagonal() {
     
        daiPosi=1
        position=daiPosi
        computerPlayToWin ${playerBoardPosition[$daiPosi+4]} ${playerBoardPosition[$daiPosi+8]} ${playerBoardPosition[$daiPosi]} $position
        position=$(($daiPosi+4))
        computerPlayToWin ${playerBoardPosition[$daiPosi]} ${playerBoardPosition[$daiPosi+8]} ${playerBoardPosition[$daiPosi+4]} $position
        position=$(($daiPosi+8))
        computerPlayToWin ${playerBoardPosition[$daiPosi]} ${playerBoardPosition[$daiPosi+4]} ${playerBoardPosition[$daiPosi+8]} $position
        position=$(($daiPosi+2))
        computerPlayToWin ${playerBoardPosition[$daiPosi+4]} ${playerBoardPosition[$daiPosi+6]} ${playerBoardPosition[$daiPosi+2]} $position
        position=$(($daiPosi+4))
        computerPlayToWin ${playerBoardPosition[$daiPosi+2]} ${playerBoardPosition[$daiPosi+6]} ${playerBoardPosition[$daiPosi+4]} $position
        position=$(($daiPosi+6))
        computerPlayToWin ${playerBoardPosition[$daiPosi+2]} ${playerBoardPosition[$daiPosi+4]} ${playerBoardPosition[$daiPosi+6]} $position
	
	
}
function ComputerPlay() {

        local computerPosition=$((RANDOM%9+1))       
        if [[ ${playerBoardPosition[$computerPosition]} != $player ]] && [[ ${playerBoardPosition[$computerPosition]} != $computer ]]
	then 
                echo "insert computer position random"
	        playerBoardPosition[$computerPosition]=$computer
                
        else
		echo "coputer wrong move"
                ComputerPlay
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
while [ $swithPlayerCount -le $MAX_BOARD_POSITION ]
do
       
        if [ $whoPlay == $player ]
	then    
		playerPlay
		checkWinnerRowColumn
                checkWinnerDiagonal 
                whoPlay=$computer
	else
		checkWinRow
	        checkWinnerRowColumn
                checkWinnerDiagonal 
		whoPlay=$player
	fi

	displayBoard
        ((swithPlayerCount++))
done

echo "tie"


