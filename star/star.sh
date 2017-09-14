#!/bin/bash

rows=`tput lines`;
cols=`tput cols`;

# centre of screen
cen_y=$((rows/2)); 
cen_x=$((cols/2));

STAR="*";

# clear screen before printing star
clear;
tput civis;

# DEBUG
DEBUG(){
  tput cup $rows 0;
  echo $pos_y $pos_x;
}


# function to print star at pos_x and pos_y
printStar () {
  tput cup $pos_y $pos_x;
  printf "$1";
  # DEBUG;
  sleep 0.005;
}

while (( 1 == 1 ));
do
  # current position
  pos_y=$((rows/2)); 
  pos_x=$((cols/2));

  # print limits
  ml=1;
  mt=1;
  mr=2;
  mb=2;
 
  printStar "$STAR";

  while (($ml < $cols && $mr < $cols && $mt < $rows && $mb < $rows));
  do
    # Left spiral move
    for i in $(seq 1 $ml);
    do
      # echo $i;
      pos_x=$((pos_x-2));
      if [ $i -eq $ml ]
      then
        printStar "$STAR";
      else
        printStar "$STAR$STAR";
      fi
    done
    ml=$((ml+2));

    # Top spiral move
    for i in $(seq 1 $mt);
    do
      pos_y=$((pos_y-1));
      printStar "$STAR";
    done
    mt=$((mt+2));
    
    # Right spiral move
    for i in $(seq 1 $mr);
    do
      pos_x=$((pos_x+2));
      if [ $i -eq $mr ]
      then
        printStar "$STAR";
      else
        printStar "$STAR$STAR";
      fi
    done
    mr=$((mr+2));
    
    # Bottom spiral move  
    for i in $(seq 1 $mb);
    do
      pos_y=$((pos_y+1));
      printStar "$STAR";
    done
    mb=$((mb+2));
  done

  # alternates * and space
  if [ "$STAR" == "*" ]
  then
    STAR=" ";
  else
    STAR="*";
  fi
done

# cursor restore
tput cnorm;