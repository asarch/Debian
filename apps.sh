#!/bin/sh
apt install build-essential virt-manager qemu-utils bridge-utils ssh-askpass-gnome xen-hypervisor-4.17-amd64 xen-utils-4.17 xen-doc xen-tools mc git lynx apt-file aptitude rtorrent tmux jigdo-file curl ntpdate tree unrar-free squeak-vm mariadb-backup mariadb-client mariadb-server phpmyadmin libapache2-mod-php sqlite3 sqlite3-doc phpliteadmin phpliteadmin-themes sqlitebrowser libreoffice-base libreoffice-base-drivers libreoffice-evolution libreoffice-report-builder libreoffice-script-provider-python libreoffice-script-provider-js libreoffice-sdbc-hsqldb libreoffice-sdbc-mysql openclipart openclipart-libreoffice openclipart-png openclipart-svg gnome-boxes epiphany-browser abiword gnucash grisbi homebank gnumeric gnumeric-plugins-extra ttf-mscorefonts-installer hexchat hexchat-plugins alice irssi irssi-plugin-otr irssi-plugin-xmpp irssi-scripts geeqie inkscape inkscape-open-symbols inkscape-tutorials gimp gimp-gutenprint dia dia2code bluefish bluefish-plugins gnome-builder mplayer ffmpeg mpg123 sox libsox-fmt-all vorbis-tools texinfo groff dblatex htmldoc gummi xmlcopyeditor docbook-xsl-ns nvi emacs emacs-goodies-el vim vim-gtk3 vim-addon-manager vim-scripts printer-driver-all printer-driver-cups-pdf foomatic-db-engine openprinting-ppds hplip glade libreoffice-sdbc-postgresql blender sbcl sbcl-doc sbcl-source thunderbird

# Wireless para pasifae
apt-get install firmware-b43-installer

# Necesitas primero instalar a PostgreSQL
export PG_VER=15
apt-get install postgresql-$PG_VER postgresql-client-$PG_VER postgresql-doc-$PG_VER postgresql-server-dev-$PG_VER

# From https://www.pgadmin.org/download/pgadmin-4-apt/

#
# Setup the repository
#

# Install the public key for the repository (if not done previously):
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg

# Create the repository configuration file:
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

#
# Install pgAdmin
#

# Install for both desktop and web modes:
sudo apt install pgadmin4

# Install for desktop mode only:
sudo apt install pgadmin4-desktop

# Install for web mode only: 
sudo apt install pgadmin4-web 

# Configure the webserver, if you installed pgadmin4-web:
sudo /usr/pgadmin4/bin/setup-web.sh
