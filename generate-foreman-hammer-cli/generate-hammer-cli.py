#!/usr/bin/env python

import csv 
from string import Template

with open('machines.csv', 'rb') as f:
    reader = csv.reader(f)
    for row in reader:
        #print row
        info = {}
        info['hostname'] = row[1]
        info['hostnamea'] = row[1] + 'a'
        info['eth0mac'] = row[3]
        info['eth1mac'] = row[5]
        info['ipmimac'] = row[7]

        #open the template
        templatein = open( 'hammer.template' )

        #read template
        src = Template( templatein.read() ) 

        # do the substitution
        hammercli = src.substitute(info)

        print hammercli

#print info

