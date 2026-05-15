#!/bin/bash

# ============================================================
#   Anon's Black Arch Toolkit
#   c0d3d By @non G00nz
# ============================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
WHITE='\033[1;37m'
BLUE='\033[0;34m'
NC='\033[0m'

# ============================================================
# BANNER
# ============================================================
banner() {
    clear
    echo -e "${RED}"
    echo "  █████╗ ███╗   ██╗ ██████╗ ███╗   ██╗███████╗"
    echo " ██╔══██╗████╗  ██║██╔═══██╗████╗  ██║██╔════╝"
    echo " ███████║██╔██╗ ██║██║   ██║██╔██╗ ██║███████╗"
    echo " ██╔══██║██║╚██╗██║██║   ██║██║╚██╗██║╚════██║"
    echo " ██║  ██║██║ ╚████║╚██████╔╝██║ ╚████║███████║"
    echo " ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝"
    echo -e "${CYAN}"
    echo " ██████╗ ██╗      █████╗  ██████╗██╗  ██╗     █████╗ ██████╗  ██████╗██╗  ██╗"
    echo " ██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝    ██╔══██╗██╔══██╗██╔════╝██║  ██║"
    echo " ██████╔╝██║     ███████║██║     █████╔╝     ███████║██████╔╝██║     ███████║"
    echo " ██╔══██╗██║     ██╔══██║██║     ██╔═██╗     ██╔══██║██╔══██╗██║     ██╔══██║"
    echo " ██████╔╝███████╗██║  ██║╚██████╗██║  ██╗    ██║  ██║██║  ██║╚██████╗██║  ██║"
    echo " ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝"
    echo -e "${WHITE}"
    echo " ████████╗ ██████╗  ██████╗ ██╗      ██╗  ██╗██╗████████╗"
    echo " ╚══██╔══╝██╔═══██╗██╔═══██╗██║      ██║ ██╔╝██║╚══██╔══╝"
    echo "    ██║   ██║   ██║██║   ██║██║      █████╔╝ ██║   ██║   "
    echo "    ██║   ██║   ██║██║   ██║██║      ██╔═██╗ ██║   ██║   "
    echo "    ██║   ╚██████╔╝╚██████╔╝███████╗ ██║  ██╗██║   ██║   "
    echo "    ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝ ╚═╝  ╚═╝╚═╝   ╚═╝   "
    echo -e "${NC}"
    echo -e "${PURPLE}          ╔══════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}          ║          c0d3d By @non G00nz             ║${NC}"
    echo -e "${PURPLE}          ╚══════════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}     [!] For authorized penetration testing use only [!]${NC}"
    echo ""
}

# ============================================================
# ROOT CHECK
# ============================================================
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}[!] This script must be run as root (sudo ./anons_blackarch_toolkit.sh)${NC}"
        exit 1
    fi
}

# ============================================================
# DEPENDENCY CHECK
# ============================================================
check_dep() {
    command -v "$1" &>/dev/null
}

# ============================================================
# TOOL LISTS BY CATEGORY
# ============================================================

RECON_TOOLS=(
    nmap masscan dmitry recon-ng theharvester maltego shodan fierce dnsrecon
    whois dnsenum sublist3r amass enum4linux nbtscan unicornscan netdiscover
    arp-scan p0f xprobe2 smbmap onesixtyone snmpwalk dnswalk dnsmap
)

EXPLOITATION_TOOLS=(
    metasploit exploitdb sqlmap beef-xss armitage veil-evasion shellter
    routersploit commix ysoserial jexboss struts-pwn heartbleed-scanner
    ms17-010-scanner eternalblue-doublepulsar-metasploit empire
)

PASSWORD_TOOLS=(
    hashcat john hydra medusa ncrack ophcrack rainbowcrack chntpw samdump2
    crunch wordlistctl cewl rsmangler pydictor mentalist pack
)

WIRELESS_TOOLS=(
    aircrack-ng airbase-ng airodump-ng aireplay-ng airmon-ng wifite reaver
    pixiewps bully cowpatty hashcatch wifiphisher fluxion kismet wifijammer
    mdk3 mdk4 wifi-honey hostapd-wpe eaphammer
)

WEBAPPS_TOOLS=(
    burpsuite nikto wpscan joomscan droopescan dirbuster gobuster dirb feroxbuster
    whatweb wafw00f xsstrike sqlmap commix ffuf arjun smuggler ssrfmap
    corscanner dalfox jwt_tool paddingoracle padbuster
)

FORENSICS_TOOLS=(
    autopsy volatility binwalk foremost scalpel bulk-extractor exiftool
    testdisk photorec hashdeep dc3dd dcfldd guymager ewftools afftools
    vinetto pdfid pdf-parser peepdf oletools oledump
)

REVERSE_ENGINEERING=(
    radare2 ghidra gdb ida-free pwndbg peda r2ghidra apktool dex2jar
    jadx jd-gui bytecode-viewer androguard frida objection
)

SNIFFING_TOOLS=(
    wireshark tcpdump ettercap bettercap mitmproxy dsniff arpspoof responder
    net-creds pcredz p0f sslstrip xerosploit yersinia netsniff-ng
)

SOCIAL_ENGINEERING=(
    setoolkit gophish evilginx2 king-phisher phishing-frenzy
    blackeye zphisher saycheese nexphisher
)

CRYPTO_TOOLS=(
    hashid hash-identifier pkcrack fcrackzip rarcrack xortool rsatool
    msieve yafu cado-nfs
)

STEGO_TOOLS=(
    steghide stegsolve stegosuite outguess steganabara openstego
    snow coagula mp3stego
)

VULN_SCANNERS=(
    openvas nessus nuclei jaeles osv-scanner trivy grype
    vulscan nmap-vulners legion sparta
)

NETWORK_TOOLS=(
    netcat ncat socat proxychains tor ncrack hping3 scapy impacket
    crackmapexec evil-winrm smbclient rpcclient ldapsearch enum4linux-ng
)

EXPLOITATION_FRAMEWORKS=(
    metasploit cobalt-strike powershell-empire covenant merlin
    sliver havoc brute-ratel
)

MOBILE_TOOLS=(
    apktool jadx androguard frida objection drozer qark mobsf
    apkleaks apksigner
)

CLOUD_TOOLS=(
    pacu prowler scout-suite cloudmapper s3scanner bucket-finder
    aws-cli gcloud azure-cli
)

CONTAINER_TOOLS=(
    trivy grype docker-bench-security clair anchore dive
    kube-bench kube-hunter
)

OSINT_TOOLS=(
    maltego theharvester recon-ng shodan creepy metagoofil
    tinfoleak tweetdeck userrecon sherlock holehe
)

ALL_TOOLS=(
    "${RECON_TOOLS[@]}" "${EXPLOITATION_TOOLS[@]}" "${PASSWORD_TOOLS[@]}"
    "${WIRELESS_TOOLS[@]}" "${WEBAPPS_TOOLS[@]}" "${FORENSICS_TOOLS[@]}"
    "${REVERSE_ENGINEERING[@]}" "${SNIFFING_TOOLS[@]}" "${SOCIAL_ENGINEERING[@]}"
    "${CRYPTO_TOOLS[@]}" "${STEGO_TOOLS[@]}" "${VULN_SCANNERS[@]}"
    "${NETWORK_TOOLS[@]}" "${EXPLOITATION_FRAMEWORKS[@]}" "${MOBILE_TOOLS[@]}"
    "${CLOUD_TOOLS[@]}" "${CONTAINER_TOOLS[@]}" "${OSINT_TOOLS[@]}"
)

# ============================================================
# INSTALL FUNCTIONS
# ============================================================

detect_pkg_manager() {
    if check_dep apt-get; then
        PKG="apt-get install -y"
        UPDATE="apt-get update -y"
    elif check_dep pacman; then
        PKG="pacman -S --noconfirm"
        UPDATE="pacman -Sy"
    elif check_dep dnf; then
        PKG="dnf install -y"
        UPDATE="dnf check-update"
    else
        echo -e "${RED}[!] No supported package manager found.${NC}"
        exit 1
    fi
}

install_blackarch_repo() {
    if ! grep -q "blackarch" /etc/pacman.conf 2>/dev/null; then
        echo -e "${CYAN}[*] Adding BlackArch repository...${NC}"
        curl -O https://blackarch.org/strap.sh
        chmod +x strap.sh
        ./strap.sh
        rm -f strap.sh
        echo -e "${GREEN}[+] BlackArch repo added.${NC}"
    else
        echo -e "${YELLOW}[!] BlackArch repo already configured.${NC}"
    fi
}

install_tool() {
    local tool="$1"
    echo -e "${CYAN}[*] Installing ${tool}...${NC}"
    $PKG "$tool" &>/dev/null && \
        echo -e "${GREEN}[+] ${tool} installed.${NC}" || \
        echo -e "${RED}[-] Failed to install ${tool} (may not be in repo or name differs).${NC}"
}

install_category() {
    local -n tools_ref=$1
    local label="$2"
    detect_pkg_manager
    $UPDATE &>/dev/null
    echo -e "${CYAN}[*] Installing ${label} tools...${NC}"
    for tool in "${tools_ref[@]}"; do
        install_tool "$tool"
    done
    echo -e "${GREEN}[+] ${label} installation complete.${NC}"
    read -rp "Press [Enter] to continue..." _
}

install_all_tools() {
    detect_pkg_manager
    if check_dep pacman; then
        install_blackarch_repo
        echo -e "${CYAN}[*] Installing full BlackArch toolset via pacman...${NC}"
        pacman -S --noconfirm blackarch
        echo -e "${GREEN}[+] Full BlackArch toolset installed.${NC}"
    else
        echo -e "${YELLOW}[!] Not on Arch. Installing available tools via apt...${NC}"
        $UPDATE &>/dev/null
        for tool in "${ALL_TOOLS[@]}"; do
            install_tool "$tool"
        done
        echo -e "${GREEN}[+] All available tools installed.${NC}"
    fi
    read -rp "Press [Enter] to continue..." _
}

# ============================================================
# LAUNCH FUNCTIONS
# ============================================================

launch_tool() {
    local tool="$1"
    if check_dep "$tool"; then
        echo -e "${GREEN}[+] Launching ${tool}...${NC}"
        sleep 1
        "$tool"
    else
        echo -e "${RED}[!] ${tool} not found. Install it first.${NC}"
        sleep 2
    fi
}

launch_tool_bg() {
    local tool="$1"
    if check_dep "$tool"; then
        echo -e "${GREEN}[+] Launching ${tool} in background...${NC}"
        "$tool" &
    else
        echo -e "${RED}[!] ${tool} not found. Install it first.${NC}"
        sleep 2
    fi
}

run_all_tools() {
    echo -e "${YELLOW}[!] Attempting to launch all installed tools...${NC}"
    echo -e "${YELLOW}[!] GUI tools will open in background. CLI tools will open in sequence.${NC}"
    sleep 2
    for tool in "${ALL_TOOLS[@]}"; do
        if check_dep "$tool"; then
            echo -e "${GREEN}[+] Launching: ${tool}${NC}"
            "$tool" &>/dev/null &
            sleep 0.3
        else
            echo -e "${RED}[-] Not found: ${tool}${NC}"
        fi
    done
    echo -e "${GREEN}[+] All available tools launched.${NC}"
    read -rp "Press [Enter] to continue..." _
}

# ============================================================
# STATUS CHECK
# ============================================================

check_status() {
    banner
    echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
    echo -e "${WHITE}  ║           TOOL STATUS CHECK              ║${NC}"
    echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
    echo ""

    local categories=(
        "RECON" "EXPLOITATION" "PASSWORDS" "WIRELESS" "WEBAPPS"
        "FORENSICS" "REVERSE_ENG" "SNIFFING" "SOCIAL_ENG" "CRYPTO"
        "STEGO" "VULN_SCAN" "NETWORK" "EXPLOIT_FW" "MOBILE"
        "CLOUD" "CONTAINER" "OSINT"
    )

    declare -A cat_map
    cat_map["RECON"]="RECON_TOOLS[@]"
    cat_map["EXPLOITATION"]="EXPLOITATION_TOOLS[@]"
    cat_map["PASSWORDS"]="PASSWORD_TOOLS[@]"
    cat_map["WIRELESS"]="WIRELESS_TOOLS[@]"
    cat_map["WEBAPPS"]="WEBAPPS_TOOLS[@]"
    cat_map["FORENSICS"]="FORENSICS_TOOLS[@]"
    cat_map["REVERSE_ENG"]="REVERSE_ENGINEERING[@]"
    cat_map["SNIFFING"]="SNIFFING_TOOLS[@]"
    cat_map["SOCIAL_ENG"]="SOCIAL_ENGINEERING[@]"
    cat_map["CRYPTO"]="CRYPTO_TOOLS[@]"
    cat_map["STEGO"]="STEGO_TOOLS[@]"
    cat_map["VULN_SCAN"]="VULN_SCANNERS[@]"
    cat_map["NETWORK"]="NETWORK_TOOLS[@]"
    cat_map["EXPLOIT_FW"]="EXPLOITATION_FRAMEWORKS[@]"
    cat_map["MOBILE"]="MOBILE_TOOLS[@]"
    cat_map["CLOUD"]="CLOUD_TOOLS[@]"
    cat_map["CONTAINER"]="CONTAINER_TOOLS[@]"
    cat_map["OSINT"]="OSINT_TOOLS[@]"

    for cat in "${categories[@]}"; do
        local ref="${cat_map[$cat]}"
        local installed=0
        local missing=0
        local tools=("${!ref}")
        for tool in "${tools[@]}"; do
            check_dep "$tool" && ((installed++)) || ((missing++))
        done
        printf "  %-15s : ${GREEN}%3d installed${NC}  |  ${RED}%3d missing${NC}\n" "$cat" "$installed" "$missing"
    done

    echo ""
    read -rp "Press [Enter] to return to menu..." _
}

# ============================================================
# RECON MENU
# ============================================================

recon_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║         RECONNAISSANCE TOOLS             ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  nmap              - Network scanner"
        echo -e "  ${CYAN}[2]${NC}  masscan           - Mass IP port scanner"
        echo -e "  ${CYAN}[3]${NC}  dmitry            - Deepmagic info gatherer"
        echo -e "  ${CYAN}[4]${NC}  recon-ng          - Web recon framework"
        echo -e "  ${CYAN}[5]${NC}  theharvester      - Email/DNS/IP harvester"
        echo -e "  ${CYAN}[6]${NC}  maltego           - OSINT/link analysis"
        echo -e "  ${CYAN}[7]${NC}  fierce            - DNS scanner"
        echo -e "  ${CYAN}[8]${NC}  dnsrecon          - DNS enumeration"
        echo -e "  ${CYAN}[9]${NC}  amass             - Attack surface mapper"
        echo -e "  ${CYAN}[10]${NC} sublist3r         - Subdomain enumerator"
        echo -e "  ${CYAN}[11]${NC} enum4linux        - SMB enumeration"
        echo -e "  ${CYAN}[12]${NC} netdiscover       - ARP recon"
        echo -e "  ${CYAN}[13]${NC} arp-scan          - ARP scanner"
        echo -e "  ${CYAN}[14]${NC} dnsenum           - DNS enumerator"
        echo -e "  ${CYAN}[15]${NC} smbmap            - SMB share mapper"
        echo -e "  ${CYAN}[16]${NC} onesixtyone       - SNMP scanner"
        echo -e "  ${CYAN}[17]${NC} unicornscan       - Async network scanner"
        echo -e "  ${CYAN}[18]${NC} p0f               - Passive OS fingerprint"
        echo -e "  ${CYAN}[19]${NC} nbtscan           - NetBIOS scanner"
        echo -e "  ${CYAN}[20]${NC} Install All Recon Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool nmap ;;
            2)  launch_tool masscan ;;
            3)  launch_tool dmitry ;;
            4)  launch_tool recon-ng ;;
            5)  launch_tool theHarvester ;;
            6)  launch_tool_bg maltego ;;
            7)  launch_tool fierce ;;
            8)  launch_tool dnsrecon ;;
            9)  launch_tool amass ;;
            10) launch_tool sublist3r ;;
            11) launch_tool enum4linux ;;
            12) launch_tool netdiscover ;;
            13) launch_tool arp-scan ;;
            14) launch_tool dnsenum ;;
            15) launch_tool smbmap ;;
            16) launch_tool onesixtyone ;;
            17) launch_tool unicornscan ;;
            18) launch_tool p0f ;;
            19) launch_tool nbtscan ;;
            20) install_category RECON_TOOLS "Recon" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# EXPLOITATION MENU
# ============================================================

exploitation_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║           EXPLOITATION TOOLS             ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  metasploit        - Exploit framework"
        echo -e "  ${CYAN}[2]${NC}  sqlmap            - SQL injection tool"
        echo -e "  ${CYAN}[3]${NC}  beef-xss          - Browser exploit framework"
        echo -e "  ${CYAN}[4]${NC}  armitage          - Metasploit GUI"
        echo -e "  ${CYAN}[5]${NC}  routersploit      - Router exploitation"
        echo -e "  ${CYAN}[6]${NC}  commix            - Command injection"
        echo -e "  ${CYAN}[7]${NC}  veil-evasion      - AV evasion framework"
        echo -e "  ${CYAN}[8]${NC}  shellter          - PE backdoor injector"
        echo -e "  ${CYAN}[9]${NC}  empire            - PowerShell post-exploit"
        echo -e "  ${CYAN}[10]${NC} exploitdb         - Exploit database"
        echo -e "  ${CYAN}[11]${NC} Install All Exploitation Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool msfconsole ;;
            2)  launch_tool sqlmap ;;
            3)  launch_tool beef-xss ;;
            4)  launch_tool armitage ;;
            5)  launch_tool routersploit ;;
            6)  launch_tool commix ;;
            7)  launch_tool veil ;;
            8)  launch_tool shellter ;;
            9)  launch_tool powershell-empire ;;
            10) launch_tool searchsploit ;;
            11) install_category EXPLOITATION_TOOLS "Exploitation" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# PASSWORD MENU
# ============================================================

password_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║          PASSWORD ATTACK TOOLS           ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  hashcat           - GPU hash cracker"
        echo -e "  ${CYAN}[2]${NC}  john              - John the Ripper"
        echo -e "  ${CYAN}[3]${NC}  hydra             - Network brute forcer"
        echo -e "  ${CYAN}[4]${NC}  medusa            - Parallel login brute forcer"
        echo -e "  ${CYAN}[5]${NC}  ncrack            - Network auth cracker"
        echo -e "  ${CYAN}[6]${NC}  ophcrack          - Windows password cracker"
        echo -e "  ${CYAN}[7]${NC}  crunch            - Wordlist generator"
        echo -e "  ${CYAN}[8]${NC}  cewl              - Custom wordlist generator"
        echo -e "  ${CYAN}[9]${NC}  rainbowcrack      - Rainbow table cracker"
        echo -e "  ${CYAN}[10]${NC} chntpw            - Windows SAM password reset"
        echo -e "  ${CYAN}[11]${NC} samdump2          - Windows SAM dumper"
        echo -e "  ${CYAN}[12]${NC} Install All Password Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool hashcat ;;
            2)  launch_tool john ;;
            3)  launch_tool hydra ;;
            4)  launch_tool medusa ;;
            5)  launch_tool ncrack ;;
            6)  launch_tool_bg ophcrack ;;
            7)  launch_tool crunch ;;
            8)  launch_tool cewl ;;
            9)  launch_tool rainbowcrack ;;
            10) launch_tool chntpw ;;
            11) launch_tool samdump2 ;;
            12) install_category PASSWORD_TOOLS "Password" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# WIRELESS MENU
# ============================================================

wireless_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║            WIRELESS TOOLS                ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  aircrack-ng       - WEP/WPA cracker"
        echo -e "  ${CYAN}[2]${NC}  airodump-ng       - Packet capture"
        echo -e "  ${CYAN}[3]${NC}  aireplay-ng       - Packet injection"
        echo -e "  ${CYAN}[4]${NC}  airmon-ng         - Monitor mode manager"
        echo -e "  ${CYAN}[5]${NC}  wifite            - Automated wireless attack"
        echo -e "  ${CYAN}[6]${NC}  reaver            - WPS brute force"
        echo -e "  ${CYAN}[7]${NC}  pixiewps          - WPS offline attack"
        echo -e "  ${CYAN}[8]${NC}  bully             - WPS brute force"
        echo -e "  ${CYAN}[9]${NC}  wifiphisher       - WiFi phishing"
        echo -e "  ${CYAN}[10]${NC} kismet            - Wireless detector"
        echo -e "  ${CYAN}[11]${NC} fluxion           - MITM WPA attack"
        echo -e "  ${CYAN}[12]${NC} mdk4              - WiFi DoS tool"
        echo -e "  ${CYAN}[13]${NC} eaphammer         - EAP attack framework"
        echo -e "  ${CYAN}[14]${NC} cowpatty          - WPA PSK cracker"
        echo -e "  ${CYAN}[15]${NC} Install All Wireless Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool aircrack-ng ;;
            2)  launch_tool airodump-ng ;;
            3)  launch_tool aireplay-ng ;;
            4)  launch_tool airmon-ng ;;
            5)  launch_tool wifite ;;
            6)  launch_tool reaver ;;
            7)  launch_tool pixiewps ;;
            8)  launch_tool bully ;;
            9)  launch_tool wifiphisher ;;
            10) launch_tool kismet ;;
            11) launch_tool fluxion ;;
            12) launch_tool mdk4 ;;
            13) launch_tool eaphammer ;;
            14) launch_tool cowpatty ;;
            15) install_category WIRELESS_TOOLS "Wireless" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# WEB APP MENU
# ============================================================

webapp_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║           WEB APPLICATION TOOLS          ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  burpsuite         - Web app proxy/scanner"
        echo -e "  ${CYAN}[2]${NC}  nikto             - Web vulnerability scanner"
        echo -e "  ${CYAN}[3]${NC}  wpscan            - WordPress scanner"
        echo -e "  ${CYAN}[4]${NC}  joomscan          - Joomla scanner"
        echo -e "  ${CYAN}[5]${NC}  gobuster          - Directory/DNS brute forcer"
        echo -e "  ${CYAN}[6]${NC}  dirb              - Web content scanner"
        echo -e "  ${CYAN}[7]${NC}  dirbuster         - Directory brute forcer GUI"
        echo -e "  ${CYAN}[8]${NC}  whatweb           - Web fingerprinter"
        echo -e "  ${CYAN}[9]${NC}  wafw00f           - WAF detector"
        echo -e "  ${CYAN}[10]${NC} xsstrike          - XSS scanner"
        echo -e "  ${CYAN}[11]${NC} sqlmap            - SQL injection"
        echo -e "  ${CYAN}[12]${NC} ffuf              - Web fuzzer"
        echo -e "  ${CYAN}[13]${NC} dalfox            - XSS parameter finder"
        echo -e "  ${CYAN}[14]${NC} arjun             - HTTP parameter finder"
        echo -e "  ${CYAN}[15]${NC} feroxbuster       - Fast content discovery"
        echo -e "  ${CYAN}[16]${NC} Install All WebApp Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool_bg burpsuite ;;
            2)  launch_tool nikto ;;
            3)  launch_tool wpscan ;;
            4)  launch_tool joomscan ;;
            5)  launch_tool gobuster ;;
            6)  launch_tool dirb ;;
            7)  launch_tool_bg dirbuster ;;
            8)  launch_tool whatweb ;;
            9)  launch_tool wafw00f ;;
            10) launch_tool xsstrike ;;
            11) launch_tool sqlmap ;;
            12) launch_tool ffuf ;;
            13) launch_tool dalfox ;;
            14) launch_tool arjun ;;
            15) launch_tool feroxbuster ;;
            16) install_category WEBAPPS_TOOLS "WebApp" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# FORENSICS MENU
# ============================================================

forensics_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║           FORENSICS TOOLS                ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  autopsy           - Digital forensics GUI"
        echo -e "  ${CYAN}[2]${NC}  volatility        - Memory forensics"
        echo -e "  ${CYAN}[3]${NC}  binwalk           - Firmware analysis"
        echo -e "  ${CYAN}[4]${NC}  foremost          - File recovery"
        echo -e "  ${CYAN}[5]${NC}  scalpel           - File carver"
        echo -e "  ${CYAN}[6]${NC}  bulk-extractor    - Bulk data extractor"
        echo -e "  ${CYAN}[7]${NC}  exiftool          - Metadata extractor"
        echo -e "  ${CYAN}[8]${NC}  testdisk          - Disk/partition recovery"
        echo -e "  ${CYAN}[9]${NC}  photorec          - File recovery tool"
        echo -e "  ${CYAN}[10]${NC} hashdeep          - Hash auditing"
        echo -e "  ${CYAN}[11]${NC} dc3dd             - Forensic disk copy"
        echo -e "  ${CYAN}[12]${NC} oletools          - OLE/Office analysis"
        echo -e "  ${CYAN}[13]${NC} pdfid             - PDF analysis"
        echo -e "  ${CYAN}[14]${NC} Install All Forensics Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool_bg autopsy ;;
            2)  launch_tool vol ;;
            3)  launch_tool binwalk ;;
            4)  launch_tool foremost ;;
            5)  launch_tool scalpel ;;
            6)  launch_tool bulk_extractor ;;
            7)  launch_tool exiftool ;;
            8)  launch_tool testdisk ;;
            9)  launch_tool photorec ;;
            10) launch_tool hashdeep ;;
            11) launch_tool dc3dd ;;
            12) launch_tool oledump ;;
            13) launch_tool pdfid ;;
            14) install_category FORENSICS_TOOLS "Forensics" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# REVERSE ENGINEERING MENU
# ============================================================

reversing_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║        REVERSE ENGINEERING TOOLS         ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  radare2           - Reverse engineering framework"
        echo -e "  ${CYAN}[2]${NC}  ghidra            - NSA reverse engineering suite"
        echo -e "  ${CYAN}[3]${NC}  gdb               - GNU debugger"
        echo -e "  ${CYAN}[4]${NC}  pwndbg            - GDB exploit plugin"
        echo -e "  ${CYAN}[5]${NC}  apktool           - APK decompiler"
        echo -e "  ${CYAN}[6]${NC}  jadx              - Java/Android decompiler"
        echo -e "  ${CYAN}[7]${NC}  dex2jar           - DEX to JAR converter"
        echo -e "  ${CYAN}[8]${NC}  androguard        - Android malware analysis"
        echo -e "  ${CYAN}[9]${NC}  frida             - Dynamic instrumentation"
        echo -e "  ${CYAN}[10]${NC} objection         - Mobile app runtime exploration"
        echo -e "  ${CYAN}[11]${NC} Install All Reversing Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool r2 ;;
            2)  launch_tool_bg ghidra ;;
            3)  launch_tool gdb ;;
            4)  launch_tool gdb ;;
            5)  launch_tool apktool ;;
            6)  launch_tool jadx ;;
            7)  launch_tool d2j-dex2jar ;;
            8)  launch_tool androguard ;;
            9)  launch_tool frida ;;
            10) launch_tool objection ;;
            11) install_category REVERSE_ENGINEERING "Reverse Engineering" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# SNIFFING / SPOOFING MENU
# ============================================================

sniffing_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║         SNIFFING & SPOOFING TOOLS        ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  wireshark         - Packet analyzer GUI"
        echo -e "  ${CYAN}[2]${NC}  tcpdump           - Packet analyzer CLI"
        echo -e "  ${CYAN}[3]${NC}  ettercap          - MITM attack suite"
        echo -e "  ${CYAN}[4]${NC}  bettercap         - Network attack framework"
        echo -e "  ${CYAN}[5]${NC}  mitmproxy         - HTTPS MITM proxy"
        echo -e "  ${CYAN}[6]${NC}  responder         - LLMNR/NBT-NS poisoner"
        echo -e "  ${CYAN}[7]${NC}  dsniff            - Network sniffer suite"
        echo -e "  ${CYAN}[8]${NC}  arpspoof          - ARP spoofing tool"
        echo -e "  ${CYAN}[9]${NC}  sslstrip          - SSL stripping tool"
        echo -e "  ${CYAN}[10]${NC} yersinia          - Layer 2 protocol attacker"
        echo -e "  ${CYAN}[11]${NC} xerosploit        - MITM attack framework"
        echo -e "  ${CYAN}[12]${NC} Install All Sniffing Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool_bg wireshark ;;
            2)  launch_tool tcpdump ;;
            3)  launch_tool ettercap ;;
            4)  launch_tool bettercap ;;
            5)  launch_tool mitmproxy ;;
            6)  launch_tool responder ;;
            7)  launch_tool dsniff ;;
            8)  launch_tool arpspoof ;;
            9)  launch_tool sslstrip ;;
            10) launch_tool yersinia ;;
            11) launch_tool xerosploit ;;
            12) install_category SNIFFING_TOOLS "Sniffing" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# SOCIAL ENGINEERING MENU
# ============================================================

social_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║        SOCIAL ENGINEERING TOOLS          ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  setoolkit         - Social engineer toolkit"
        echo -e "  ${CYAN}[2]${NC}  gophish           - Phishing framework"
        echo -e "  ${CYAN}[3]${NC}  evilginx2         - Phishing/MITM proxy"
        echo -e "  ${CYAN}[4]${NC}  king-phisher      - Phishing campaign tool"
        echo -e "  ${CYAN}[5]${NC}  blackeye          - Phishing page cloner"
        echo -e "  ${CYAN}[6]${NC}  zphisher          - Phishing tool"
        echo -e "  ${CYAN}[7]${NC}  nexphisher        - Phishing tool"
        echo -e "  ${CYAN}[8]${NC}  Install All Social Engineering Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool setoolkit ;;
            2)  launch_tool gophish ;;
            3)  launch_tool evilginx2 ;;
            4)  launch_tool_bg king-phisher ;;
            5)  launch_tool blackeye ;;
            6)  launch_tool zphisher ;;
            7)  launch_tool nexphisher ;;
            8)  install_category SOCIAL_ENGINEERING "Social Engineering" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# CRYPTO / STEGO MENU
# ============================================================

crypto_stego_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║        CRYPTO & STEGANOGRAPHY TOOLS      ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  hashid            - Hash identifier"
        echo -e "  ${CYAN}[2]${NC}  hash-identifier   - Hash type identifier"
        echo -e "  ${CYAN}[3]${NC}  xortool           - XOR analysis"
        echo -e "  ${CYAN}[4]${NC}  rsatool           - RSA key tool"
        echo -e "  ${CYAN}[5]${NC}  fcrackzip         - Zip password cracker"
        echo -e "  ${CYAN}[6]${NC}  rarcrack          - RAR/ZIP/7z cracker"
        echo -e "  ${CYAN}[7]${NC}  steghide          - Steganography tool"
        echo -e "  ${CYAN}[8]${NC}  stegsolve         - Steg image solver GUI"
        echo -e "  ${CYAN}[9]${NC}  outguess          - Steganography tool"
        echo -e "  ${CYAN}[10]${NC} openstego         - Steganography tool GUI"
        echo -e "  ${CYAN}[11]${NC} snow              - Whitespace steganography"
        echo -e "  ${CYAN}[12]${NC} Install All Crypto/Stego Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool hashid ;;
            2)  launch_tool hash-identifier ;;
            3)  launch_tool xortool ;;
            4)  launch_tool rsatool ;;
            5)  launch_tool fcrackzip ;;
            6)  launch_tool rarcrack ;;
            7)  launch_tool steghide ;;
            8)  launch_tool_bg stegsolve ;;
            9)  launch_tool outguess ;;
            10) launch_tool_bg openstego ;;
            11) launch_tool snow ;;
            12) install_category CRYPTO_TOOLS "Crypto/Stego" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# VULNERABILITY SCANNER MENU
# ============================================================

vuln_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║        VULNERABILITY SCANNER TOOLS       ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  openvas           - Open vulnerability scanner"
        echo -e "  ${CYAN}[2]${NC}  nuclei            - Fast vuln scanner"
        echo -e "  ${CYAN}[3]${NC}  jaeles            - Web security scanner"
        echo -e "  ${CYAN}[4]${NC}  trivy             - Container vuln scanner"
        echo -e "  ${CYAN}[5]${NC}  grype             - Container/OS vuln scanner"
        echo -e "  ${CYAN}[6]${NC}  legion            - Network scanner GUI"
        echo -e "  ${CYAN}[7]${NC}  sparta            - Network infra scanner"
        echo -e "  ${CYAN}[8]${NC}  vulscan           - Nmap vulnerability scripts"
        echo -e "  ${CYAN}[9]${NC}  Install All Vuln Scanner Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool openvas ;;
            2)  launch_tool nuclei ;;
            3)  launch_tool jaeles ;;
            4)  launch_tool trivy ;;
            5)  launch_tool grype ;;
            6)  launch_tool_bg legion ;;
            7)  launch_tool_bg sparta ;;
            8)  echo -e "${YELLOW}[i] vulscan is an nmap script. Use: nmap --script vulscan <target>${NC}" ; sleep 3 ;;
            9)  install_category VULN_SCANNERS "Vulnerability Scanners" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# NETWORK TOOLS MENU
# ============================================================

network_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║            NETWORK TOOLS                 ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  netcat            - TCP/UDP tool"
        echo -e "  ${CYAN}[2]${NC}  ncat              - Nmap netcat"
        echo -e "  ${CYAN}[3]${NC}  socat             - Multipurpose relay"
        echo -e "  ${CYAN}[4]${NC}  proxychains       - Proxy chain tool"
        echo -e "  ${CYAN}[5]${NC}  hping3            - Packet crafting tool"
        echo -e "  ${CYAN}[6]${NC}  scapy             - Packet manipulation"
        echo -e "  ${CYAN}[7]${NC}  crackmapexec      - Active Directory tool"
        echo -e "  ${CYAN}[8]${NC}  evil-winrm        - Windows remote management"
        echo -e "  ${CYAN}[9]${NC}  impacket          - Windows protocol tools"
        echo -e "  ${CYAN}[10]${NC} smbclient         - SMB client"
        echo -e "  ${CYAN}[11]${NC} Install All Network Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool nc ;;
            2)  launch_tool ncat ;;
            3)  launch_tool socat ;;
            4)  launch_tool proxychains ;;
            5)  launch_tool hping3 ;;
            6)  launch_tool scapy ;;
            7)  launch_tool crackmapexec ;;
            8)  launch_tool evil-winrm ;;
            9)  echo -e "${YELLOW}[i] Impacket is a suite. Tools: impacket-smbexec, impacket-psexec, etc.${NC}" ; sleep 3 ;;
            10) launch_tool smbclient ;;
            11) install_category NETWORK_TOOLS "Network" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# OSINT MENU
# ============================================================

osint_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║              OSINT TOOLS                 ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  maltego           - OSINT/link analysis GUI"
        echo -e "  ${CYAN}[2]${NC}  theharvester      - Email/domain harvester"
        echo -e "  ${CYAN}[3]${NC}  recon-ng          - Web recon framework"
        echo -e "  ${CYAN}[4]${NC}  sherlock          - Social media username hunt"
        echo -e "  ${CYAN}[5]${NC}  holehe            - Email account checker"
        echo -e "  ${CYAN}[6]${NC}  metagoofil        - Metadata extractor"
        echo -e "  ${CYAN}[7]${NC}  creepy            - Geolocation OSINT"
        echo -e "  ${CYAN}[8]${NC}  userrecon         - Username recon"
        echo -e "  ${CYAN}[9]${NC}  Install All OSINT Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool_bg maltego ;;
            2)  launch_tool theHarvester ;;
            3)  launch_tool recon-ng ;;
            4)  launch_tool sherlock ;;
            5)  launch_tool holehe ;;
            6)  launch_tool metagoofil ;;
            7)  launch_tool_bg creepy ;;
            8)  launch_tool userrecon ;;
            9)  install_category OSINT_TOOLS "OSINT" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# MOBILE TOOLS MENU
# ============================================================

mobile_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║            MOBILE TOOLS                  ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  apktool           - APK decompiler"
        echo -e "  ${CYAN}[2]${NC}  jadx              - Dex/APK decompiler"
        echo -e "  ${CYAN}[3]${NC}  androguard        - Android analysis"
        echo -e "  ${CYAN}[4]${NC}  frida             - Dynamic instrumentation"
        echo -e "  ${CYAN}[5]${NC}  objection         - Runtime mobile exploration"
        echo -e "  ${CYAN}[6]${NC}  drozer            - Android security framework"
        echo -e "  ${CYAN}[7]${NC}  qark              - Android vuln scanner"
        echo -e "  ${CYAN}[8]${NC}  mobsf             - Mobile security framework"
        echo -e "  ${CYAN}[9]${NC}  apkleaks          - APK secrets scanner"
        echo -e "  ${CYAN}[10]${NC} Install All Mobile Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool apktool ;;
            2)  launch_tool jadx ;;
            3)  launch_tool androguard ;;
            4)  launch_tool frida ;;
            5)  launch_tool objection ;;
            6)  launch_tool drozer ;;
            7)  launch_tool qark ;;
            8)  launch_tool mobsf ;;
            9)  launch_tool apkleaks ;;
            10) install_category MOBILE_TOOLS "Mobile" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# CLOUD TOOLS MENU
# ============================================================

cloud_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║            CLOUD & CONTAINER TOOLS       ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  pacu              - AWS exploitation framework"
        echo -e "  ${CYAN}[2]${NC}  prowler           - AWS security auditor"
        echo -e "  ${CYAN}[3]${NC}  scout-suite       - Multi-cloud auditor"
        echo -e "  ${CYAN}[4]${NC}  cloudmapper       - AWS network mapper"
        echo -e "  ${CYAN}[5]${NC}  s3scanner         - S3 bucket scanner"
        echo -e "  ${CYAN}[6]${NC}  trivy             - Container vuln scanner"
        echo -e "  ${CYAN}[7]${NC}  grype             - Container/image scanner"
        echo -e "  ${CYAN}[8]${NC}  kube-bench        - Kubernetes CIS benchmark"
        echo -e "  ${CYAN}[9]${NC}  kube-hunter       - Kubernetes pentesting"
        echo -e "  ${CYAN}[10]${NC} dive              - Container layer inspector"
        echo -e "  ${CYAN}[11]${NC} Install All Cloud/Container Tools"
        echo -e "  ${RED}[0]${NC}  Back"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  launch_tool pacu ;;
            2)  launch_tool prowler ;;
            3)  launch_tool scout-suite ;;
            4)  launch_tool cloudmapper ;;
            5)  launch_tool s3scanner ;;
            6)  launch_tool trivy ;;
            7)  launch_tool grype ;;
            8)  launch_tool kube-bench ;;
            9)  launch_tool kube-hunter ;;
            10) launch_tool dive ;;
            11) install_category CLOUD_TOOLS "Cloud/Container" ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# DOWNLOAD / INSTALL MENU
# ============================================================

install_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║         DOWNLOAD / INSTALL TOOLS         ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  Install Recon Tools"
        echo -e "  ${CYAN}[2]${NC}  Install Exploitation Tools"
        echo -e "  ${CYAN}[3]${NC}  Install Password Tools"
        echo -e "  ${CYAN}[4]${NC}  Install Wireless Tools"
        echo -e "  ${CYAN}[5]${NC}  Install Web Application Tools"
        echo -e "  ${CYAN}[6]${NC}  Install Forensics Tools"
        echo -e "  ${CYAN}[7]${NC}  Install Reverse Engineering Tools"
        echo -e "  ${CYAN}[8]${NC}  Install Sniffing/Spoofing Tools"
        echo -e "  ${CYAN}[9]${NC}  Install Social Engineering Tools"
        echo -e "  ${CYAN}[10]${NC} Install Crypto/Stego Tools"
        echo -e "  ${CYAN}[11]${NC} Install Vulnerability Scanner Tools"
        echo -e "  ${CYAN}[12]${NC} Install Network Tools"
        echo -e "  ${CYAN}[13]${NC} Install OSINT Tools"
        echo -e "  ${CYAN}[14]${NC} Install Mobile Tools"
        echo -e "  ${CYAN}[15]${NC} Install Cloud/Container Tools"
        echo -e "  ${YELLOW}[16]${NC} Install ALL Tools (Full BlackArch Suite)"
        echo -e "  ${CYAN}[17]${NC} Check Tool Status"
        echo -e "  ${RED}[0]${NC}  Back to Main Menu"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  install_category RECON_TOOLS "Recon" ;;
            2)  install_category EXPLOITATION_TOOLS "Exploitation" ;;
            3)  install_category PASSWORD_TOOLS "Password" ;;
            4)  install_category WIRELESS_TOOLS "Wireless" ;;
            5)  install_category WEBAPPS_TOOLS "WebApp" ;;
            6)  install_category FORENSICS_TOOLS "Forensics" ;;
            7)  install_category REVERSE_ENGINEERING "Reverse Engineering" ;;
            8)  install_category SNIFFING_TOOLS "Sniffing" ;;
            9)  install_category SOCIAL_ENGINEERING "Social Engineering" ;;
            10) install_category CRYPTO_TOOLS "Crypto/Stego" ;;
            11) install_category VULN_SCANNERS "Vulnerability Scanners" ;;
            12) install_category NETWORK_TOOLS "Network" ;;
            13) install_category OSINT_TOOLS "OSINT" ;;
            14) install_category MOBILE_TOOLS "Mobile" ;;
            15) install_category CLOUD_TOOLS "Cloud/Container" ;;
            16) install_all_tools ;;
            17) check_status ;;
            0)  break ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# MAIN MENU
# ============================================================

main_menu() {
    while true; do
        banner
        echo -e "${WHITE}  ╔══════════════════════════════════════════╗${NC}"
        echo -e "${WHITE}  ║              MAIN  MENU                  ║${NC}"
        echo -e "${WHITE}  ╚══════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  ${CYAN}[1]${NC}  Reconnaissance Tools"
        echo -e "  ${CYAN}[2]${NC}  Exploitation Tools"
        echo -e "  ${CYAN}[3]${NC}  Password Attack Tools"
        echo -e "  ${CYAN}[4]${NC}  Wireless Tools"
        echo -e "  ${CYAN}[5]${NC}  Web Application Tools"
        echo -e "  ${CYAN}[6]${NC}  Forensics Tools"
        echo -e "  ${CYAN}[7]${NC}  Reverse Engineering Tools"
        echo -e "  ${CYAN}[8]${NC}  Sniffing & Spoofing Tools"
        echo -e "  ${CYAN}[9]${NC}  Social Engineering Tools"
        echo -e "  ${CYAN}[10]${NC} Crypto & Steganography Tools"
        echo -e "  ${CYAN}[11]${NC} Vulnerability Scanners"
        echo -e "  ${CYAN}[12]${NC} Network Tools"
        echo -e "  ${CYAN}[13]${NC} OSINT Tools"
        echo -e "  ${CYAN}[14]${NC} Mobile Tools"
        echo -e "  ${CYAN}[15]${NC} Cloud & Container Tools"
        echo -e "  ${YELLOW}[16]${NC} Download / Install Tools"
        echo -e "  ${BLUE}[17]${NC} Run ALL Installed Tools"
        echo -e "  ${CYAN}[18]${NC} Check Tool Status"
        echo -e "  ${RED}[0]${NC}  Exit"
        echo ""
        read -rp "  Select option: " opt
        case $opt in
            1)  recon_menu ;;
            2)  exploitation_menu ;;
            3)  password_menu ;;
            4)  wireless_menu ;;
            5)  webapp_menu ;;
            6)  forensics_menu ;;
            7)  reversing_menu ;;
            8)  sniffing_menu ;;
            9)  social_menu ;;
            10) crypto_stego_menu ;;
            11) vuln_menu ;;
            12) network_menu ;;
            13) osint_menu ;;
            14) mobile_menu ;;
            15) cloud_menu ;;
            16) install_menu ;;
            17) run_all_tools ;;
            18) check_status ;;
            0)
                echo -e "${RED}[!] Exiting Anon's Black Arch Toolkit. Stay ethical.${NC}"
                exit 0
                ;;
            *)  echo -e "${RED}[!] Invalid option.${NC}" ; sleep 1 ;;
        esac
    done
}

# ============================================================
# ENTRY POINT
# ============================================================
check_root
detect_pkg_manager
main_menu

