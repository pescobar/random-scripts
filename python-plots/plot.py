#!/usr/bin/env python
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt

def main():
    time, memory = parse_file('memory_run1.log')
    #print time
    #print memory
    plt.ylabel('memory consumption')
    #plt.plot(memory, time)
    plt.plot(time, memory)
    plt.show()

def parse_file(file):

    time_values = []
    memory_values = []
    
    f = open(file)
    for l in f.readlines():
        if l.startswith('time'):
            time = l.split()[0].split(":")[1]
            memory = l.split()[1].split(":")[1]
            #print time, memory
            time_values.append(time)
            memory_values.append(memory)
    f.close()
    return time_values, memory_values

if __name__ == "__main__":
    main()








