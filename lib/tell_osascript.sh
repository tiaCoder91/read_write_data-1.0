#!/bin/bash

function tell_osascript {

osascript <<SALUTO

set x to "Ciao ( ) $NOMEPRIMARIO"
say x

SALUTO

osascript <<NEXT
property defaultClientName : "${ARRVALUEDATA[0]}"

on saluto(nameOfClient)
  display dialog "Ciao " & nameOfClient & "\nVuoi aprire il resto del programma?" buttons {"No", "Si"} default button "No" giving up after 10 with title "Read Write Data" with icon POSIX file "/Users/tia/Desktop/read_write_data/res/Terminal.icns"
end saluto
 
on greetClient(nameOfClient)
    display dialog ("Hello " & nameOfClient & "!")
end greetClient
 
script testGreet
    greetClient(defaultClientName)
    saluto(defaultClientName)
end script
 
#run testGreet --result: "Hello ${ARRVALUEDATA[0]}"
#greetClient() --result: "Hello Joe Jones!"

saluto("$NOMEPRIMARIO") --result: "Hello $NOMEPRIMARIO"

if button returned of result = "Si" then
   set myList to { "$APPCODE", "$APPTERM", "$APPMUSIC" }
   repeat with theItem in myList
      #say theItem
      if ((theItem as string) is equal to "Music") then
         tell application "Music"
            play track $TRACK
         end tell
         else
            tell application theItem
               activate
            end tell
            set myURL to "https://kat.am/usearch/$CERCA/"
            open location myURL
      end if
   end repeat
   else
    display notification "Arrivederci !!!" with title "File ${BASH_SOURCE[0]}" subtitle "da function ${FUNCNAME[0]}" sound name "Blow"
   delay 1
end if
NEXT
}

function my_echo {
   #echo "Visula Studio Code"
for l in "${APP[@]}" ; do
if [[ $l == "Music" ]] ; then
osascript <<LOOP
   tell application "$l"
      play track "$TRACK"
   end tell
LOOP
else
osascript <<LOOP
   tell application "$l"
      activate
   end tell
LOOP

fi
done
}

<<cm

set x to "Bentornato ${ARRVALUEDATA[0]}"
say x

set a to "Apro ${ARRVALUEDATA[1]}"
say a

set s to "Cerco ${ARRVALUEDATA[2]} su google"
say s

set a to "Oggi è $(date +%m) $(date +%B) $(date +%G)"
say a

set ore to "Sono le $(date +%R)"
say ore

on saluto(nameOfClient)
   display dialog "Ciao " & nameOfClient & "\nVuoi aprire il resto del programma?" buttons {"No", "Si"} default button "Si" giving up after 10 with title "Read Write Data" with icon POSIX file "/Users/tia/Desktop/read_write_data/lib/Terminal.icns"
end saluto

tell application "${APP[0]}"
   activate
end tell

tell application "${APP[1]}"
   play track "$TRACK"
end tell

tell application "${APP[2]}"
   activate
end tell

tell application "System Events"
  set myFile to "/Users/tia/Music/Music/Media.localized/Music/4 Non Blondes/Unknown Album/What's Up_.mp3"
  do shell script "ffplay \"$myFile\" &" 
  #play "/Users/tia/Music/Music/Media.localized/Music/4 Non Blondes/Unknown Album/What's Up_.mp3"
end tell

set myURL to "https://www.google.com/search?q=${ARRVALUEDATA[2]}"
open location myURL

greetClient("Joe Jones") --result: "Hello Joe Jones!"

#if button returned of result = "No" then
 #   display notification "Arrivederci !!!"
#else
 #   if button returned of result = "Si" then
  #       display alert "Apro ${ARRVALUEDATA[1]}?"
   # end if
#end if

tell application "System Events"
   do shell script "date +%c > $HOME/Desktop/LastUpdate.txt"
end tell

set result to text returned of (display dialog "Enter the Username to be made an admin:" default answer "")
display dialog "Ciao " & result & " !"
cm