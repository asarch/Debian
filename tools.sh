#!/bin/sh

#---------------------------------------------------------------------
#  Firmware
#---------------------------------------------------------------------

#  Particionado con UEFI (tambien sirve para Fedora y OpenSuse)
#  Tienes que habilitar la opción de bootear con UEFI y hacerlo
#  así desde la memoria para que puedas particionar con el programa
#  de instalacion.
#
#  +---+
#  |   |  BIOSBOOT  - 1 MB      <- Esta partición realmente no es necesaria a menos que uses BIOS
#  +---+
#  |   |  /boot/efi - 5.5 GB
#  +---+
#  |   |  /boot     - 5.5 GB
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

# Compiler tools
apt-get install build-essential

# Virt-Manager
apt-get install virt-manager qemu-utils bridge-utils ssh-askpass-gnome

# Xen
#
# To fix permissions: user=foo usermod -G vboxusers,libvirt,libvirt-qemu,libvirt-dnsmasq$( groups $user | awk -F: '{ print $2 }' | sed 's/ /,/g' ) $user
# E.g: usermod -G libvirt,libvirt-qemu$( groups asarch | awk -F: '{ print $2 }' | sed 's/ /,/g' ) asarch
apt-get install xen-hypervisor-4.14-amd64 xen-utils-4.14 xen-doc xen-tools

# ReiserFS
apt-get install reiserfsprogs # ReiserFS 3.x

# Puedes formatear pero no usar, tienes que parchar al kernel
apt-get install reiser4progs  # ReiserFS 4.x: 

# CLI Tools
apt install mc git lynx apt-file aptitude rtorrent tmux jigdo-file curl ntpdate tree unrar

# Update database
apt-file update

#---------------------------------------------------------------------
# Lenguajes de programacion y librerias
#---------------------------------------------------------------------

# GTK+ 3.x
apt install libcanberra-gtk-module libgtk-3-doc libgtkmm-3.0-doc gtk-3-examples

# Common Lisp
# Solamente necesitas el binario para compilar la nueva versión
apt-get install hyperspec sbcl #sbcl-doc sbcl-source

# Squeak
apt install squeak-vm etoys etoys-doc sugar-etoys-activity

# Prolog
apt install swi-prolog swi-prolog-doc swi-prolog-bdb swi-prolog-x gprolog gprolog-doc

# Tcl/Tk
apt install tkcon tcl8.6-doc tk8.6-doc tcl8.6-tdbc-postgres togl-demos

# Documentacion de Haskell
apt install haskell98-tutorial

# Python 3 venv 
#
# python3 -m venv ~/Projects/alpha
# source ~/Projects/alpha/bin/activate
# pip --verbose install tg.devtools flask flask-admin flask-sqlacodegen flask-sqlalchemy psycopg2 django django-extensions openai
# flask-sqlacodegen 'orbm://username:password@hostname/table' > model.py
# deactivate
#
apt-get install python3-dev python3-venv

# Python 3 SQLAlchemy
apt-get install python3-sqlalchemy python3-sqlalchemy-utils python3-psycopg2

# Node.js + Express development tools
apt-get install nodejs nodejs-doc npm node-express node-express-generator

# Raku
apt install moarvm nqp perl6 rakudo

# Moose y LLVM
apt install libmoose-perl llvm-11-doc llvm-11-examples

# C++
apt install c++-annotations-pdf

# GNU Smalltalk

# To build GNU Smalltalk

apt install libgtk2.0-dev libgtk2.0-doc freeglut3-dev tcl8.6-dev tk8.6-dev
apt install cmake libsigsegv-dev flex bison libreadline-dev libsqlite3-dev libgdbm-dev 

#!/bin/sh
# Obtenemos el codigo fuente
# git clone git://git.sv.gnu.org/smalltalk.git
# Iniciamos la configuracion
# cd smalltalk
# Corregimos el problema del punto flotante:
export CFLAGS='-no-pie'
export LDFLAGS='-no-pie'
export CPPFLAGS='-DUSE_INTERP_RESULT'
# echo "Autoreconf"
# echo
# autoreconf -vi > _autoreconf.log 2>&1
# echo "Configure"
# echo
# ./configure --verbose --enable-gtk=yes --enable-glibtest --enable-threads=posix > _configure.log 2>&1
# ./configure --verbose --enable-gtk=blox --enable-glibtest --enable-threads=posix > _configure.log 2>&1
# ./configure --verbose --enable-gtk=blox --enable-glibtest --enable-threads=posix --with-tcl=/usr/lib/tcl8.6 --with-tk=/usr/lib/tk8.6 > _configuracion.log 2>&1
./configure --verbose --enable-threads=POSIX --enable-gtk=no --disable-glibtest --disable-gtktest --with-tcl --with-tk --without-x > _configuracion.log 2>&1
# echo "Compilation"
# echo
make > _make.log 2>&1
# echo "Checking"
# echo
make check > _check.log 2>&1
make install > _instalacion.log 2>&1

#---------------------------------------------------------------------
# Bases de datos
#---------------------------------------------------------------------

# PostgreSQL
export PG_VER=15
apt-get install postgresql-$PG_VER postgresql-client-$PG_VER postgresql-doc-$PG_VER postgresql-server-dev-$PG_VER

# PgAdmin4, from: https://www.pgadmin.org/download/pgadmin-4-apt/
curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add

sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

apt-get install pgadmin4

/usr/pgadmin4/bin/setup-web.sh

# MariaDB
apt install mariadb-backup mariadb-client mariadb-server phpmyadmin libapache2-mod-php

# SQLite3
apt install sqlite3 sqlite3-doc phpliteadmin phpliteadmin-themes
apt install sqlitebrowser 

# LibreOffice Base
# dpkg -L openclipart-libreoffice: /usr/lib/libreoffice/share/gallery
# dpkg -L openclipart-png: /usr/share/openclipart/png
# dpkg -L openclipart-svg: /usr/share/openclipart/svg
apt-get install libreoffice-base libreoffice-base-drivers libreoffice-evolution libreoffice-report-builder libreoffice-script-provider-python libreoffice-script-provider-js libreoffice-sdbc-hsqldb libreoffice-sdbc-postgresql libreoffice-mysql-connector openclipart openclipart-libreoffice openclipart-png openclipart-svg

# Utilerias para las bases de datos de Base
# Para despachar a un archivo de Base como servidor:
# java -cp /usr/share/java/hsqldb.jar org.hsqldb.server.Server --database.0 file:taco --dbname.0 taco
#
# Para usar la utileria:
# java -cp /usr/share/java/hsqldb.jar org.hsqldb.util.DatabaseManagerSwing
#
# Usa esta direccion: jdbc:hsqldb:hsql://localhost/taco;default_schema=true
apt-get install hsqldb-utils libhsqldb-java libhsqldb-java-doc

# Firebird
apt install firebird3.0-server firebird3.0-utils flamerobin firebird3.0-doc firebird3.0-common-doc firebird3.0-examples

#---------------------------------------------------------------------
# Utilerias
#---------------------------------------------------------------------

# GNOME
apt-get install gnome-boxes epiphany-browser 

# GNOME Office
apt install abiword gnucash grisbi homebank gnumeric gnumeric-plugins-extra ttf-mscorefonts-installer

# IRC
apt install hexchat hexchat-plugins alice irssi irssi-plugin-otr irssi-plugin-robustirc irssi-plugin-xmpp irssi-scripts

# Graphics
apt install geeqie blender inkscape inkscape-open-symbols inkscape-tutorials gimp gimp-gutenprint dia dia2code

# IDE
apt install bluefish bluefish-plugins gnome-builder

# Audio & Video
apt install mplayer ffmpeg mpg123 sox libsox-fmt-all vorbis-tools

# Text formatters
apt install texinfo groff dblatex htmldoc gummi xmlcopyeditor docbook-xsl-ns

# Editores
apt install nvi emacs emacs-common-non-dfsg emacs-goodies-el vim vim-gtk3 vim-addon-manager vim-scripts

# Para imprimir con Epson L310
apt-get install printer-driver-all printer-driver-cups-pdf foomatic-db-engine openprinting-ppds

# Escanner
apt-get install hplip

# Samba
apt-get install samba

#---------------------------------------------------------------------
# GTK+ 2.x & XOrg & Qt5
#---------------------------------------------------------------------

# Libs
apt install freeglut3 freeglut3-dev
apt install libsdl1.2-dev libgtk2.0-doc libgtkmm-2.4-doc gtk2.0-examples

# Vulkan
apt install vulkan-tools libgulkan-dev libgulkan-doc libgulkan-utils libglfw3-dev libglfw3 libglfw3-doc libglm-dev libcglm-doc

# librep
apt install rep rep-doc rep-gtk 

  # Glade
apt install glade

# IDE
apt install geany geany-plugins anjuta anjuta-extras

# Haskell
apt install ghc ghc-doc haskell-platform-doc
apt install libghc-glut-doc libghc-gtk3-dev libghc-gtk3-doc libghc-gtk-dev libghc-gtk-doc libghc-hdbc-postgresql-doc libghc-hdbc-postgresql-dev libghc-hdbc-sqlite3-dev libghc-hdbc-sqlite3-doc libghc-hsp-dev libghc-hsp-doc libghc-http-dev libghc-http-doc libghc-opengl-dev libghc-opengl-doc pkg-haskell-tools

# Lazarus
apt install lazarus-ide-gtk2-2.0 lazarus-doc-2.0 lazarus-src-2.0 lazarus-2.0

# Emulators
stella 
apt-get install nasm sasm
apt-get install maxima maxima-doc wxmaxima amule amule-utils-gui frozen-bubble

# Qt5
apt install audacious audacious-plugins youtubedl-gui

# Obsoletos en bullseye
# qemu-kvm libgtk2-perl-doc seed-webkit2 seed-webkit2-doc libreoffice-pdfimport

# Habilitamos la documentación local
cd /var/www/html
ln -vs /usr/share/doc/postgresql-doc-15/html postgresql
ln -vs /usr/share/doc/xen/html xen
ln -vs /usr/share/gtk-doc/html/gdk3 .
ln -vs /usr/share/gtk-doc/html/gtk3 .
ln -vs /usr/share/doc/libgtkmm-3.0-doc/reference/html gtkmm3
ln -vs /usr/share/doc/gtkmm-documentation/tutorial/html gtkmm-tutorial
ln -vs /usr/share/doc/libglfw3-dev/html glfw
ln -vs /usr/share/gtk-doc/html/gobject .
ln -vs /usr/share/doc/hyperspec .
ln -vs /usr/share/doc/haskell98-tutorial/html haskell98-tutorial
ln -vs /usr/share/doc/haskell98-report/html haskell98-report
ln -vs /home/asarch/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/share/doc/rust/html rust

# Prolog
mkdir swi-prolog
cd swi-prolog/
ln -vs /usr/share/swi-prolog/doc/packages .
ln -vs /usr/share/swi-prolog/doc/Manual manual

#ln -vs /usr/share/gtk-doc/html/gulkan .
#ln -vs /usr/share/doc/libhsqldb-java/guide hsqldb
#ln -vs /usr/share/gtk-doc/html/gdk2 .
#ln -vs /usr/share/gtk-doc/html/gtk2 .
#ln -vs /usr/share/doc/libgtk2.0-doc/faq gtk2-faq
#ln -vs /usr/share/doc/libgtk2.0-doc/tutorial gtk2-tutorial
#ln -vs /usr/share/doc/libgtkmm-2.4-doc/reference/html gtkmm2

# Haskell documentation

# Si usas los paquetes de Debian:
#ln -vs /usr/share/doc/ghc-doc .
#ln -vs /usr/share/doc/libghc-gtk3-doc/html ghc-gtk3

# Si usas el instalador de la página:
# https://www.haskell.org/
# https://www.haskell.org/ghcup/
# curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
ln -vs /home/asarch/.ghcup/ghc/9.2.5/share/doc/ghc-9.2.5/html ghc

# Habilitamos el soporte para Squeak
cat <<END | sudo tee /etc/security/limits.d/squeak.conf
*      hard    rtprio  2
*      soft    rtprio  2
END

# Habilitamos el soporte para Pharo
cat <<END | sudo tee /etc/security/limits.d/pharo.conf
*      hard    rtprio  2
*      soft    rtprio  2
END
