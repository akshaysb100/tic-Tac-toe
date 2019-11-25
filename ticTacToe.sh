#!/bin/bash -x

echo "Welcome Tic-Tac-Toe Program"

#CONSTANTS
MAX_BOARD_POSITION=9

#VARIABLE
playerSymbol=""
computerSymbol=""
whoPlay=""
movePosition=true
switchPlayerCount=1

#ARRAYS
declare -a playerBoardPosition

function initialisingBoard()
{
	for (( i=1; i<=$MAX_BOARD_POSITION; i++ ))
	do
		playerBoardPosition[$i]=$i
	done
}

function SymbolAssignment() {
	
	local chooseSymbol=$(( RANDOM % 2 ))
	if [ $chooseSymbol -eq 0 ]
	then
		playerSymbol="X"
                computerSymbol="O"
	else
		playerSymbol="O"
                computerSymbol="X"	
	fi
        
}

function toss() {
	
        local checkPlayFirst=$(( RANDOM % 2 ))
	if [ $checkPlayFirst -eq 0 ]
	then
		whoPlay=$playerSymbol
        else
		whoPlay=$computerSymbol
	fi	
}

function playerPlay() {       
	
        read -p "Enter the player position to insert the $playerSymbol :" position 
	if [[ ${playerBoardPosition[$position]} != $playerSymbol ]] && [[ ${playerBoardPosition[$position]} != $computerSymbol ]]
	then 
	        playerBoardPosition[$position]=$playerSymbol
        else
		echo "the position is already filled retry"
                playerPlay
	fi
}

function checkCorners() {

        if [ $movePosition == true ]
        then
        for (( i=1; i<=$MAX_BOARD_POSITION; i=$(($i+2)) ))
        do
          
                if [ ${playerBoardPosition[$i]} == $i ]
                then             
                        playerBoardPosition[$i]=$1
                        movePosition=false
                        break
                fi
                if [ $i -eq 3 ]
                then
                        i=$(( $i + 2 ))
                fi
        done 
        fi
}

function checkCentre() {

        if [ $movePosition == true ]
        then
        if [ ${playerBoardPosition[5]} == 5 ]
        then
                        
                 playerBoardPosition[5]=$1
                 movePosition=false
        fi
        fi
}

function checkSide() {
        
        if [ $movePosition == true ]
        then
        for (( i=2; i<=$MAX_BOARD_POSITION; i=$(($i+2)) ))
        do
          
                if [ ${playerBoardPosition[$i]} == $i ]
                then            
                        playerBoardPosition[$i]=$1
                        movePosition=false
                        break
                fi
        done 
        fi


}
function computerPlayToWin() {       
	
        if [[ ${playerBoardPosition[$1]} == $5 ]] || [[ ${playerBoardPosition[$2]} == $5 ]] && [[ ${playerBoardPosition[$1]} == ${playerBoardPosition[$2]} ]] && [[ ${playerBoardPosition[$3]} == $4 ]] && [[ $movePosition == true ]]
 	then
                echo "insert computer winning position or bolcking position"
	        playerBoardPosition[$4]=$computerSymbol
                movePosition=false
                
	fi	
}


function checkWinningPosition() {
	
        local loopCounter=0
	local position=0
        local rowPosition=1	
        while [[ $loopCounter != 3 ]] && [[ $movePosition == true ]]
	do
	position=$rowPosition
        computerPlayToWin $(($rowPosition+$1)) $(($rowPosition+$2)) $(($rowPosition)) $position $4
        position=$(( $rowPosition + $1 ))
        computerPlayToWin $(($rowPosition)) $(($rowPosition+$2)) $(($rowPosition+$1)) $position $4
        position=$(( $rowPosition + $2 ))
        computerPlayToWin $(($rowPosition)) $(($rowPosition+$1)) $(($rowPosition+$2)) $position $4
	rowPosition=$(($rowPosition+$3))
	loopCounter=$(($loopCounter+1))
	done
        
}

function checkWinBlock() {
        local rowFirst=1
        local rowSecond=2
        local loopcount=3        
        checkWinningPosition $rowFirst $rowSecond $loopcount $1        
        checkWinningPositionDiagonal $1 
        checkWinColumn      
}

function checkWinColumn() {
        local columnFirst=3
        local columnSecond=6
        local loopcount=1
        checkWinningPosition $columnFirst $columnSecond $loopcount $computerSymbol
        checkWinningPosition $columnFirst $columnSecond $loopcount $playerSymbol
}

function checkWinningPositionDiagonal() {
     
        daigonalPosition=1
        position=$daigonalPosition
        local symbol=""
        if [ $1 == $playerSymbol ]
        then
                symbol=$playerSymbol
        else
                symbol=$computerSymbol
        fi
        computerPlayToWin $(($daigonalPosition+4)) $(($daigonalPosition+8)) $(($daigonalPosition)) $position $symbol
        position=$(($daigonalPosition+4))
        computerPlayToWin $(($daigonalPosition)) $(($daigonalPosition+8)) $(($daigonalPosition+4)) $position $symbol
        position=$(($daigonalPosition+8))
        computerPlayToWin $(($daigonalPosition)) $(($daigonalPosition+4)) $(($daigonalPosition+8)) $position $symbol
        position=$(($daigonalPosition+2))
        computerPlayToWin $(($daigonalPosition+4)) $(($daigonalPosition+6)) $(($daigonalPosition+2)) $position $symbol
        position=$(($daigonalPosition+4))
        computerPlayToWin $(($daigonalPosition+2)) $(($daigonalPosition+6)) $(($daigonalPosition+4)) $position $symbol
        position=$(($daigonalPosition+6))
        computerPlayToWin $(($daigonalPosition+2)) $(($daigonalPosition+4)) $(($daigonalPosition+6)) $position $symbol
	
	
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
        local rowPosition=1
        local columPosition=1
	while [ $loopCounter != 3 ]
	do
        checkWinner ${playerBoardPosition[$rowPosition]} ${playerBoardPosition[$rowPosition+1]} ${playerBoardPosition[$rowPosition+2]}  
        checkWinner ${playerBoardPosition[$columPosition]} ${playerBoardPosition[$columPosition+3]} ${playerBoardPosition[$columPosition+6]}  
        columPosi=$(($columPosition+1))		 
        rowPosi=$(($rowPosition+3))
	loopCounter=$(($loopCounter+1))
	done        
	
}


function checkWinner() {
                
	if [[ $1 == $2  ]] && [[ $1 == $3 ]] && [[ $2 == $3 ]]  
	then
 		displayBoard
		if [ $whoPlay == $playerSymbol ]
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
SymbolAssignment
toss
echo "computer symbol" $computerSymbol
echo "player symbol" $playerSymbol
echo "play first " $whoPlay
while [ $switchPlayerCount -le $MAX_BOARD_POSITION ]
do

        if [ $whoPlay == $playerSymbol ]
	then    
		playerPlay
		checkWinnerRowColumn
                checkWinnerDiagonal 
                whoPlay=$computerSymbol
	else
		checkWinBlock $computerSymbol
                checkWinBlock $playerSymbol
                checkCorners $computerSymbol
                checkCentre $computerSymbol
                checkSide $computerSymbol
	        checkWinnerRowColumn
                checkWinnerDiagonal 
		whoPlay=$playerSymbol
                movePosition=true
	fi

	displayBoard
        ((switchPlayerCount++))
done

echo "tie"


