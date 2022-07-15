#!/bin/bash

function write_env {
    #echo " * ------------- ${FUNCNAME[0]} --------------- *"
    #  Confrontare param env con param data ( in uppercase )
    #+ se lo trova
    #+ fargli confrontare la linea

    for ((l=0; l<${#ARRPARAMDATA[@]}; l++)) ; do
        
        data_param_all_upper=$(echo "${ARRPARAMDATA[$l]}" | awk '{print toupper($0)}') 
        data_value="${ARRVALUEDATA[$l]}"
        #echo "data_param_all_upper = $data_param_all_upper"

        for ((n=0; n<${#ARRPARAMENV[@]}; n++)) ; do
            
            env_param_all_upper=$(echo "${ARRPARAMENV[$n]}" | awk '{print toupper($0)}') 
            #echo "env_param_all_upper = $env_param_all_upper"

            if [[ "$env_param_all_upper" == "$data_param_all_upper" ]] ; then   # Se PARAMETRO ENV è uguale a PARAMETRO DATA

               #echo "çççççççççççççççç Variabile $data_param_all_upper trovata in enviroment ççççççççççççççççççç"
               env_value="${ARRVALUEENV[$n]}"
               #echo "$env_value@@@"

               #echo "Valore di in ENV $env_param_all_upper = $env_value"
               #echo "Valore di in DATA-CONFIG $data_param_all_upper = $data_value"

               replace="$data_param_all_upper=\"$data_value\""
                        
               upgrade_env "$data_param_all_upper" "$replace"
            fi
        done

    done

}

function upgrade_env {
    #echo " * ------------- ${FUNCNAME[0]} --------------- *"
file=lib/enviroment.sh
name_param_for_rep="$1"
replace="$2"
i=0

#echo " llllllllL $name_param_for_rep LlllLLLlllLL  "

while read line ; do
    i=$(($i+1))

    if [[ ! $line ]] ; then
       echo "LINEA $i Vuota" > /dev/null
    else
       if echo "$line" | grep "$name_param_for_rep" > /dev/null ; then
          #echo "LINEA $i ---- $line"
          echo "$line" | grep "$name_param_for_rep" | sed -i -e "$i s/.*/$replace/g" $file #> database/update_env
       fi
       #sed -i "${line}s/.*/$replace/" database/update_env
       #echo "LINEA $i Con dati - $line" #>> $file
       #sed -i 's/$line/LINEA $i Con dati/' $file
    fi
done < $file
}
