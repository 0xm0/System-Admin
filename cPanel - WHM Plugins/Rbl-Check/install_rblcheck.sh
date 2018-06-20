#!/bin/bash
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'
if [ -e "/usr/local/cpanel/version" ]; then
        printf "${GREEN}Please enter your email address (optional) :${NC} "
        read email < /dev/tty
        mkdir -p /tmp/rblcheck/
        wget --timeout 10 --tries=2 -q -O /tmp/rblcheck/tempemail https://www.sysally.com/v3r1fy-pl4g1n.php?email=RBLCheck,$email
        wget --timeout 10 --tries=2 -q -O /tmp/rblcheck/rblcheck.tar.gz http://downloads.sysally.com/rblcheck/rblcheck.tar.gz
        cd /tmp/rblcheck/
        tar -xzvf /tmp/rblcheck/rblcheck.tar.gz
        mkdir -p /usr/local/cpanel/whostmgr/docroot/cgi/rblcheck /usr/local/cpanel/whostmgr/docroot/rblcheck/logs /etc/rblcheck
        mv uninstall_rblcheck.sh /etc/rblcheck
        cp -r cgi-rblcheck/* /usr/local/cpanel/whostmgr/docroot/cgi/rblcheck/
        cp -r doc-rblcheck/* /usr/local/cpanel/whostmgr/docroot/rblcheck/
        cp rblcheck.png /usr/local/cpanel/whostmgr/docroot/addon_plugins
        /usr/local/cpanel/bin/register_appconfig rblcheck.conf
        chmod -R 755 /usr/local/cpanel/whostmgr/docroot/cgi/rblcheck/
        printf "\n${YELLOW}Performing Clean up ....${NC}\n"
                                rm -rf /tmp/rblcheck/
        printf "${GREEN}\nThe RBL Check plugin is installed successfully.${NC}\n\n"
else
 printf "\n${CYAN}Sorry, The RBL Check plugin is currently available for cPanel servers only.${NC}\n\n"
fi
