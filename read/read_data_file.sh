#!/bin/bash
. lib/enviroment.sh > /dev/null 2>&1
. write/write_data_file.sh > /dev/null 2>&1

FIRST=

# Toglie tutti gli spazi vuoti "${param//[[:blank:]]/}"
# Ho usato una solo stringa in entrata e l'ho fatta dividere alla presenza dell' = ( prima PARAM se è true VALUE)
function check_data {

    #echo " * ------------- ${FUNCNAME[0]} --------------- *" 
    #echo "$@ = 2"

    FIRST="$1"
    lh_input=${#FIRST}
    param=""
    value=""
    found=false

    #echo "$lh_input"

    # --------- Controllo della presenza dell' "=" nella linea dei dati ----------------
    for ((i=0; i<$lh_input; i++)) ; do
       check="${FIRST:$i:1}" 
       #hex_quote_check=$(xxd -pu <<<$check)
       #printf "hex_quote_check = $hex_quote_check - $check\n"
        if [[ $check == "=" ]] ; then 
           #echo "::::::::::::::......:::: TRUE ::::.........:::::::::........:::::"
           found=true
           break
        fi
        param+="$check"  # Stringa ricomposta dei parametri che riduce lo spazio tra le parole a 1 e quello iniziale ma non nel finale
    done


    # ------------- Se il formato di una singola riga è compatibile con il formato richiesto PARAM = VALUE
    # + ----------- divide il prefisso dal valore e li inserisce in due array separati  -------------
    if [[ $found == true ]] ; then

        for ((i=${#param}+1; i<$lh_input; i++)) ; do
        check="${FIRST:$i:1}" 
        #hex_quote_check=$(xxd -pu <<<$check)
        #printf "hex_quote_check = $hex_quote_check - $check\n"
            if [[ "${FIRST:$i:1}" != "\"" ]] ; then
               value+="${FIRST:$i:1}" # Stringa ricomposta dei valori togliendo da inizio riga all' = ( PARAMAMETRO )
            fi
        done

        #echo "°°°°°°°°°°°°°°°°°° PARAM °°°°°°°°°°°°°°°°°°°" $param
        #echo "°°°°°°°°°°°°°°°°°° VALUE °°°°°°°°°°°°°°°°°°°" $value

        quote_param=$(sed -e 's/\ *$//g' <<<${param//[[:blank:]]/} | awk '{print toupper($0)}')  # | awk '{print toupper($0)}'
        quote_value=$(sed -e 's/\ *$//g' <<<$value)  # Toglie gli spazi iniziali e finali

        hex_quote_param=$(xxd -pu <<<$quote_param)  # Conversione in hex
        #hex_quote_value=$(xxd -pu <<<$quote_value)  # Conversione in hex

        if [[ $hex_quote_param != "0a" ]] ; then   # Salvataggio se non è 0a
           if [[ ! $quote_value ]] ; then quote_value="" ; fi
           case "$2" in
               DATA_DES) ARRPARAMDATA+=( "$quote_param" ) ; ARRVALUEDATA+=( "$quote_value" ) ;;
               DATA_ENV) ARRPARAMENV+=( "$quote_param" ) ; ARRVALUEENV+=( "$quote_value" ) ;;
               *) ARRPARAMSUP+=( "$quote_param" ) ; ARRVALUESUP+=( "$quote_value" ) ;;
           esac
           #else
             #echo "Tipo di dato 0a non compatibile" > /dev/null 
        fi
        #else
          #echo "Tipo di dato non compatibile." > /dev/null
    fi
}

function read_data_file {
    #echo " * ------------- ${FUNCNAME[0]} --------------- *"
    file=$1
    ARRPARAMDATA=()
    ARRVALUEDATA=()

    # -------- Lettura linee righe -----------
    while read new_line ; do
       if [[ ! $new_line ]] ; then 
          shift
          else
          if ! echo "$new_line" | grep "#" > /dev/null ; then
             arr_data_script+=( "$new_line" )
          fi
       fi
       #echo "line = $new_line"
    done < $file

    # --------- Controllo compatibilità dati con check_dat nell' arr_data_script = ( riga per riga del file ) --------
    for n in "${arr_data_script[@]}" ; do       #n in "${arr_data_script[@]}" ; do
       #echo ""
       check_data "$n" "DATA_DES"  #  Qui salverà i dati se conformi alla formattazione negli array ARRPARAMDATA e ARRVALUEDATA
    done
<<cm
    # ------------ Controllo che gli array salvati abbiano la stessa lunghezza -----------
    if [[ ${#ARRPARAMDATA[@]} == ${#ARRVALUEDATA[@]} ]] ; then
       echo "ARRPARAMDATA = ${ARRPARAMDATA[@]}."
       echo "ARRVALUEDATA = ${ARRVALUEDATA[@]}."
       #print_output
       else
         echo "Dati non compatibili per la scrittura !!!"
    fi
cm
}
