#!/bin/bash
RED='\033[0;31m'
LRED='\033[1;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'
if [ -e "/usr/local/cpanel/version" ]; then
        printf "${GREEN}Please enter your email address (optional) :${NC} "
			read email < /dev/tty
			wget --timeout 10 --tries=2 -q https://www.sysally.com/v3r1fy-pl4g1n.php?email=Gsafe,$email
        mkdir -p /tmp/gsafe
		mkdir /etc/gsafe
        wget --timeout 10 --tries=2 -q -O /tmp/gsafe/gsafe.tar.gz https://downloads.sysally.com/gsafe/gsafe.tar.gz
                cd /tmp/gsafe/
                tar -xzvf gsafe.tar.gz
                mkdir -p /usr/local/cpanel/whostmgr/docroot/cgi/g-safe /usr/local/cpanel/whostmgr/docroot/addon_plugins/g-safe /usr/local/cpanel/whostmgr/docroot/templates/g-safe /usr/local/cpanel/base/frontend/paper_lantern/g-safe /var/cpanel/gsafe
                cp -r adp-g-safe/* /usr/local/cpanel/whostmgr/docroot/addon_plugins/g-safe
                cp -r cgi-g-safe/* /usr/local/cpanel/whostmgr/docroot/cgi/g-safe
                cp -r tmp-g-safe/* /usr/local/cpanel/whostmgr/docroot/templates/g-safe
				cp -r pap_lant-g-safe/* /usr/local/cpanel/base/frontend/paper_lantern/g-safe
				cp uninstall_gsafe.sh /etc/gsafe
				cp -r var-gsafe/* /var/cpanel/gsafe
                mv uninstall_gsafe.sh /etc/gsafe/uninstall_gsafe.sh
                chmod -R 755 /usr/local/cpanel/whostmgr/docroot/cgi/g-safe/
                /usr/local/cpanel/bin/register_appconfig gsafe.conf
				/usr/local/cpanel/scripts/install_plugin /usr/local/cpanel/base/frontend/paper_lantern/g-safe/g-safe.tar.gz
				/usr/local/cpanel/bin/manage_hooks add script /var/cpanel/gsafe/remove.pl --manual --category Whostmgr --event 'Accounts::Remove' --stage pre
                /usr/local/cpanel/bin/manage_hooks add script /var/cpanel/gsafe/update.pl --manual --category Whostmgr --event 'Accounts::Modify' --stage pre
				
                                printf "\n${YELLOW}Performing Clean up ....${NC}\n"
                                rm -rf adp-g-safe cgi-g-safe gsafe.conf pap_lant-g-safe tmp-g-safe
                printf "${GREEN}\nThe G-Safe plugin is installed successfully.${NC}\n\n"
                 else
                        printf "${RED}G-Safe is not supported in a non C-panel Server"
        fi

