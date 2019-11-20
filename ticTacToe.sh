#!/bin/bash -x

echo "Welcome Tic-Tac-Toe Program"

#CONSTANTS
MAX_BOARD_POSITION=9

#VARIABLE
playerSymbol=""
computerSymbol=""
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
        local rowPosi=1	
        while [[ $loopCounter != 3 ]] && [[ $movePosition == true ]]
	do
	position=$rowPosi
        computerPlayToWin $(($rowPosi+$1)) $(($rowPosi+$2)) $(($rowPosi)) $position $4
        position=$(( $rowPosi + $1 ))
        computerPlayToWin $(($rowPosi)) $(($rowPosi+$2)) $(($rowPosi+$1)) $position $4
        position=$(( $rowPosi + $2 ))
        computerPlayToWin $(($rowPosi)) $(($rowPosi+$1)) $(($rowPosi+$2)) $position $4
	rowPosi=$(($rowPosi+$3))
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
        local colFirst=3
        local colSecond=6
        local loopcount=1
        checkWinningPosition $colFirst $colSecond $loopcount $computerSymbol
        checkWinningPosition $colFirst $colSecond $loopcount $playerSymbol
}

function checkWinningPositionDiagonal() {
     
        daiPosi=1
        position=$daiPosi
        local symbol=""
        if [ $1 == $playerSymbol ]
        then
                symbol=$playerSymbol
        else
                symbol=$computerSymbol
        fi
        computerPlayToWin $(($daiPosi+4)) $(($daiPosi+8)) $(($daiPosi)) $position $symbol
        position=$(($daiPosi+4))
        computerPlayToWin $(($daiPosi)) $(($daiPosi+8)) $(($daiPosi+4)) $position $symbol
        position=$(($daiPosi+8))
        computerPlayToWin $(($daiPosi)) $(($daiPosi+4)) $(($daiPosi+8)) $position $symbol
        position=$(($daiPosi+2))
        computerPlayToWin $((daiPosi+4)) $(($daiPosi+6)) $(($daiPosi+2)) $position $symbol
        position=$(($daiPosi+4))
        computerPlayToWin $(($daiPosi+2)) $(($daiPosi+6)) $(($daiPosi+4)) $position $symbol
        position=$(($daiPosi+6))
        computerPlayToWin $(($daiPosi+2)) $(($daiPosi+4)) $(($daiPosi+6)) $position $symbol
	
	
}
function ComputerPlay() {

        local computerPosition=$((RANDOM%9+1))       
        if [[ ${playerBoardPosition[$computerPosition]} != $playerSymbol ]] && [[ ${playerBoardPosition[$computerPosition]} != $computerSymbol ]]
	then 
                echo "insert computer position random"
	        playerBoardPosition[$computerPosition]=$computerSymbol
                
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
while [ $swithPlayerCount -le $MAX_BOARD_POSITION ]
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
        ((swithPlayerCount++))
done

echo "tie"


