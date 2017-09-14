#!/bin/bash

# clear screen before printing star
clear;
# tput civis;
# tput cnorm;

# Speed
SPEED=0.0001

# DEBUG
DEBUG(){
  tput cup $rows 0;
  echo $pos_y $pos_x;
}

SanityCheck () {
  if [ $pos_x -lt 0 ]
  then
    pos_x=0
  fi
  if [ $pos_y -lt 0 ]
  then
    pos_y=0
  fi
}

# function to print star at pos_x and pos_y
printStar () {
  # Force pos to last row/ column if less than 0
  SanityCheck
  tput cup $pos_y $pos_x;
  printf "$1";
  # DEBUG;
  sleep $SPEED;
}

Left () {
  # Left spiral move
  for i in $(seq 1 $ml);
  do
    # echo $i;
    pos_x=$((pos_x-2));
    if [ $i -eq $ml ]
    then
      printStar "$STAR";
    else
      printStar "$DOUBLESTAR";
    fi
  done
  if [ "$1" == "-" ]
  then  
    ml=$((ml-2));
  else
    ml=$((ml+2));
  fi
}

Right () {
  # Right spiral move
  for i in $(seq 1 $mr);
  do
    pos_x=$((pos_x+2));
    if [ $i -eq $mr ]
    then
      printStar "$STAR";
    else
      printStar "$DOUBLESTAR";
    fi
  done
  if [ "$1" == "-" ]
  then  
    mr=$((mr-2));
  else
    mr=$((mr+2));
  fi
}

Top () {
  # Top spiral move
  for i in $(seq 1 $mt);
  do
    pos_y=$((pos_y-1));
    printStar "$STAR";
  done
  if [ "$1" == "-" ]
  then  
    mt=$((mt-2));
  else
    mt=$((mt+2));
  fi
}

Bottom () {
  # Bottom spiral move  
  for i in $(seq 1 $mb);
  do
    pos_y=$((pos_y+1));
    printStar "$STAR";
  done
  if [ "$1" == "-" ]
  then  
    mb=$((mb-2));
  else
    mb=$((mb+2));
  fi
}

AlternateStar() {
  # alternates * and space
  if [ "$STAR" == "*" ]
  then
    STAR=" ";
    DOUBLESTAR="  ";
  else
    STAR="*";
    DOUBLESTAR="**";
  fi
}

HandleResize() {
  if [ $rows -ne `tput lines` -o $cols -ne `tput cols` ]
  then
    sleep 0.5;
    rows=`tput lines`;
    cols=`tput cols`;
    clear;
  fi
}

rows=`tput lines`;
cols=`tput cols`;

# Print Spiral
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
 
  # Switch space to *
  AlternateStar

  # prints central dot  
  printStar "$STAR";

  # Forward Spiral
  while (($ml <= $cols && $mr <= $cols && $mt <= $rows && $mb <= $rows));
  do
    Left;
    Top;
    Right;
    Bottom;
  done
  
  # Switch to space from *
  AlternateStar
  
  # Compensate final print skew
  ml=$((ml-1));
  mt=$((mt-1));
  mr=$((mr-3));
  mb=$((mb-3));
  
  # Reverse Spiral
  while (($ml > 0 && $mr > 0 && $mt > 0 && $mb > 0));
  do
    Top "-";
    Left "-";
    Bottom "-";
    Right "-";
  done
  HandleResize;

done
