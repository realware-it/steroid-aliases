30/03/2020 08:30

# BASH ALIASES (on steroids):
#--------------------------------------------
# Author: Oscar Sironi
# Date: 20140616
# Revision: 20200315
# Note: Sistemati alcuni escapes, aggiunte funzioni
#--------------------------------------------


#-----------------------------------------
# MUOVERSI TRA DIRECTORY E COMANDI UTILI
#--------------------------------------------

alias ll='ls -lhA --color=always'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias cd..='cd ..'

## Colora output dei comandi grep, utile per i log) ##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# colordiff
alias diff='colordiff'
# usa root #
alias root='sudo -i'
alias su='sudo -i'

# handy short cuts #
alias h='history'
alias j='jobs -l'

# preserva da grossi danni al sistema e comandi potenzialmente distruttivi #
alias rm='rm -I --preserve-root'
alias cp="cp -iv"
alias rm="rm -i"
alias mv="mv -iv"

#-------------------------------------------------------------------------------------------
# MANIPOLAZIONE FILE E COMANDI COMUNI:                   
#-------------------------------------------------------------------------------------------

#Trova i 5 file più grossi sul sistema operativo
alias mostri="find . -type f -exec ls -s {} \; | sort -n -r | head -5"

#Per vedere i file senza commenti
alias nocomment='grep -Ev '\''^(#|$)'\'''

alias c='clear'

#-------------------------------------------------------------------------------------------
# PROCESSESSI DI SISTEMA E DISCO:                                     
#-------------------------------------------------------------------------------------------

alias df="df -Tha --total"
alias ps="ps auxf"
alias top="htop"

#Aggiornamento sistema
alias update='sudo apt-get update && sudo apt-get upgrade -y'
alias apt-get='sudo apt-get'
alias install='sudo apt-get install'

#Preserva danni quando si manipolano permessi sulla / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias pstree='/sw/bin/pstree -g 2 -w'

# findPid: trova il pid di un determinato processo
#    Può essere usato anche con regex
#    Es: findPid '/d$/' trova il pid di tutti i processi con nome che finisce con 'd'
#    Attenzione: senza sudo trova solo i processi dell'user corrente
findPid () { sudo /usr/sbin/lsof -t -c "$@" ; }

# Cerca mostri che mangiano RAM:
alias mem_monsters_top='top -l 1 -o rsize -n 10'
alias mem_monsters_ps='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

# Cerca mostri che mangiano CPU:
alias cpu_monsters='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

# Top persistente con refresh di 10 secondi, mostra i top 15 consumatori CPU 
alias topforever='top -l 0 -s 10 -o cpu -n 15'

#Preso da MacOShints
# recommended 'top' invocation to minimize resources in thie macosxhints article
# http://www.macosxhints.com/article.php?story=20060816123853639
# exec /usr/bin/top -R -F -s 10 -o rsize

# diskwho: mostra i processi che stanno in read/write
alias diskwho='sudo iotop'


#-------------------------------------------------------------------------------------------
# GESTIONE ARCHIVI
#-------------------------------------------------------------------------------------------
alias untarz='tar -xzf'
alias untarj='tar -xjf'

#-------------------------------------------------------------------------------------------
# GENERATORE PASSWORD
#-------------------------------------------------------------------------------------------
alias passgen='sudo pwgen -B -c -n  -y  8 100 > passtest.txt'


#-------------------------------------------------------------------------------------------
# FILE EDITORS E MANOIPOLAZIONE TESTO:
#-------------------------------------------------------------------------------------------

alias nano="sudo nano"

# fixlines: edit files in place to ensure Unix line-endings
fixlines () { /usr/bin/perl -pi~ -e 's/\r\n?/\n/g' "$@" ; }

# cut80: truncate lines longer than 80 characters (for use in pipes)
alias cut80='/usr/bin/cut -c 1-80'

# foldpb: make text in clipboard wrap so as to not exceed 80 characters 
alias foldpb='pbpaste | fold -s | pbcopy'

# enquote: surround lines with quotes (useful in pipes) - from mervTormel
enquote () { /usr/bin/sed 's/^/"/;s/$/"/' ; }

# casepat: generate a case-insensitive pattern
casepat () { perl -pe 's/([a-zA-Z])/sprintf("[%s%s]",uc($1),$1)/ge' ; }

# getcolumn: extract a particular column of space-separated output
# e.g.: lsof | getcolumn 0 | sort | uniq
getcolumn () { perl -ne '@cols = split; print "$cols['$1']\n"' ; }

# cat_pdfs: concatenate PDF files
# e.g. cat_pdfs -o combined.pdf file1.pdf file2.pdf file3.pdf
cat_pdfs () { python '/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py' "$@" ; } 

# numberLines: echo the lines of a file preceded by line number
numberLines () { perl -pe 's/^/$. /' "$@" ; }

# convertHex: convert hexadecimal numbers to decimal
convertHex () { perl -ne 'print hex(), "\n"' ; }

# allStrings: show all strings (ASCII & Unicode) in a file
allStrings () { cat "$1" | tr -d "\0" | strings ; }

#-------------------------------------------------------------------------------------------
# INTERNET E NETWORKING:                                       
#-------------------------------------------------------------------------------------------

#Ping 5 richieste
alias ping='ping -c 5'

# Ping veloce, toglie 1s delay tra le richieste #
alias fastping='ping -c 100 -s.2'

#Controlla porte
alias ports='netstat -tulanp'

#Controlla porte, es chkports openvpn > Mostra porte in uso da openvpn
chkports () {
read programma
netstat -tulanp | grep $programma
}


## scorciatoia per iptables via sudo#
alias ipt='sudo /sbin/iptables'

# Listare regole iptables
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist


alias wget='wget -c'


#-------------------------------------------------------------------------------------------
# COMANDI RELATIVI A QUESTO FILE ~/.bash_aliases
#-------------------------------------------------------------------------------------------

#showa: Cercare comando alias che non ricordiamo
showa () { /usr/bin/grep -i -a1 $@ ~/.aliases.bash | grep -v '^\s*$' ; }

# sourcea: source questo file (rende attive le modifiche)
alias sourcea='source ~/.bash_aliases'

#-------------------------------------------------------------------------------------------
# TERMINALE E GESTIONE DELLA SHELL:
#-------------------------------------------------------------------------------------------

# fix_stty: ripristina settaggi del terminale nel caso si dovesse corrompere
alias fix_stty='stty sane'

# nocase: Setta l'autocompletamento da shell case insensitive
alias nocase='set completion-ignore-case On'

# show_options: Mostra impostazioni tramite bash options
alias show_options='shopt'

#-------------------------------------------------------------------------------------------
# STRUMENTI DI RICERCA:
#-------------------------------------------------------------------------------------------

# ff: Cercare un file nella directory corrente
ff () { /usr/bin/find . -name "$@" ; }

# ffs: Cercare un file il cui nome inizia con una determinata stringa
ffs () { /usr/bin/find . -name "$@"'*' ; }

# ffe: Cercare un file il cui nome finisce con una determinata stringa
ffe () { /usr/bin/find . -name '*'"$@" ; }

# grepfind: grep di stringhe nei file trovati da find, es: grepf stringa '*.c'
# Alternativamente usare 'grep -r pattern dir_name' se si vuole cercare fra tutti i files 
grepfind () { find . -type f -name "$2" -print0 | xargs -0 grep "$1" ; }

# Alias di grepfind perchè mi scordo l'alias
alias findgrep='grepfind'

# grepincl: grep nella /usr/include directory
grepincl () { (cd /usr/include; find . -type f -name '*.h' -print0 | xargs -0 grep "$1" ) ; }

# findbigger: Cerca file più grandi di X bytes
findbigger() { find . -type f -size +${1}c ; }

#-------------------------------------------------------------------------------------------
# UTILITA' DI SISTEMA VARIE
#-------------------------------------------------------------------------------------------

# Usa diskutil perriparare i permessi
alias repairpermissions='sudo diskutil repairpermissions /'

# install all software updates from the command line
alias software_update_cmd='COMMAND_LINE_INSTALL=1 export COMMAND_LINE_INSTALL; sudo softwareupdate -i -a'

# third_party_kexts: to check for non-Apple kernel extensions
alias third_party_kexts='kextstat | grep -v com.apple'

# show_optical_disk_info - e.g. what type of CD & DVD media is supported
alias show_optical_disk_info='drutil info'


# mount_read_write: for use when booted into single-user
alias mount_read_write='/sbin/mount -uw /'

# herr: shows the most recent lines from the HTTP error log
alias herr='tail /var/log/httpd/error_log'

# use vsdbutil to show/change the permissions ignoring on external drives
# To ignore ownerships on a volume, do: sudo vsdbutil -d /VolumeName
# To restore ownerships on a volume, do: sudo vsdbutil -a /VolumeName
# To check the status of ownerships, do: sudo vsdbutil -c /VolumeName
alias ignore_permissions='sudo vsdbutil -d'

# to change the password on anencrypted disk image:
# hdiutil chpass /path/to/the/diskimage
# netparams: to show values of network parameters in the kernel
alias netparams='sysctl -a | grep net'

# swapinfo: to display info on swap
alias swapinfo='sysctl vm.swapusage'
alias lso="ls -alG | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"

#-------------------------------------------------------------------------------------------
# AREA SCRIPTS E FUNZIONI:
#-------------------------------------------------------------------------------------------

#Crea una directory ed entra in essa

mkd () {
    mkdir -p $1
    cd $1
}

# Mostra albero directory 
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# Spegni schermo
alias screenoff='xset dpms force off'

# list folders by size in current directory
alias usage='du -h --max-depth=1 | sort -rh'

# Arrampica directory, es:  up -> sale di una directory
# up 4 -> sale di 4 directories
up()
{
    dir=""
    if [[ $1 =~ ^[0-9]+$ ]]; then
        x=0
        while [ $x -lt ${1:-1} ]; do
            dir=${dir}../
            x=$(($x+1))
        done
    else
         dir=..
    fi
    cd "$dir";
}


#Estrattore files
#!/bin/zsh
function extract {
 if [ -z "$1" ]; then
    # Se nessun parametro viene specificato, mostra come usarlo
    echo "Utilizzo: extract <path/nomefile>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f "$1" ] ; then
        NAME=${1%.*}
        #mkdir $NAME && cd $NAME
        case "$1" in
          *.tar.bz2)   tar xvjf ./"$1"    ;;
          *.tar.gz)    tar xvzf ./"$1"    ;;
          *.tar.xz)    tar xvJf ./"$1"    ;;
          *.lzma)      unlzma ./"$1"      ;;
          *.bz2)       bunzip2 ./"$1"     ;;
          *.rar)       unrar x -ad ./"$1" ;;
          *.gz)        gunzip ./"$1"      ;;
          *.tar)       tar xvf ./"$1"     ;;
          *.tbz2)      tar xvjf ./"$1"    ;;
          *.tgz)       tar xvzf ./"$1"    ;;
          *.zip)       unzip ./"$1"       ;;
          *.Z)         uncompress ./"$1"  ;;
          *.7z)        7z x ./"$1"        ;;
          *.xz)        unxz ./"$1"        ;;
          *.exe)       cabextract ./"$1"  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "'$1' - file does not exist"[]()
    fi
fi
}

#-------------------------------------------------------------------------------------------
# VARIE SVILUPPO:
#-------------------------------------------------------------------------------------------

#Jekyll stuff
alias jbuild="cd ~/Projects/yourproject.github.io && sudo bundle exec jekyll build --watch"
alias jrun="cd ~/Projects/yourproject.github.io &&  sudo bundle exec jekyll s --host kaio.realware.it"
alias jpub="cd ~/Projects/yourproject.github.io && sudo cp -r _site/* /var/www/realware.it/web/"
