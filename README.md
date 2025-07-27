# skrypty

Zbiór użytecznych skryptów i narzędzi automatyzujących codzienną pracę. Poniżej znajdziesz szczegółowe opisy każdego skryptu oraz przykłady użycia.

---

## Spis treści
- [gui_convert.sh](#guiconvertsh)
- [offcie_backup.sh](#offcie_backupsh)
- [scan_html.sh](#scan_htmlsh)
- [wallproc (katalog)](#wallproc)

---

## gui_convert.sh

**Opis:**  
Skrypt do konwersji plików graficznych z wygodnym GUI (Zenity). Pozwala wybrać pliki graficzne, określić format docelowy (jpg/png/webp) oraz folder wyjściowy. Obsługuje argumenty CLI, ale może działać w pełni interaktywnie.

**Argumenty:**
- `-f FORMAT` – format wyjściowy (np. jpg, png, webp)
- `-o FOLDER` – folder do zapisu przekonwertowanych plików
- `-h` – pomoc
- `-v` – wersja i autor

**Przykład użycia:**
```bash
bash gui_convert.sh -f png -o /ścieżka/docelowa
```
Jeśli nie podasz argumentów, skrypt poprosi o wybór plików i formatów przez okna dialogowe.

---

## offcie_backup.sh

**Opis:**  
Skrypt do wykonywania kopii zapasowych plików biurowych (.docx, .xlsx, .pptx, .txt) z wybranego katalogu (domyślnie bieżący) do podkatalogu `backup`. Pozwala określić liczbę dni wstecz i typy plików.

**Argumenty:**
- `-s FOLDER` – folder źródłowy (domyślnie bieżący)
- `-o FOLDER` – folder docelowy (domyślnie ./backup)
- `-d DNI` – liczba dni od ostatniej modyfikacji pliku (domyślnie 7)
- `-e PLIK` – plik z listą rozszerzeń
- `-h` – pomoc
- `-v` – wersja i autor

**Przykład użycia:**
```bash
bash offcie_backup.sh -s /ścieżka/źródłowa -o /ścieżka/backup -d 14
```
Domyślnie backupuje pliki .docx, .xlsx, .pptx, .txt z ostatnich 7 dni.

---

## scan_html.sh

**Opis:**  
Skrypt do analizy plików HTML. Pozwala sprawdzić dostępność stron, analizuje tagi, zlicza linki, obsługuje wiele plików w katalogu.

**Argumenty:**
- `plik` – plik do analizy (jeśli nie podany, analizuje wszystkie w katalogu)
- `-d KATALOG` – katalog do przeszukania
- `-l` – zliczanie linków
- `-o KATALOG` – katalog wyjściowy
- `-c` – wyłącza analizę kontenerów HTML
- `-h` – pomoc
- `-v` – wersja i autor

**Przykład użycia:**
```bash
bash scan_html.sh index.html -l
bash scan_html.sh -d /katalog/ze/stronami -o /katalog/wyjściowy
```
Można analizować pojedynczy plik lub cały katalog.

---

## wallproc (katalog)

**Opis:**  
Zaawansowany skrypt do generowania tapety systemowej z wizualizacją procesów systemowych.

- `wallproc` – główny skrypt generujący obraz i ustawiający tapetę (wymaga ImageMagick oraz swww)
- `wallproc.1` – dokumentacja man
- `wallproc.rc` – plik konfiguracyjny (rozdzielczość, kolory, czcionki, sortowanie)

**Wybrane opcje skryptu wallproc:**
- `-b` – nie ustawia tapety (tylko generuje obraz)
- `-i ŚCIEŻKA` – własny obraz tła
- `-o KATALOG` – katalog wyjściowy
- `-s cpu|mem|name` – sortowanie procesów
- `-h` – pomoc
- `-v` – wersja i autor

**Przykład użycia:**
```bash
bash wallproc/wallproc -s mem -o /ścieżka/docelowa
```
Konfiguracja w `wallproc/wallproc.rc` pozwala dostosować wygląd i zachowanie generowanej tapety.

---


# LinuxScripts
