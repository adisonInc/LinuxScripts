#!/bin/bash
outdir=false
format=false
while [[ $# -gt 0 ]]; do
  case "$1" in
  -o)
    outdir="$2"
    echo wybrany output: "$2"
    ;;
  -f)
    format="$2"
    echo wybrany format: "$2"
    ;;

  -h)
    echo -e "Skrypt do konwersji plikow \n"
    echo uzycie:
    echo -e "$0 [-f FormatWyjsciowy] [-o FolderWyjsciowy] [-h] [-v]\n"
    echo argumenty
    echo -e "\t -f Format do ktorego beda konwertowane pliki"
    echo -e "\t -o Sciezka wyjscia gdzie program umiesci pliki"
    echo -e "\t -v autor"
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

zenity_custom() {
  zenity "$@" 2>/dev/null
}

files=$(zenity_custom --file-selection --multiple --title="Wybierz zdjęcia" --file-filter="Obrazy | *.jpg *.png *.jpeg *.bmp *.webp")
[ $? -ne 0 ] && exit 1

if [[ "$format" == false ]]; then

  format=$(zenity --list --radiolist --title="Wybierz format wyjściowy" \
    --column="Wybierz" --column="Format" \
    TRUE "jpg" FALSE "png" FALSE "webp")
  [ $? -ne 0 ] && exit 1

fi

echo wybrany format: "$format"

if [[ "$outdir" == false ]]; then

  outdir=$(zenity --file-selection --directory --title="Wybierz katalog zapisu")
  [ $? -ne 0 ] && exit 1

fi
echo wybrany output: "$outdir"
IFS="|" read -ra file_array <<<"$files"
total=${#file_array[@]}
(
  for i in "${!file_array[@]}"; do
    src="${file_array[$i]}"
    base=$(basename "$src")
    name="${base%.*}"
    outpath="$outdir/${name}_converted.$format"

    convert "$src" "$outpath"

    echo $(((i + 1) * 100 / total))
  done
) | zenity --progress --title="Konwertowanie..." --percentage=0 --auto-close

# Krok 7: Koniec
zenity --info --text="Konwersja zakończona.\nZapisano do katalogu:\n$outdir"
