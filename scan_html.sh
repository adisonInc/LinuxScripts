#!/bin/bash

#dodac czy strona jest accesible przez
#sprzawdzenie tagow genius

#zrobic na koncu zmienna i wtedy bedzie >>
#przekierowanie do 1 jak bedzie git a jak do pliku wtedy
#do plku

LINK_CHECK=false
CONTAINERS=true
OUTPUT="."
OUTPUTFLAG=false
FILE=""
DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
  -l)
    LINK_CHECK=true
    ;;
  -c)
    CONTAINERS=false
    ;;
  -o)
    OUTPUTFLAG=true
    OUTPUT="$2"
    shift
    ;;
  -d)
    DIR="$2"
    shift
    ;;
  -h)
    echo -e "Srkrpyt do analizy html \n"
    echo uzycie:
    echo -e "$0 plik [-d katalog] [-l] [-o katalog_wyjściowy] \n"
    echo -e "domyslnie bez zadnych argumentow program bierze aktualna sciezke i wszystkie pliki w niej "
    echo argumenty:

    echo -e "\t -d Sciezka gdzie program szuka plikow"
    echo -e "\t -l Zliczanie stron ktore sa zlinkowane w pliku"
    echo -e "\t -v autor"
    echo -e "\t -h pomoc"
    exit 0
    ;;
  -v)
    echo -e "Werjsa 1.0 "
    echo -e "Autor: Kamil PLakwicz"
    exit 0
    ;;
  -*)
    echo "Nieznana opcja: $1"
    exit 1
    ;;
  *)
    FILE="$1"
    ;;
  esac
  shift
done

# Sprawdzenie ścieżki
if [[ -z "$FILE" && -z "$DIR" ]]; then
  echo "Podaj plik lub katalog"
  echo "UŻYCIE: $0 plik [-d katalog] [-l] [-o katalog_wyjściowy]"
  echo "$0 -h "
  exit 1
fi

# Jeśli podano katalog
if [[ -n "$DIR" ]]; then
  FILES="$DIR"/*.html
else
  FILES="$FILE"
fi

for f in $FILES; do
  echo "analizuje plik $f"

  if [[ ! -f "$f" ]]; then
    echo "plik nie istnieje"
    continue
  fi

  if $LINK_CHECK; then
    echo links:
    grep -o '<a href="[^"]*' $f | grep -o 'www.[0-z,.]*' | sort | uniq -c | sort -gr
  fi
  echo top tagi:
  grep -o '<.*[^>]*' $f | sed '/<\//d' | sed 's/\s.*//g' | sed 's/>.*//' | sed 's/$/>/' | sort | uniq -c | sort -gr | head -n 10

  echo "  "
done
