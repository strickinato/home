# Get IP info

my_ip() {
    curl ifconfig.me;
    ifconfig | grep broadcast | sed 's/ /,/g' | cut -d',' -f10;
}

alias myip=my_ip
