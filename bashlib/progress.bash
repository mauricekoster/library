#!/bin/bash

MSG="Hele lange berichtje, Testing 123 ..."


    t=0
    while [ $t -le 100 ]
    do
        progress $t
        t=`expr $t + 10`
        sleep 1
    done
