#!/bin/sh

# Packages that I don't need but I want to have them

# Kernel
apt-get -t buster-backports install linux-image-amd64

# Firmware for ellis
apt-get install intel-microcode firmware-realtek firmware-misc-nonfree firmware-atheros

# Firmware for paola/fabiola
apt-get install amd64-microcode firmware-realtek firmware-amd-graphics firmware-atheros

# Tools
apt-get install build-essential virt-manager qemu-utils bridge-utils ssh-askpass-gnome mc git hyperspec lynx blender anjuta anjuta-extras bluefish bluefish-plugins geany geany-plugins gummi xmlcopyeditor glade texinfo groff dblatex htmldoc sbcl sbcl-doc sbcl-source abiword gnucash gnumeric audacious audacious-plugins mplayer ffmpeg texinfo gnumeric-plugins-extra sox libsox-fmt-all vorbis-tools mpg123 inkscape inkscape-open-symbols inkscape-tutorials maxima maxima-doc wxmaxima gnome-builder apt-file stella freeglut3 freeglut3-dev virt-manager qemu qemu-kvm aptitude emacs emacs-common-non-dfsg vim vim-gtk3 vim-addon-manager vim-scripts hexchat hexchat-plugins nasm sasm libsdl1.2-dev togl-demos rtorrent tmux amule amule-utils-gui squeak-vm etoys etoys-doc sugar-etoys-activity jigdo-file swi-prolog swi-prolog-doc swi-prolog-bdb swi-prolog-x curl ntpdate libcanberra-gtk-module tree

# Xen
# To fix permissions: user=foo usermod -G vboxusers,libvirt,libvirt-qemu,libvirt-dnsmasq$( groups $user | awk -F: '{ print $2 }' | sed 's/ /,/g' ) $user
apt-get install xen-linux-system xen-utils bridge-utils virt-manager

# Update database
apt-file update

# PostgreSQL
PG_VER=13 apt-get install postgresql-$PG_VER postgresql-client-$PG_VER postgresql-doc-$PG_VER postgresql-server-dev-$PG_VER

# Python 3 venv (python3 -m venv alpha && source ~/alpha/bin/activate && pip --verbose install tg.devtools flask sqlacodegen psycopg2 django django-extensions)
# deactivate
apt-get install python3-dev python3-venv

# Python 3 SQLAlchemy
apt-get install python3-sqlalchemy python3-sqlalchemy-utils python3-psycopg2

# To build GNU Smalltalk
apt-get install libgtk2.0-dev libgtk2.0-doc libreadline-dev freeglut3-dev cmake libsigsegv-dev flex bison

# LibreOffice Base
apt-get install libreoffice-base libreoffice-base-drivers libreoffice-evolution libreoffice-report-builder libreoffice-script-provider-python libreoffice-script-provider-js libreoffice-sdbc-hsqldb libreoffice-sdbc-postgresql libreoffice-mysql-connector libreoffice-pdfimport

# PgAdmin4, from: https://www.pgadmin.org/download/pgadmin-4-apt/
curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add

sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

apt-get install pgadmin4

/usr/pgadmin4/bin/setup-web.sh
