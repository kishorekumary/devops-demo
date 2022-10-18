#!/bin/bash
TAG=$1
rm vulnerability-proj4-report-"$(date '+%Y-%m-%d')".txt
for i in frontend:$TAG backend:$TAG mysql-db:$TAG
do
    echo -e "+++++++++++++--------------------$i ---------------------+++++++++++++\n " >> vulnerability-proj4-report-"$(date '+%Y-%m-%d')".txt
    #print("\n")
    grype "$i" >> vulnerability-proj4-report-"$(date '+%Y-%m-%d')".txt
    echo -e "\n\n" >> vulnerability-proj4-report-"$(date '+%Y-%m-%d')".txt
done
