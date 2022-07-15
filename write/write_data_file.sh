#!/bin/bash

function print_output_to_file {
    #echo " * ------------- ${FUNCNAME[0]} --------------- *"
    file=database/output-config

    printf "#  ------- CONFIGURAZIONE -------  \n\n" > $file
    for ((i=0; i<${#ARRPARAMDATA[@]}; i++)) ; do
        #param_all_lower=$(echo "${ARRPARAMDATA[$i]}" | awk '{print tolower($0)}')
        param_all_upper=$(echo "${ARRPARAMDATA[$i]}" | awk '{print toupper($0)}') 
        param_all_upper=${param_all_upper//[[:blank:]]/}
        #param_first_upper=$(echo $param_all_lower | awk '{print toupper( substr($0, 1, 1) ) substr( $0, 2 ); }')        # $(echo ${ARRPARAMDATA[$i]} | tr '[:upper:]' '[:lower:]')
        
        #value_all_lower=$(echo "${ARRVALUEDATA[$i]}" | awk '{print tolower($0)}') 
        #value_upper=$(echo $value_all_lower | awk '{print toupper( substr($0, 1, 1) ) substr( $0, 2 ); }')

        value="${ARRVALUEDATA[$i]}"
        
        #if [[ $i == 0 ]] ; then
         #  echo "$param_first_upper : $value" > ~/Desktop/Descrizione.txt
          # else
             echo "$param_all_upper=$value" >> $file
        #fi
        #echo "$param_all_upper=$value"
    done
}
