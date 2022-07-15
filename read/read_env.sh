#!/bin/bash
. read/read_data_file.sh > /dev/null 2>&1
. write/write_env.sh > /dev/null 2>&1

function read_conf {
  #echo " * ------------- ${FUNCNAME[0]} --------------- *"
    file=database/config
     
    # Lettura dati config con salvataggio negli array ARRPARMDATA e ARRVALUEDATA
    read_data_file $file
    print_output_to_file

}

function read_env {
    #echo " * ------------- ${FUNCNAME[0]} --------------- *"
    file=lib/enviroment.sh
    ARR_ENV_DATA=()

    i=0
    while read line ; do
      i=$(($i+1))
      if [[ $line ]] ; then
        ARR_ENV_DATA+=( "$line" )
      fi
    done < $file

    for n in "${ARR_ENV_DATA[@]}" ; do
       #echo $n
       check_data "$n" "DATA_ENV"      #  Qui salverà i dati se conformi alla formattazione negli array ARRPARAMENV e ARRVALUEENV
    done                         

    write_env  # Qui invece confrenterà ARRPARAMDATA e ARRPARAMENV

    #for n in "${ARRPARAMENV[@]}" ; do
     #   echo "ARRPARAMENV = $n"
    #done 
    #for n in "${ARRVALUEENV[@]}" ; do
     #  echo "ARRVALUEENV = $n"
    #done 
    #echo "ARRPARAMENV = ${ARRPARAMENV[@]}"
    #echo "ARRVALUEENV = ${ARRVALUEENV[@]}"

    #echo "ARRPARAMDATA = ${ARRPARAMDATA[@]}."
    #echo "ARRVALUEDATA = ${ARRVALUEDATA[@]}."

    #echo "................................................................"

    # qui andrebbero filtrati e ricomposti i risultati con una funzione
}