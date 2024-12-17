# Windows Software Monitor Deployment

> [!WARNING]
> **Ostrzeżenie:** Ten projekt jest remakem oprogramowania, które może być uznane za spyware. Używasz go na własne ryzyko. Autor nie ponosi odpowiedzialności za jakiekolwiek szkody.


## Skrypty

### Package Installer

* **Cel:**  Instalacja, odinstalowywanie, przypinanie i odpinanie programów.
* **Działanie:** Skrypt korzysta z pliku `programs.json`  do zarządzania listą programów.  W pliku tym można zdefiniować programy do instalacji,  ścieżki instalacji,  opcje instalacji,  a także określić, czy program ma być przypięty do menu Start lub paska zadań.

### Task Cleaner

* **Cel:**  Utrzymanie aktualności skryptów.
* **Działanie:** Skrypt usuwa stare i niepotrzebne zadania, pliki tymczasowe i inne pozostałości po poprzednich wersjach skryptów,  zapewniając, że system jest czysty i działa optymalnie.

### Updater

* **Cel:** Aktualizacja, instalacja i uruchamianie skryptów.
* **Działanie:** Skrypt pobiera najnowsze wersje skryptów z repozytorium,  instaluje je i uruchamia.  Automatyzuje proces aktualizacji,  zapewniając, że zawsze korzystasz z najnowszej wersji oprogramowania.

### Util

* **Cel:**  Konfiguracja Dockera i instalacja Nmapa.
* **Działanie:**  Skrypt konfiguruje środowisko Docker przed pierwszym uruchomieniem,  instalując niezbędne komponenty i zależności.  Dodatkowo instaluje Nmapa,  narzędzie do skanowania sieci,  które może być używane do monitorowania aktywności sieciowej.

### Disable Bitlocker

* **Cel:** Wyłączenie szyfrowania dysków Bitlocker.
* **Działanie:** Skrypt wyłącza funkcję Bitlocker,  która szyfruje dane na dysku twardym.  Może to być konieczne w niektórych środowiskach,  aby umożliwić dostęp do danych lub wdrożenie oprogramowania.

### Firetower

* **Cel:** Blokowanie uruchamiania gier i platform gamingowych.
* **Działanie:**  Skrypt blokuje uruchamianie popularnych platform gamingowych,  takich jak Steam, Epic Games Store i Origin.  Osiąga to poprzez blokowanie żądań sieciowych do serwerów tych platform.  Dodatkowo,  skrypt uniemożliwia uruchamianie gier,  nawet jeśli uda się je uruchomić,  blokując dostęp do niezbędnych plików i zasobów.

### Healer

* **Cel:** Naprawa systemu Windows.
* **Działanie:**  Skrypt uruchamia narzędzia systemowe DISM i SFC,  które służą do naprawy uszkodzonych plików systemowych i przywracania integralności systemu operacyjnego.

### Domain Accounts

* **Cel:**  Konfiguracja kont domenowych.
* **Działanie:**  Skrypt konfiguruje konta domenowe na komputerze lokalnym.  Usuwa konto administratora,  uniemożliwiając wykorzystanie luk w zabezpieczeniach.  Oferuje możliwość manualnego wyboru,  które funkcje zabezpieczeń mają być włączone.

### Local Accounts

* **Cel:**  Konfiguracja kont lokalnych.
* **Działanie:**  Skrypt konfiguruje konta lokalne na komputerze,  zapewniając podobne funkcje zabezpieczeń jak w przypadku kont domenowych,  ale bez użycia Active Directory.

### Logoff Domain Admin

* **Cel:** Wylogowanie z kont administratora domeny.
* **Działanie:**  Skrypt wylogowuje użytkownika z wszystkich kont administratora domeny,  nie usuwając ich.

### Schedule Task

* **Cel:**  Planowanie zadań.
* **Działanie:**  Skrypt umożliwia planowanie zadań,  takich jak automatyczne sprawdzanie wersji oprogramowania lub sprawdzanie programów.  Umożliwia to automatyzację  powtarzalnych czynności i utrzymanie systemu w dobrym stanie.

### AV Bypass

* **Cel:**  Ominięcie oprogramowania antywirusowego.
* **Działanie:**  Skrypt dodaje pliki i procesy projektu do listy wyjątków oprogramowania antywirusowego,  zapobiegając blokowaniu i fałszywym alarmom.  Może również modyfikować ustawienia  antywirusa,  aby umożliwić  działanie skryptom.