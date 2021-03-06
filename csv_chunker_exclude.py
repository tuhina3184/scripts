#!/usr/bin/python

"""
Splits csv files into indexes

Usage:
csv_chunker_exclude.py <input.csv> <output.csv> <comma seperated indexes e.g., 0,2,4 to exclude>

Last Updated:
8 June 2017
"""

import sys



file = open(sys.argv[1]).read()
lines = file.split('\n')
# index = [0,1,4]
index = [int(i) for i in sys.argv[3].split(',')]

# index2 = []
# index = sys.argv[3].split(',')
# for i in index:
# 	index2.append(int(i))
# index = index2
# lines = open(sys.argv[1]).readlines()

ofile = open(sys.argv[2], "w")
for line in lines:
	values = line.split(',')
	for key in xrange(len(values)):
		if key in index:
			continue
		ofile.write(values[key] + ',')
	ofile.write('\n')

ofile.close()


if len(sys.argv) > 4:
	for line in open(sys.argv[2]).readlines():
		print line, 