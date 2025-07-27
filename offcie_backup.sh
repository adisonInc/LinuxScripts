#!/bin/bash

DAYS=7
SOURCE="."
EXT=".docx .xlsx .pptx .txt"
if [ ! -d "$SOURCE/backup" ]; then
  mkdir backup
fi

touch /tmp/backlog

OUTPUT="$SOURCE/backup/"

while [[ $# -gt 0 ]]; do
  case "$1" in
  -s)
    SOURCE="$2"
    shift
    ;;
  -o)
    OUTPUT="$2"
    shift
    ;;
  -d)
    DAYS="$2"
    shift
    ;;
  -e)
    EXT=$(cat "$2")
    ;;
  -h)
    echo -e "Srkrpyt do kopii zapasowej \n"
    echo uzycie:
    echo -e "$0 [-s FolderZrodlowy] [-o FolderWyjsciowy] [-d DNI] [-e PLIK] [-h] \n"
    echo -e "domyslnie bez zadnych argumentow program bierze aktualna sciezke oraz folder ./backup w miejscu sciezki \n"
    echo argumenty

    echo -e "\t -s Sciezka zrodowla gdzie program szuka plikow rekursywnie"
    echo -e "\t -o Sciezka wyjscia gdzie program umiescie kopie plikow"
    echo -e "\t -d Ilosc dni od modyfikacji plikow ktore uwzgledni program"
    echo -e "\t -h pomoc"
    exit 0
    ;;
  -v)
    echo "Wersja: 1.0"
    echo "Autor: Kamil Plakwicz"
    exit 0
    ;;
  -*)
    echo nieprawidlowy argument
    echo srkypt -h
    exit 1
    ;;

  esac
  shift
done

echo KOPIA ZAPASOWA DANYCH
echo " "
echo OUTPUT "->" $OUTPUT
echo ROSZERZENIA "->" $EXT
echo CZAS OD MODYFIKACJI W DNIACH "->" $DAYS
echo " "
echo skopiowane pliki:
echo

for i in $EXT; do
  FOUND=$(find $SOURCE -type f -name "*$i" -mtime -$DAYS)
  if [[ $FOUND != "" ]]; then
    echo $i | sed 's/^/ext: /'
  fi

  for j in $FOUND; do
    if [[ $j != "$OUTPUT/$j" ]]; then
      LIST+="\t$j\n"
      cp -f $j $OUTPUT 2>/tmp/backlog
    fi
  done
  echo -e $LIST | sort
  LIST=""
done

cat /tmp/backlog

rm /tmp/backlog
