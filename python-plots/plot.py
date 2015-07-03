#!/usr/bin/env python
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt

def main():
    time, memory, procs, threads = parse_file('memory_run1.log')
    #print time
    #print memory
    #print memory
    #print procs
    #print threads
    #plt.ylabel('memory consumption')
    #plt.plot(time,memory, 'r--', time, procs, 'bs', time, threads, 'g^')
    #plt.plot(time, memory)
    line1, = plt.plot(time, memory, 'k--', label='Memory (GB)', color='green')
    line2, = plt.plot(time, procs, 'k:', label='Num Procs', color = 'red')
    line3, = plt.plot(time, threads, 'k:', label='Num Treads', color = 'blue')
    plt.ticklabel_format(style='plain', axis='y')
    #legend = plt.legend(loc='upper center', shadow=True)
    legend = plt.legend()
    plt.show()

def parse_file(file):

    time_values = []
    memory_values = []
    num_procs = []
    num_threads = []
    
    f = open(file)
    for l in f.readlines():
        if l.startswith('time'):
            time = l.split()[0].split(":")[1]
            memory = l.split()[1].split(":")[1]
            # memory is in MB so divide by 1024 and round it so the 
            # graph is easier to read. +-1G of ram is fine...
            memory = round(float(memory) / 1024)
            numprocs = l.split()[3].split(":")[1]
            numthreads = l.split()[4].split(":")[1]
            #print time, memory
            time_values.append(time)
            memory_values.append(memory)
            num_procs.append(numprocs)
            num_threads.append(numthreads)
    f.close()
    return time_values, memory_values, num_procs, num_threads

if __name__ == "__main__":
    main()








