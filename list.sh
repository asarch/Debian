#!/bin/sh

# Packages that I don't need but I want to have them

#  Particionado con UEFI (tambien sirve para Fedora y OpenSuse)
#  Tienes que habilitar la opción de bootear con UEFI y hacerlo
#  así desde la memoria para que puedas particionar con el programa
#  de instalacion.
#
#  +---+
#  |   |  BIOSBOOT - 1 MB      <- Esta partición realmente no es necesaria a menos que uses BIOS
#  +---+
#  |   |  /boot/efi - 5.5 GB
#  +---+
#  |   |  /boot - 5.5 GB
#  +---+
#  |   |  LVM
#  +---+

# Sistemas de archivos virtualizados: del mas rapido al mas lento
#
# BIOS + LVM + ext4
# UEFI + LVM + ext4
# …
# UEFI + btrfs

# Kernel
#apt-get -t buster-backports install linux-image-amd64
apt-get -t bullseye-backports install linux-image-amd64

# Firmware for ellis
apt-get install intel-microcode firmware-realtek firmware-misc-nonfree firmware-atheros

# Firmware for paola/fabiola
apt-get install amd64-microcode firmware-realtek firmware-amd-graphics firmware-atheros

# Firmware for pasifae
# Faltaría el siguiente firmware:
# [   11.058662] bluetooth hci0: firmware: failed to load brcm/BCM20702A1-0a5c-21f1.hcd (-2)
# [   11.058718] firmware_class: See https://wiki.debian.org/Firmware for information about missing firmware
# [   11.058797] bluetooth hci0: firmware: failed to load brcm/BCM-0a5c-21f1.hcd (-2)
# [   11.058841] Bluetooth: hci0: BCM: firmware Patch file not found, tried:
#
# Checa la página sugerida para más información
apt-get install intel-microcode firmware-misc-nonfree firmware-realtek firmware-b43-installer

# Tools
apt-get install build-essential virt-manager qemu-utils bridge-utils ssh-askpass-gnome mc git hyperspec lynx blender anjuta anjuta-extras bluefish bluefish-plugins geany geany-plugins gummi xmlcopyeditor glade texinfo groff dblatex htmldoc  abiword gnucash gnumeric audacious audacious-plugins mplayer ffmpeg texinfo gnumeric-plugins-extra sox libsox-fmt-all vorbis-tools mpg123 inkscape inkscape-open-symbols inkscape-tutorials maxima maxima-doc wxmaxima gnome-builder apt-file stella freeglut3 freeglut3-dev virt-manager qemu aptitude emacs emacs-common-non-dfsg vim vim-gtk3 vim-addon-manager vim-scripts hexchat hexchat-plugins nasm sasm libsdl1.2-dev togl-demos rtorrent tmux amule amule-utils-gui squeak-vm etoys etoys-doc sugar-etoys-activity jigdo-file swi-prolog swi-prolog-doc swi-prolog-bdb swi-prolog-x curl ntpdate libcanberra-gtk-module tree gimp gimp-gutenprint dia dia2code geeqie libgtk-3-doc libgtk2.0-doc libgtkmm-2.4-doc libgtkmm-3.0-doc docbook-xsl-ns hplip frozen-bubble gnome-boxes

# GNU Smalltalk
apt-get install gnu-smalltalk gnu-smalltalk-browser gnu-smalltalk-doc

# SBCL
# Solamente necesitas el binario para compilar la nueva versión
apt-get install sbcl #sbcl-doc sbcl-source

# Para imprimir con Epson L310
apt-get install printer-driver-all printer-driver-cups-pdf foomatic-db-engine openprinting-ppds

# Samba
apt-get install samba

# Obsoletos en bullseye
#qemu-kvm libgtk2-perl-doc seed-webkit2 seed-webkit2-doc xen-linux-system xen-utils bridge-utils virt-manager

# Xen
# To fix permissions: user=foo usermod -G vboxusers,libvirt,libvirt-qemu,libvirt-dnsmasq$( groups $user | awk -F: '{ print $2 }' | sed 's/ /,/g' ) $user
# E.g: usermod -G libvirt,libvirt-qemu$( groups asarch | awk -F: '{ print $2 }' | sed 's/ /,/g' ) asarch
apt-get install xen-hypervisor-4.14-amd64 xen-utils-4.14 xen-doc xen-tools

# ReiserFS
apt-get install reiserfsprogs # ReiserFS 3.x

# Puedes formatear pero no usar, tienes que parchar al kernel
apt-get install reiser4progs  # ReiserFS 4.x: 

# Update database
apt-file update

# PostgreSQL
export PG_VER=13
apt-get install postgresql-$PG_VER postgresql-client-$PG_VER postgresql-doc-$PG_VER postgresql-server-dev-$PG_VER

# Python 3 venv 
#
# python3 -m venv alpha
# source ~/alpha/bin/activate
# pip --verbose install tg.devtools flask flask-admin flask-sqlacodegen flask-sqlalchemy psycopg2 django django-extensions
# flask-sqlacodegen 'orbm://username:password@hostname/table' > model.py
# deactivate
#
apt-get install python3-dev python3-venv

# Python 3 SQLAlchemy
apt-get install python3-sqlalchemy python3-sqlalchemy-utils python3-psycopg2

# To build GNU Smalltalk
apt-get install libgtk2.0-dev libgtk2.0-doc libreadline-dev freeglut3-dev cmake libsigsegv-dev flex bison

# Node.js + Express development tools
apt-get install nodejs nodejs-doc npm node-express node-express-generator

# LibreOffice Base
# dpkg -L openclipart-libreoffice: /usr/lib/libreoffice/share/gallery
# dpkg -L openclipart-png: /usr/share/openclipart/png
# dpkg -L openclipart-svg: /usr/share/openclipart/svg
apt-get install libreoffice-base libreoffice-base-drivers libreoffice-evolution libreoffice-report-builder libreoffice-script-provider-python libreoffice-script-provider-js libreoffice-sdbc-hsqldb libreoffice-sdbc-postgresql libreoffice-mysql-connector openclipart openclipart-libreoffice openclipart-png openclipart-svg

# Paquetes obsoletos con bullseye
# libreoffice-pdfimport

# PgAdmin4, from: https://www.pgadmin.org/download/pgadmin-4-apt/
curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add

sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

apt-get install pgadmin4

/usr/pgadmin4/bin/setup-web.sh

# Habilitamos la documentación local
cd /var/www/html
ln -vs /usr/share/doc/postgresql-doc-13/html postgresql
ln -vs /usr/share/doc/hyperspec .
ln -vs /usr/share/gtk-doc/html/gdk2 .
ln -vs /usr/share/gtk-doc/html/gtk2 .
ln -vs /usr/share/doc/libgtk2.0-doc/faq gtk2-faq
ln -vs /usr/share/doc/libgtk2.0-doc/tutorial gtk2-tutorial
ln -vs /usr/share/gtk-doc/html/gdk3 .
ln -vs /usr/share/gtk-doc/html/gtk3 .
ln -vs /usr/share/doc/libgtkmm-2.4-doc/reference/html gtkmm2
ln -vs /usr/share/doc/libgtkmm-3.0-doc/reference/html gtkmm3

# Habilitamos el soporte para Squeak
cat <<END | sudo tee /etc/security/limits.d/squeak.conf
*      hard    rtprio  2
*      soft    rtprio  2
END

# Habilitamos el soporte para pharo
cat <<END | sudo tee /etc/security/limits.d/pharo.conf
*      hard    rtprio  2
*      soft    rtprio  2
END
