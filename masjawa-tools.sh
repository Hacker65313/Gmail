#!/bin/bash
# ═══════════════════════════════════════════════════════════════
#   MasJawa Hacking Tools - Kali Linux / Termux Edition
#   Author  : Fendipendol
#   Version : 2.0
#   Desc    : Tools Gmail
# ═══════════════════════════════════════════════════════════════

# ─── COLORS ───────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
DIM='\033[2m'
BLINK='\033[5m'
RESET='\033[0m'
BG_BLACK='\033[40m'
BG_RED='\033[41m'
BG_GREEN='\033[42m'

# ─── TERMINAL SIZE ────────────────────────────────────────────
COLS=$(tput cols 2>/dev/null || echo 70)

# ─── UTILS ────────────────────────────────────────────────────
center() {
  local text="$1"
  local color="${2:-$RESET}"
  local len=${#text}
  local pad=$(( (COLS - len) / 2 ))
  printf "%${pad}s" ""
  echo -e "${color}${text}${RESET}"
}

divider() {
  local char="${1:--}"
  local color="${2:-$DIM$GREEN}"
  printf "${color}"
  printf '%*s' "$COLS" '' | tr ' ' "$char"
  printf "${RESET}\n"
}

thin_div() {
  local color="${1:-$DIM}"
  printf "${color}"
  printf '%*s' "$COLS" '' | tr ' ' '─'
  printf "${RESET}\n"
}

pause() {
  echo ""
  echo -e "${DIM}  Tekan ${GREEN}[ENTER]${DIM} untuk melanjutkan...${RESET}"
  read -r
}

clear_screen() {
  clear
  echo ""
}

typing_effect() {
  local text="$1"
  local color="${2:-$GREEN}"
  local delay="${3:-0.03}"
  printf "${color}"
  for (( i=0; i<${#text}; i++ )); do
    printf '%s' "${text:$i:1}"
    sleep "$delay"
  done
  printf "${RESET}\n"
}

spinner() {
  local pid=$1
  local msg="${2:-Processing...}"
  local delay=0.1
  local frames=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
  local i=0
  while kill -0 "$pid" 2>/dev/null; do
    printf "\r  ${GREEN}${frames[$i]}${RESET}  ${msg}"
    i=$(( (i+1) % ${#frames[@]} ))
    sleep $delay
  done
  printf "\r  ${GREEN}✓${RESET}  ${msg}${GREEN} [DONE]${RESET}\n"
}

progress_bar() {
  local current=$1
  local total=$2
  local width=40
  local filled=$(( current * width / total ))
  local empty=$(( width - filled ))
  local pct=$(( current * 100 / total ))

  printf "\r  ["
  printf "${GREEN}"
  printf '%*s' "$filled" '' | tr ' ' '█'
  printf "${DIM}"
  printf '%*s' "$empty" '' | tr ' ' '░'
  printf "${RESET}"
  printf "] ${GREEN}%3d%%${RESET}" "$pct"
}

# ═══════════════════════════════════════════════════════════════
#   WELCOME ANIMATION
# ═══════════════════════════════════════════════════════════════
show_welcome() {
  clear_screen
  divider '═' "$GREEN"
  echo ""

  # Matrix-like loading effect
  for i in {1..3}; do
    for col in {1..4}; do
      printf "${DIM}${GREEN}"
      printf '%*s' "$((RANDOM % COLS))" '' | tr ' ' ' '
      printf '%s' "$(cat /dev/urandom 2>/dev/null | tr -dc '01' 2>/dev/null | head -c 30 || echo '010110100101101001011010')"
      printf "${RESET}\n"
    done
    sleep 0.1
    clear_screen
  done

  divider '═' "$GREEN"
  echo ""

  # ASCII WELCOME
  echo -e "${GREEN}${BOLD}"
  center "██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗"
  center "██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝"
  center "██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  "
  center "██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  "
  center "╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗"
  center " ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝"
  echo ""
  center "████████╗ ██████╗  ██████╗ "
  center "╚══██╔══╝██╔═══██╗██╔═══██╗"
  center "   ██║   ██║   ██║██║   ██║"
  center "   ██║   ██║   ██║██║   ██║"
  center "   ██║   ╚██████╔╝╚██████╔╝"
  center "   ╚═╝    ╚═════╝  ╚═════╝ "
  echo -e "${RESET}"

  divider '─' "$DIM$GREEN"
  center "[ SIMULATION LEARNING PLATFORM v2.0 ]" "$DIM$GREEN"
  divider '─' "$DIM$GREEN"
  echo ""

  # Boot sequence
  local boot_msgs=(
    "Initializing kernel modules..."
    "Loading network interface..."
    "Connecting to secure server..."
    "Decrypting payload modules..."
    "Loading Gmail exploit framework..."
    "Bypassing firewall rules..."
    "Checking root privileges..."
    "All systems operational."
  )

  for msg in "${boot_msgs[@]}"; do
    printf "  ${DIM}[${GREEN}+${DIM}]${RESET} ${DIM}${msg}${RESET}"
    sleep 0.3
    printf " ${GREEN}✓${RESET}\n"
  done

  echo ""
  divider '═' "$GREEN"
  echo ""
  center "⚡  SYSTEM READY  ⚡" "$GREEN$BOLD"
  echo ""
  pause
}

# ═══════════════════════════════════════════════════════════════
#   GMAIL ASCII LOGO + AUTHOR
# ═══════════════════════════════════════════════════════════════
show_gmail_logo() {
  clear_screen
  divider '═' "$GREEN"
  echo ""

  # Gmail ASCII Art Logo
  echo -e "${RED}${BOLD}"
  center "  ██████╗ ███╗   ███╗ █████╗ ██╗██╗     "
  center " ██╔════╝ ████╗ ████║██╔══██╗██║██║     "
  center " ██║  ███╗██╔████╔██║███████║██║██║     "
  center " ██║   ██║██║╚██╔╝██║██╔══██║██║██║     "
  center " ╚██████╔╝██║ ╚═╝ ██║██║  ██║██║███████╗"
  center "  ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚══════╝"
  echo -e "${RESET}"

  # Gmail Envelope Art
  echo -e "${WHITE}"
  center "  ╔══════════════════════════════════╗"
  center "  ║  ╲          Gmail              ╱  ║"
  center "  ║    ╲  ___________________  ╱    ║"
  center "  ║      ╲╱  M  @  G  M  A  ╱╲      ║"
  center "  ║      ╱╲  I  L  .  C  O  ╱╲      ║"
  center "  ║    ╱    ╲_______________╱    ╲    ║"
  center "  ║  ╱                              ╲  ║"
  center "  ╚══════════════════════════════════╝"
  echo -e "${RESET}"

  echo ""
  divider '─' "$DIM$GREEN"
  center "MASJAWA HACKING TOOLS" "$GREEN$BOLD"
  divider '─' "$DIM$GREEN"
  echo ""

  # Author info
  echo -e "${DIM}${GREEN}"
  center "┌─────────────────────────────────┐"
  center "│          TOOL INFORMATION        │"
  center "├─────────────────────────────────┤"
  center "│  Author   :  Fendipendol         │"
  center "│  Version  :  2.0                 │"
  center "│  Platform :  Kali Linux / Termux │"
  center "│  Type     :  Hacking Learning │"
  center "│  Target   :  Gmail               │"
  center "└─────────────────────────────────┘"
  echo -e "${RESET}"

  echo ""
  divider '═' "$GREEN"
  echo ""
  pause
}

# ═══════════════════════════════════════════════════════════════
#   INPUT TARGET GMAIL
# ═══════════════════════════════════════════════════════════════
input_gmail() {
  while true; do
    clear_screen
    divider '═' "$GREEN"
    center "📧  GMAIL TOOLS  📧" "$GREEN$BOLD"
    divider '═' "$GREEN"
    echo ""
    center "[ INPUT TARGET GMAIL ACCOUNT ]" "$DIM$GREEN"
    echo ""
    thin_div

    echo ""
    printf "  ${DIM}[${GREEN}?${DIM}]${RESET} Masukkan target Gmail ${DIM}(contoh: target@gmail.com)${RESET}\n"
    echo ""
    printf "  ${GREEN}▸ Email  :${RESET} "
    read -r TARGET_GMAIL

    # Validation
    if [[ -z "$TARGET_GMAIL" ]]; then
      echo ""
      echo -e "  ${RED}[!] Email tidak boleh kosong!${RESET}"
      sleep 1.5
      continue
    fi

    if [[ "$TARGET_GMAIL" =~ ^[a-zA-Z0-9._%+-]+@gmail\.com$ ]]; then
      echo ""
      printf "  ${DIM}[${GREEN}+${DIM}]${RESET} Memvalidasi email"
      for i in {1..5}; do
        printf "${GREEN}.${RESET}"
        sleep 0.2
      done
      echo ""
      echo ""
      echo -e "  ${GREEN}[✓] FORMAT VALID — TARGET DITEMUKAN${RESET}"
      echo ""
      echo -e "  ${DIM}Target   :${RESET} ${GREEN}${TARGET_GMAIL}${RESET}"
      echo -e "  ${DIM}Status   :${RESET} ${GREEN}ONLINE${RESET}"
      echo -e "  ${DIM}Verified :${RESET} ${GREEN}YES${RESET}"
      echo ""
      thin_div
      echo ""
      pause
      break
    else
      echo ""
      echo -e "  ${RED}[✗] Format tidak valid! Harus menggunakan @gmail.com${RESET}"
      sleep 2
    fi
  done
}

# ═══════════════════════════════════════════════════════════════
#   MAIN MENU
# ═══════════════════════════════════════════════════════════════
show_main_menu() {
  clear_screen
  divider '═' "$GREEN"
  echo -e "  ${GREEN}${BOLD}⚡ TOOLS MENU${RESET}  ${DIM}[ SELECT OPERATION MODE ]${RESET}"
  divider '═' "$GREEN"
  echo ""
  echo -e "  ${DIM}Target  :${RESET} ${GREEN}${TARGET_GMAIL}${RESET}  ${DIM}[VERIFIED ✓]${RESET}"
  echo ""
  thin_div
  echo ""

  echo -e "  ${DIM}[${GREEN}01${DIM}]${RESET}  🗑  ${WHITE}REMOVE DATA SERVER GMAIL${RESET}"
  echo -e "       ${DIM}Hapus seluruh data dari server Gmail target${RESET}"
  echo ""
  echo -e "  ${DIM}[${GREEN}02${DIM}]${RESET}  🔍  ${WHITE}CEK DATA GMAIL${RESET}"
  echo -e "       ${DIM}Lihat foto & APK yang terhubung ke akun${RESET}"
  echo ""
  echo -e "  ${DIM}[${GREEN}03${DIM}]${RESET}  🎯  ${WHITE}AMBIL ALIH GMAIL${RESET}"
  echo -e "       ${DIM}Akses kontrol penuh akun Gmail target${RESET}"
  echo ""
  echo -e "  ${DIM}[${GREEN}04${DIM}]${RESET}  🔒  ${WHITE}KUNCI GMAIL${RESET}"
  echo -e "       ${DIM}Kunci akses akun Gmail target${RESET}"
  echo ""
  echo -e "  ${DIM}[${CYAN}05${DIM}]${RESET}  🛡  ${WHITE}PEMBERSIHAN DEVICE DARI VIRUS${RESET}"
  echo -e "       ${DIM}Scan & bersihkan virus dari device target${RESET}"
  echo ""
  echo -e "  ${DIM}[${RED}00${DIM}]${RESET}  🚪  ${RED}KELUAR / GANTI TARGET${RESET}"
  echo ""
  thin_div
  echo ""
  printf "  ${GREEN}▸ Pilih menu  :${RESET} "
  read -r MENU_CHOICE

  case "$MENU_CHOICE" in
    1|01) tool_remove_data ;;
    2|02) tool_cek_data ;;
    3|03) tool_takeover ;;
    4|04) tool_kunci ;;
    5|05) tool_virus_cleaner ;;
    0|00) return 1 ;;
    *)
      echo ""
      echo -e "  ${RED}[!] Pilihan tidak valid!${RESET}"
      sleep 1.2
      show_main_menu
      ;;
  esac
}

# ═══════════════════════════════════════════════════════════════
#   TOOL 1: REMOVE DATA SERVER GMAIL
# ═══════════════════════════════════════════════════════════════
tool_remove_data() {
  clear_screen
  divider '═' "$RED"
  echo -e "  ${RED}${BOLD}🗑  REMOVE DATA SERVER GMAIL${RESET}"
  divider '═' "$RED"
  echo ""
  echo -e "  ${DIM}Target  :${RESET} ${RED}${TARGET_GMAIL}${RESET}"
  echo ""
  thin_div
  echo ""
  echo -e "  ${YELLOW}[!] PERINGATAN: Proses ini akan menghapus semua data Gmail target${RESET}"
  echo ""
  printf "  ${GREEN}▸ Lanjutkan? (y/n)  :${RESET} "
  read -r confirm

  if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo ""
    echo -e "  ${DIM}Proses dibatalkan.${RESET}"
    sleep 1
    show_main_menu
    return
  fi

  echo ""
  divider '─' "$RED"
  echo ""

  local remove_logs=(
    "Connecting to Gmail API server..."
    "Authentication bypass initiated..."
    "Session token obtained..."
    "Scanning account data structure..."
    "Found: 1,247 photos — queued for removal"
    "Found: 3,892 emails — queued for removal"
    "Found: 412 contacts — queued for removal"
    "Found: 87 documents — queued for removal"
    "Found: 2 APK connections (WA, TikTok)"
    "Disconnecting WhatsApp backup..."
    "Disconnecting TikTok session..."
    "Initiating deep server wipe..."
    "Removing photos from Google Photos..."
    "Purging email server cache..."
    "Wiping contact database..."
    "Removing app permissions..."
    "Clearing session tokens..."
    "Overwriting backup data..."
    "Sending delete commands to CDN..."
    "Flushing DNS records..."
    "Removing account from index..."
    "Finalizing server-side deletion..."
    "Verifying data removal..."
    "Sending confirmation ping..."
  )

  local TOTAL=180  # 3 minutes
  local LOG_COUNT=${#remove_logs[@]}
  local LOG_INTERVAL=$(( TOTAL / LOG_COUNT ))

  echo -e "  ${RED}[⚡] MEMULAI PROSES REMOVE DATA...${RESET}"
  echo ""

  local log_idx=0
  local elapsed=0

  while [ $elapsed -lt $TOTAL ]; do
    # Print log at intervals
    if (( elapsed % LOG_INTERVAL == 0 )) && [ $log_idx -lt $LOG_COUNT ]; then
      echo -e "  ${DIM}[${GREEN}+${DIM}]${RESET} ${DIM}${remove_logs[$log_idx]}${RESET} ${GREEN}✓${RESET}"
      log_idx=$(( log_idx + 1 ))
    fi

    # Progress bar
    progress_bar $elapsed $TOTAL

    # Timer
    local m=$(printf "%02d" $(( elapsed / 60 )))
    local s=$(printf "%02d" $(( elapsed % 60 )))
    local pct=$(( elapsed * 100 / TOTAL ))
    printf "  ${DIM}  ⏱  ${m}:${s} / 03:00${RESET}"

    sleep 1
    elapsed=$(( elapsed + 1 ))
  done

  # Final progress
  progress_bar $TOTAL $TOTAL
  printf "  ${DIM}  ⏱  03:00 / 03:00${RESET}\n"

  echo ""
  echo ""
  divider '═' "$GREEN"
  echo -e "  ${GREEN}${BOLD}"
  echo "  ╔════════════════════════════════════╗"
  echo "  ║   ✓  PROSES REMOVE SELESAI 100%   ║"
  echo "  ╚════════════════════════════════════╝"
  echo -e "${RESET}"
  echo -e "  ${DIM}Semua data dari ${RED}${TARGET_GMAIL}${DIM} telah dihapus.${RESET}"
  echo ""
  divider '═' "$GREEN"
  echo ""
  pause
  show_main_menu
}

# ═══════════════════════════════════════════════════════════════
#   TOOL 2: CEK DATA GMAIL
# ═══════════════════════════════════════════════════════════════
tool_cek_data() {
  clear_screen
  divider '═' "$GREEN"
  echo -e "  ${GREEN}${BOLD}🔍  CEK DATA GMAIL${RESET}  ${DIM}[ DATA & APLIKASI TERHUBUNG ]${RESET}"
  divider '═' "$GREEN"
  echo ""
  echo -e "  ${DIM}Target  :${RESET} ${GREEN}${TARGET_GMAIL}${RESET}  ${DIM}[LIVE ●]${RESET}"
  echo ""

  # Scanning animation
  printf "  ${DIM}[${GREEN}+${DIM}]${RESET} Mengambil data akun"
  for i in {1..8}; do
    printf "${GREEN}.${RESET}"
    sleep 0.18
  done
  echo -e " ${GREEN}✓${RESET}"
  echo ""

  thin_div
  echo ""

  # ─ Foto Section ─
  echo -e "  ${CYAN}${BOLD}▸ DATA FOTO AKUN${RESET}"
  echo ""
  echo -e "  ${DIM}Total Foto Tersimpan  :${RESET} ${GREEN}1,247 files${RESET}"
  echo -e "  ${DIM}Google Photos         :${RESET} ${GREEN}✓ Terhubung${RESET}"
  echo -e "  ${DIM}Ukuran Backup         :${RESET} ${YELLOW}4.2 GB${RESET}"
  echo -e "  ${DIM}Auto Sync             :${RESET} ${GREEN}[AKTIF]${RESET}"
  echo -e "  ${DIM}Foto Privat           :${RESET} ${RED}83 files terdeteksi${RESET}"
  echo ""

  thin_div
  echo ""

  # ─ APK Section ─
  echo -e "  ${CYAN}${BOLD}▸ APLIKASI TERHUBUNG${RESET}"
  echo ""

  echo -e "  ${GREEN}┌──────────────────────────────────────────────┐${RESET}"
  echo -e "  ${GREEN}│${RESET}  💬  ${WHITE}WhatsApp${RESET}                                  ${GREEN}│${RESET}"
  echo -e "  ${GREEN}│${RESET}      ${DIM}Status   :${RESET} ${GREEN}[✓ TERHUBUNG]${RESET}                  ${GREEN}│${RESET}"
  echo -e "  ${GREEN}│${RESET}      ${DIM}Sync     :${RESET} ${GREEN}Aktif${RESET}                          ${GREEN}│${RESET}"
  echo -e "  ${GREEN}│${RESET}      ${DIM}Backup   :${RESET} ${YELLOW}2.1 GB${RESET}                         ${GREEN}│${RESET}"
  echo -e "  ${GREEN}│${RESET}      ${DIM}Koneksi  :${RESET} ${GREEN}Gmail OAuth2${RESET}                   ${GREEN}│${RESET}"
  echo -e "  ${GREEN}└──────────────────────────────────────────────┘${RESET}"
  echo ""
  echo -e "  ${GREEN}┌──────────────────────────────────────────────┐${RESET}"
  echo -e "  ${GREEN}│${RESET}  🎵  ${WHITE}TikTok${RESET}                                     ${GREEN}│${RESET}"
  echo -e "  ${GREEN}│${RESET}      ${DIM}Status   :${RESET} ${GREEN}[✓ TERHUBUNG]${RESET}                  ${GREEN}│${RESET}"
  echo -e "  ${GREEN}│${RESET}      ${DIM}Login    :${RESET} ${GREEN}Via Gmail${RESET}                      ${GREEN}│${RESET}"
  echo -e "  ${GREEN}│${RESET}      ${DIM}Akun     :${RESET} ${GREEN}Online${RESET}                         ${GREEN}│${RESET}"
  echo -e "  ${GREEN}│${RESET}      ${DIM}Izin     :${RESET} ${YELLOW}Kamera, Mic, Storage${RESET}           ${GREEN}│${RESET}"
  echo -e "  ${GREEN}└──────────────────────────────────────────────┘${RESET}"
  echo ""

  thin_div
  echo ""

  # ─ Account Info ─
  echo -e "  ${CYAN}${BOLD}▸ INFO AKUN${RESET}"
  echo ""
  local now=$(date '+%Y-%m-%d %H:%M:%S' 2>/dev/null || echo "2024-01-01 00:00:00")
  echo -e "  ${DIM}Last Login    :${RESET} ${GREEN}${now}${RESET}"
  echo -e "  ${DIM}Device        :${RESET} ${GREEN}Android 13${RESET}"
  echo -e "  ${DIM}IP Terakhir   :${RESET} ${YELLOW}114.79.xx.xxx${RESET}"
  echo -e "  ${DIM}2FA Status    :${RESET} ${RED}[DISABLED]${RESET}"
  echo -e "  ${DIM}Recovery      :${RESET} ${RED}Tidak Diatur${RESET}"
  echo ""

  thin_div
  echo ""
  divider '═' "$GREEN"
  echo ""
  pause
  show_main_menu
}

# ═══════════════════════════════════════════════════════════════
#   TOOL 3: AMBIL ALIH GMAIL
# ═══════════════════════════════════════════════════════════════
tool_takeover() {
  clear_screen
  divider '═' "$RED"
  echo -e "  ${RED}${BOLD}🎯  AMBIL ALIH GMAIL${RESET}  ${DIM}[ ACCOUNT TAKEOVER MODULE ]${RESET}"
  divider '═' "$RED"
  echo ""
  echo -e "  ${DIM}Target  :${RESET} ${RED}${TARGET_GMAIL}${RESET}"
  echo ""

  # Loading animation
  printf "  ${DIM}[${RED}!${DIM}]${RESET} Menghubungkan ke modul takeover"
  for i in {1..6}; do
    printf "${RED}.${RESET}"
    sleep 0.2
  done
  echo ""
  echo ""
  thin_div
  echo ""

  # SERVER OFF display
  echo -e "${RED}${BOLD}"
  center "╔══════════════════════════════════════════╗"
  center "║                                          ║"
  center "║            🚫  SERVER OFF  🚫            ║"
  center "║                                          ║"
  center "╚══════════════════════════════════════════╝"
  echo -e "${RESET}"
  echo ""

  echo -e "${RED}"
  center "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
  center "   GMAIL TERKUNCI PERMANEN"
  center "   MODUL TIDAK DAPAT DIAKSES"
  center "   KONEKSI KE SERVER GAGAL"
  center "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
  echo -e "${RESET}"
  echo ""
  thin_div
  echo ""

  echo -e "  ${RED}┌─────────────────────────────────────────────┐${RESET}"
  echo -e "  ${RED}│${RESET}  ${YELLOW}⚠  AKUN INI TELAH TERKUNCI PERMANEN${RESET}        ${RED}│${RESET}"
  echo -e "  ${RED}├─────────────────────────────────────────────┤${RESET}"
  echo -e "  ${RED}│${RESET}  Untuk informasi lebih lanjut:               ${RED}│${RESET}"
  echo -e "  ${RED}│${RESET}  📩  Hubungi Pihak Tools                     ${RED}│${RESET}"
  echo -e "  ${RED}│${RESET}  👤  Author  :  ${WHITE}Fendipendol${RESET}                  ${RED}│${RESET}"
  echo -e "  ${RED}│${RESET}  🔧  Tools   :  ${GREEN}MasJawa Hacking Tools${RESET}        ${RED}│${RESET}"
  echo -e "  ${RED}│${RESET}  🌐  Versi   :  ${WHITE}2.0${RESET}                          ${RED}│${RESET}"
  echo -e "  ${RED}└─────────────────────────────────────────────┘${RESET}"
  echo ""
  divider '═' "$RED"
  echo ""
  pause
  show_main_menu
}

# ═══════════════════════════════════════════════════════════════
#   TOOL 4: KUNCI GMAIL
# ═══════════════════════════════════════════════════════════════
tool_kunci() {
  clear_screen
  divider '═' "$YELLOW"
  echo -e "  ${YELLOW}${BOLD}🔒  KUNCI GMAIL${RESET}  ${DIM}[ ACCOUNT LOCK MODULE ]${RESET}"
  divider '═' "$YELLOW"
  echo ""
  echo -e "  ${DIM}Target  :${RESET} ${YELLOW}${TARGET_GMAIL}${RESET}"
  echo ""
  thin_div
  echo ""
  echo -e "  ${YELLOW}[!] Proses penguncian Gmail akan dimulai...${RESET}"
  echo ""
  printf "  ${GREEN}▸ Lanjutkan? (y/n)  :${RESET} "
  read -r confirm

  if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo ""
    echo -e "  ${DIM}Proses dibatalkan.${RESET}"
    sleep 1
    show_main_menu
    return
  fi

  echo ""
  divider '─' "$YELLOW"
  echo ""
  echo -e "  ${YELLOW}[⚡] MEMULAI PROSES PENGUNCIAN GMAIL...${RESET}"
  echo -e "  ${DIM}Dalam Proses — Mohon Tunggu${RESET}"
  echo ""

  local kunci_stages=(
    "Menghubungkan ke server..."
    "Autentikasi bypass..."
    "Mengakses panel keamanan..."
    "Menonaktifkan 2FA..."
    "Mengunci sesi aktif..."
    "Memblokir akses recovery..."
    "Enkripsi password baru..."
    "Mengunci backup codes..."
    "Sinkronisasi database..."
    "Finalisasi penguncian..."
  )

  local total_stages=${#kunci_stages[@]}

  for (( i=0; i<total_stages; i++ )); do
    local stage_pct=$(( (i + 1) * 100 / total_stages ))

    printf "  ${DIM}[${YELLOW}→${DIM}]${RESET} ${DIM}${kunci_stages[$i]}${RESET}"
    sleep 0.3
    printf " ${YELLOW}✓${RESET}\n"

    # Progress bar per stage
    progress_bar $(( i + 1 )) $total_stages
    printf "\n"

    sleep 0.5
  done

  echo ""
  divider '═' "$YELLOW"
  echo -e "  ${YELLOW}${BOLD}"
  echo "  ╔════════════════════════════════════╗"
  echo "  ║    🔒  GMAIL BERHASIL DIKUNCI!    ║"
  echo "  ╚════════════════════════════════════╝"
  echo -e "${RESET}"
  echo -e "  ${DIM}Akun ${YELLOW}${TARGET_GMAIL}${DIM} telah berhasil dikunci.${RESET}"
  echo -e "  ${DIM}Pengguna tidak dapat mengakses akun tersebut.${RESET}"
  echo ""
  divider '═' "$YELLOW"
  echo ""
  pause
  show_main_menu
}

# ═══════════════════════════════════════════════════════════════
#   TOOL 5: PEMBERSIHAN DEVICE DARI VIRUS
# ═══════════════════════════════════════════════════════════════
tool_virus_cleaner() {
  # ── STEP 1: INPUT IP ──────────────────────────────────────────
  while true; do
    clear_screen
    divider '═' "$CYAN"
    echo -e "  ${CYAN}${BOLD}🛡  PEMBERSIHAN DEVICE DARI VIRUS${RESET}  ${DIM}[ SCANNER & CLEANER ]${RESET}"
    divider '═' "$CYAN"
    echo ""
    echo -e "  ${DIM}[ MASUKKAN IP ADDRESS TARGET DEVICE ]${RESET}"
    echo ""
    thin_div
    echo ""
    printf "  ${DIM}[${CYAN}?${DIM}]${RESET} Masukkan IP Address target ${DIM}(contoh: 192.168.1.1)${RESET}\n"
    echo ""
    printf "  ${CYAN}▸ IP Address :${RESET} "
    read -r TARGET_IP

    if [[ -z "$TARGET_IP" ]]; then
      echo ""
      echo -e "  ${RED}[!] IP Address tidak boleh kosong!${RESET}"
      sleep 1.5
      continue
    fi

    # Validate IP format
    if [[ "$TARGET_IP" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
      IFS='.' read -ra parts <<< "$TARGET_IP"
      valid=true
      for part in "${parts[@]}"; do
        if (( part < 0 || part > 255 )); then
          valid=false
          break
        fi
      done

      if $valid; then
        echo ""
        printf "  ${DIM}[${CYAN}+${DIM}]${RESET} Menghubungkan ke device"
        for i in {1..6}; do
          printf "${CYAN}.${RESET}"
          sleep 0.2
        done
        echo -e " ${CYAN}✓${RESET}"
        echo ""
        echo -e "  ${CYAN}[✓] DEVICE DITEMUKAN — IP: ${WHITE}${TARGET_IP}${RESET}"
        echo ""
        sleep 0.5
        break
      fi
    fi

    echo ""
    echo -e "  ${RED}[✗] Format IP tidak valid! Contoh: 192.168.1.1${RESET}"
    sleep 2
  done

  # ── STEP 2: DEVICE SPECS ──────────────────────────────────────
  clear_screen
  divider '═' "$CYAN"
  echo -e "  ${CYAN}${BOLD}📱  DEVICE TERDETEKSI${RESET}"
  divider '═' "$CYAN"
  echo ""

  echo -e "  ${CYAN}┌──────────────────────────────────────────────────┐${RESET}"
  echo -e "  ${CYAN}│${RESET}  ${DIM}▸ DEVICE SPECIFICATIONS${RESET}                          ${CYAN}│${RESET}"
  echo -e "  ${CYAN}├──────────────────────────────────────────────────┤${RESET}"
  echo -e "  ${CYAN}│${RESET}  ${DIM}Brand / Model  :${RESET} ${CYAN}Redmi Note 13 Pro${RESET}             ${CYAN}│${RESET}"
  echo -e "  ${CYAN}│${RESET}  ${DIM}CPU            :${RESET} ${CYAN}Helio G99-ULTRA${RESET}               ${CYAN}│${RESET}"
  echo -e "  ${CYAN}│${RESET}  ${DIM}IMEI           :${RESET} ${CYAN}863357061930020${RESET}               ${CYAN}│${RESET}"
  echo -e "  ${CYAN}│${RESET}  ${DIM}IP Address     :${RESET} ${CYAN}${TARGET_IP}${RESET}"
  printf "  ${CYAN}│${RESET}  ${DIM}OS             :${RESET} ${CYAN}MIUI 14 / Android 13${RESET}          ${CYAN}│${RESET}\n"
  echo -e "  ${CYAN}│${RESET}  ${DIM}Status         :${RESET} ${CYAN}[✓ TERHUBUNG]${RESET}                 ${CYAN}│${RESET}"
  echo -e "  ${CYAN}└──────────────────────────────────────────────────┘${RESET}"
  echo ""
  thin_div
  echo ""
  printf "  ${GREEN}▸ Mulai scan virus? (y/n)  :${RESET} "
  read -r confirm_scan

  if [[ "$confirm_scan" != "y" && "$confirm_scan" != "Y" ]]; then
    echo ""
    echo -e "  ${DIM}Dibatalkan.${RESET}"
    sleep 1
    show_main_menu
    return
  fi

  # ── STEP 3: SCAN VIRUS ────────────────────────────────────────
  clear_screen
  divider '═' "$CYAN"
  echo -e "  ${CYAN}${BOLD}🔍  SCANNING VIRUS — ${TARGET_IP}${RESET}"
  divider '═' "$CYAN"
  echo ""
  echo -e "  ${DIM}Device  :${RESET} ${CYAN}Redmi Note 13 Pro${RESET}  ${DIM}|${RESET}  ${CYAN}Helio G99-ULTRA${RESET}"
  echo ""

  local scan_files=(
    "/system/app/SystemUI.apk"
    "/data/app/com.android.vending"
    "/sdcard/DCIM/Camera/"
    "/data/data/com.whatsapp/"
    "/system/lib/libdvm.so"
    "/data/app/com.tiktok.android/"
    "/sdcard/Android/data/"
    "/data/data/com.google.android.gms/"
    "/system/framework/framework.jar"
    "/data/app/com.xiaomi.mipush/"
    "/sdcard/Download/"
    "/data/data/com.android.chrome/"
    "/system/bin/init"
    "/data/app/com.facebook.katana/"
    "/sdcard/WhatsApp/Media/"
  )

  local scan_logs=(
    "Menghubungkan ke device via IP..."
    "Akses root diperoleh..."
    "Memulai deep scan sistem..."
    "Scanning /system/app/ ..."
    "Scanning /data/app/ ..."
    "Scanning /sdcard/ ..."
    "Scanning memory aktif..."
    "Menganalisis proses berjalan..."
    "Memeriksa file tersembunyi..."
    "Memeriksa registri sistem..."
    "Menganalisis network traffic..."
    "Memeriksa startup apps..."
    "Scan selesai."
  )

  local SCAN_TOTAL=52
  local scan_log_interval=$(( SCAN_TOTAL / ${#scan_logs[@]} ))
  local scan_log_idx=0
  local scan_file_idx=0

  echo -e "  ${CYAN}[⚡] MEMULAI SCANNING DEVICE...${RESET}"
  echo ""

  for (( s=1; s<=SCAN_TOTAL; s++ )); do
    # File being scanned
    local cur_file="${scan_files[$((scan_file_idx % ${#scan_files[@]}))]}"
    scan_file_idx=$(( scan_file_idx + 1 ))

    # Print log
    if (( s % scan_log_interval == 0 )) && [ $scan_log_idx -lt ${#scan_logs[@]} ]; then
      echo -e "  ${DIM}[${CYAN}+${DIM}]${RESET} ${DIM}${scan_logs[$scan_log_idx]}${RESET} ${CYAN}✓${RESET}"
      scan_log_idx=$(( scan_log_idx + 1 ))
    fi

    # Progress
    progress_bar $s $SCAN_TOTAL
    printf "  ${DIM}  📂 ${cur_file}${RESET}"
    printf "\033[K"

    sleep 0.12
  done

  echo ""
  echo ""

  # Print remaining logs
  while [ $scan_log_idx -lt ${#scan_logs[@]} ]; do
    echo -e "  ${DIM}[${CYAN}+${DIM}]${RESET} ${DIM}${scan_logs[$scan_log_idx]}${RESET} ${CYAN}✓${RESET}"
    scan_log_idx=$(( scan_log_idx + 1 ))
  done

  echo ""
  divider '─' "$RED"
  echo ""
  echo -e "  ${RED}${BOLD}⚠  VIRUS TERDETEKSI!${RESET}"
  echo ""
  echo -e "  ${RED}┌──────────────────────────────────────────────────┐${RESET}"
  echo -e "  ${RED}│${RESET}  ${RED}● AKTIF${RESET}   Trojan.AndroidOS.Hiddad              ${RED}│${RESET}"
  echo -e "  ${RED}│${RESET}  ${RED}● AKTIF${RESET}   Spyware.Agent.GenB                   ${RED}│${RESET}"
  echo -e "  ${RED}│${RESET}  ${RED}● AKTIF${RESET}   Adware.MobiDash                      ${RED}│${RESET}"
  echo -e "  ${RED}│${RESET}  ${YELLOW}● SUSPEK${RESET}  RiskTool.SMSSend                     ${RED}│${RESET}"
  echo -e "  ${RED}│${RESET}  ${RED}● AKTIF${RESET}   Backdoor.AndroidOS.Marcher            ${RED}│${RESET}"
  echo -e "  ${RED}└──────────────────────────────────────────────────┘${RESET}"
  echo ""
  echo -e "  ${RED}Total Ancaman  :${RESET} ${RED}${BOLD}5 VIRUS DITEMUKAN${RESET}"
  echo ""
  thin_div
  echo ""
  printf "  ${GREEN}▸ Mulai pembersihan virus? (y/n)  :${RESET} "
  read -r confirm_clean

  if [[ "$confirm_clean" != "y" && "$confirm_clean" != "Y" ]]; then
    echo ""
    echo -e "  ${DIM}Dibatalkan.${RESET}"
    sleep 1
    show_main_menu
    return
  fi

  # ── STEP 4: CLEAN VIRUS ───────────────────────────────────────
  clear_screen
  divider '═' "$GREEN"
  echo -e "  ${GREEN}${BOLD}🧹  PEMBERSIHAN VIRUS DIMULAI...${RESET}"
  divider '═' "$GREEN"
  echo ""
  echo -e "  ${DIM}Device  :${RESET} ${CYAN}Redmi Note 13 Pro${RESET}  |  ${DIM}IP:${RESET} ${CYAN}${TARGET_IP}${RESET}"
  echo ""

  local clean_stages=(
    "MENGISOLASI TROJAN..."
    "MENGHAPUS SPYWARE..."
    "MEMBERSIHKAN ADWARE..."
    "MENGHAPUS RISKTOOL..."
    "MENGHAPUS BACKDOOR..."
    "MEMBERSIHKAN SISA FILE..."
    "MEMPERBARUI DATABASE..."
    "FINALISASI PEMBERSIHAN..."
  )

  local clean_logs=(
    "Mengisolasi Trojan.AndroidOS.Hiddad..."
    "Menghapus file Trojan dari /data/app/ ..."
    "Trojan.AndroidOS.Hiddad → DIHAPUS ✓"
    "Mengisolasi Spyware.Agent.GenB..."
    "Memutus koneksi spyware ke server remote..."
    "Spyware.Agent.GenB → DIHAPUS ✓"
    "Mengisolasi Adware.MobiDash..."
    "Membersihkan cache adware..."
    "Adware.MobiDash → DIHAPUS ✓"
    "Mengisolasi RiskTool.SMSSend..."
    "RiskTool.SMSSend → DIHAPUS ✓"
    "Mengisolasi Backdoor.AndroidOS.Marcher..."
    "Memblokir backdoor port..."
    "Backdoor.AndroidOS.Marcher → DIHAPUS ✓"
    "Membersihkan sisa file virus..."
    "Memperbarui signature database..."
    "Melakukan restart layanan sistem..."
  )

  local CLEAN_TOTAL=${#clean_stages[@]}
  local clean_log_idx=0

  for (( c=0; c<CLEAN_TOTAL; c++ )); do
    echo -e "  ${DIM}[${GREEN}→${DIM}]${RESET} ${CYAN}${clean_stages[$c]}${RESET}"

    # Print 2 logs per stage
    for (( l=0; l<2 && clean_log_idx<${#clean_logs[@]}; l++ )); do
      local log_line="${clean_logs[$clean_log_idx]}"
      if [[ "$log_line" == *"DIHAPUS ✓"* ]]; then
        echo -e "       ${GREEN}${log_line}${RESET}"
      else
        echo -e "       ${DIM}${log_line}${RESET}"
      fi
      clean_log_idx=$(( clean_log_idx + 1 ))
    done

    # Progress bar
    progress_bar $(( c + 1 )) $CLEAN_TOTAL
    printf "\n"
    echo ""
    sleep 0.85
  done

  # Print remaining logs
  while [ $clean_log_idx -lt ${#clean_logs[@]} ]; do
    echo -e "  ${GREEN}${clean_logs[$clean_log_idx]}${RESET}"
    clean_log_idx=$(( clean_log_idx + 1 ))
    sleep 0.2
  done

  echo ""
  divider '═' "$GREEN"
  echo -e "  ${GREEN}${BOLD}"
  echo "  ╔══════════════════════════════════════════════╗"
  echo "  ║                                              ║"
  echo "  ║   ✅  DEVICE BERSIH — SEMUA VIRUS DIHAPUS!  ║"
  echo "  ║                                              ║"
  echo "  ╚══════════════════════════════════════════════╝"
  echo -e "${RESET}"
  echo ""
  echo -e "  ${DIM}Virus Ditemukan    :${RESET} ${RED}5${RESET}"
  echo -e "  ${DIM}Virus Dibersihkan  :${RESET} ${GREEN}5${RESET}"
  echo -e "  ${DIM}Status Device      :${RESET} ${GREEN}[AMAN ✓]${RESET}"
  echo -e "  ${DIM}Device             :${RESET} ${CYAN}Redmi Note 13 Pro — ${TARGET_IP}${RESET}"
  echo ""
  divider '═' "$GREEN"
  echo ""
  pause
  show_main_menu
}

# ═══════════════════════════════════════════════════════════════
#   MAIN FLOW
# ═══════════════════════════════════════════════════════════════
main() {
  # 1. Welcome Animation
  show_welcome

  # 2. Gmail ASCII Logo + Author
  show_gmail_logo

  # 3. Main loop
  while true; do
    # Input Gmail
    input_gmail

    # Menu loop
    while true; do
      show_main_menu
      result=$?
      if [ $result -eq 1 ]; then
        break  # Back to gmail input
      fi
    done
  done
}

# Run
main
