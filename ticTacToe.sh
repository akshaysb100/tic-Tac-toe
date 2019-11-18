#!/bin/bash -x

echo "Welcome Tic-Tac-Toe Program"

#CONSTANTS
MAX_BOARD_POSITION=9

#VARIABLE
player=""
computer=""
whoPlay=""

#ARRAYS
declare -a playerBoardPosition

function initialisingBoard()
{
	for (( i=1; i<=$MAX_BOARD_POSITION; i++ ))
	do
		playerBoardPosition[$i]=0
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
        echo $player
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

function play()
{       
 
        local syambol=$( playerSymbol )
	read -p "Enter the player position to insert the $syambol :" position 
        playerBoardPosition[$position]=$syambol
}

function displayBoard() {
   initialisingBoard
   play
   echo "     ___ ___ ___ "
   echo "    | ${playerBoardPosition[1]} | ${playerBoardPosition[2]} | ${playerBoardPosition[3]} |"
   echo "    |___|___|___|"
   echo "    | ${playerBoardPosition[4]} | ${playerBoardPosition[5]} | ${playerBoardPosition[6]} |"
   echo "    |___|___|___|"
   echo "    | ${playerBoardPosition[7]} | ${playerBoardPosition[8]} | ${playerBoardPosition[9]} |"
   echo "    |___|___|___|"

}
displayBoard

