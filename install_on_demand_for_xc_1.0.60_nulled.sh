#!/bin/bash
XC_DIR=/home/xtreamcodes/iptv_xtream_codes/
WWW_DIR=wwwdir/updates1/
jeshile='\e[40;38;5;82m' #jeshile
echo -e "${jeshile} ┌─────────────────────────────────────┐ \e[0m"
echo -e "${jeshile} │  On-Demand for Xtream Codes 1.0.60  │ \e[0m"
echo -e "${jeshile} └─────────────────────────────────────┘ \e[0m\n"
if [ -d "$XC_DIR" ]; then
  reshile='\e[1;37m' #jeshile
  read -p "MySQL Host [localhost]: " dbhost
  dbhost=${dbhost:-localhost}
  read -p "MySQL Username [root]: " dbuser
  dbuser=${dbuser:-root}
  read -s -p "MySQL Password: " dbpass
  echo ""
  read -p "MySQL Database [xtream_iptvpro]: " dbname
  dbname=${dbname:-xtream_iptvpro}
  if mysql -h "$dbhost" -u "$dbuser" -p"$dbpass"  -e "use $dbname"; then
    wget https://github.com/sandigits/xc-patches/raw/master/files/xc_1.0.60_nulled/updates.zip
    unzip updates.zip -d "$XC_DIR$WWW_DIR"
    rm updates.zip
    touch "$XC_DIR"crons/PHPSESSID1
    chown xtreamcodes:xtreamcodes "$XC_DIR"crons/PHPSESSID1
    sed -i "s/MYHOST/$dbhost/g" "$XC_DIR$WWW_DIR/updates/config.php"
    sed -i "s/MYUSERNAME/$dbuser/g" "$XC_DIR$WWW_DIR/updates/config.php"
    sed -i "s/MYPASSWORD/$dbpass/g" "$XC_DIR$WWW_DIR/updates/config.php"
    sed -i "s/MYDATABASE/$dbname/g" "$XC_DIR$WWW_DIR/updates/config.php"
  fi
else
  RED='\033[0;31m'
  NC='\033[0m' # No Color
  echo -e "${RED}Extream codes directory(/home/xtreamcodes/iptv_xtream_codes/) not found".${NC}
fi
