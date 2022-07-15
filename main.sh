#!/bin/bash
. read/read_data_file.sh > /dev/null 2>&1
. lib/tell_osascript.sh > /dev/null 2>&1
. read/read_env.sh > /dev/null 2>&1

echo "Hello from ${BASH_SOURCE[0]} & $PWD"

file=database/config

# Salva i dati negli array ARRPARAMDATA e ARRVALUEDATA
#read_data_file $file
# Stampa il risultato riformattato in config.txt
#print_output_to_file
# Chiama lo script osascript con i dati di enviroment.sh
# Lettura enviroment.sh

read_conf
read_env


/bin/bash submain.sh
