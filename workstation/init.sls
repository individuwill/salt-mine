{% if grains['kernel'] == 'Linux' %}
  {% set home_dir = '/home/wsmith' %}
{% elif grains['kernel'] == 'Darwin' %}
  {% set home_dir = '/Users/wsmith' %}
{% endif %}

{% if grains['os'] == 'Ubuntu' %}
my-packages:
  pkg.installed:
    - pkgs:
      - build-essential
      - linux-headers-{{grains['kernelrelease']}}
      - gnome-sushi
      - silversearcher-ag
      - retext
      - python-gpgme
      - python-software-properties
      - python-pycurl
      - exfat-fuse
      - exfat-utils
      - nfs-common
      - smplayer
      - vlc
      - mpv
      - python-pip
      - network-manager-openvpn
      - ubuntu-restricted-extras
      - flashplugin-installer
# need to run /usr/share/doc/libdvdread4/install-css.sh
      - libdvdread4
      - unity-tweak-tool

tlp:
  pkgrepo.managed:
    - ppa: linrunner/tlp

  pkg.installed:
    - pkgs:
      - tlp
      - tlp-rdw
      - acpi-call-tools
    - refresh: True

  file.managed:
    - name: /etc/default/tlp
    - source: salt://workstation/configs/tlp
    - mode: 644
    - user: root
    - group: root

tlp-start:
  cmd.wait:
    - name: tlp start
    - sls: tlp

networking-tools:
  pkg.installed:
    - pkgs:
      - mtr
      - traceroute
      - wireshark
      - dynamips
      - gns3
      - vpcs
      - nmap
      - zenmap

{{ home_dir }}/.config/ReText project/ReText.css:
  file.managed:
    - source: salt://workstation/configs/ReText.css
    - mode: 664
    - user: wsmith
    - group: wsmith
    
{{ home_dir }}/.config/retext:
  file.symlink:
    - target: {{ home_dir }}/.config/ReText project

# oracle-java7-installer package must be installed manually
# because of license agreement
# don't forget to run 'update-alternatives --config java'
# to choose java version
java:
  pkgrepo.managed:
    - ppa: webupd8team/java
  
  pkg.installed:
    - name: oracle-java7-installer
    - refresh: True

  require:
    - sls: my-packages

# you must run the following command to activate
# pipelight-plugin --enable silverlight
silverlight:
  pkgrepo.managed:
    - ppa: pipelight/stable

  pkg.installed:
    - name: pipelight-multi
    - refresh: True

flush-dns:
  file.managed:
    - name: {{ home_dir}}/bin/flush-dns
    - source: salt://workstation/applications/flush-dns
    - user: wsmith
    - group: wsmith
    - mode: 775
 
/root/.vimrc:
  file.managed:
    - source: salt://config_files/.vimrc

/etc/default/keyboard:
  file.replace:
    - pattern: XKBOPTIONS=".*"
    - repl: XKBOPTIONS="terminate:ctrl_alt_bksp,shift:both_capslock,ctrl:nocaps"

/etc/default/grub:
  file.replace:
    - pattern: GRUB_CMDLINE_LINUX=""
    - repl:  GRUB_CMDLINE_LINUX="acpi_backlight=vendor"

update-grub:
  cmd.wait:
    - watch:
      - file: /etc/default/grub

xcape:
  file.managed:
    - name: {{ home_dir}}/bin/xcape
    - source: salt://workstation/applications/xcape
    - user: wsmith
    - group: wsmith
    - mode: 775
    - requires:
      - file: {{ home_dir }}/bin

{{ home_dir }}/.config/autostart:
  file.directory:
    - user: wsmith
    - group: wsmith
    - mode: 700

{{ home_dir }}/.config/autostart/xcape.desktop:
  file.managed:
    - source: salt://workstation/applications/xcape.desktop
    - user: wsmith
    - group: wsmith
    - mode: 664
    - requires:
      - file: {{ home_dir }}/.config/autostart

vpn:
  pkg.installed:
    - pkgs:
      - vpnc
      - network-manager-vpnc

/usr/share/X11/xorg.conf.d/50-synaptics.conf:
  file.managed:
    - source: salt://workstation/configs/50-synaptics.conf
    - user: root
    - group: root
    - mode: 644

{{ home_dir }}/.profile:
  file.managed:
    - source: salt://workstation/configs/.profile
    - user: wsmith
    - group: wsmith
    - mode: 644

{% endif %}


{{ home_dir}}/.vimrc:
  file.managed:
    - source: salt://config_files/.vimrc
    - user: wsmith
    - group: wsmith

{{ home_dir}}/.gitconfig:
  file.managed:
    - source: salt://config_files/.gitconfig
    - user: wsmith
    - group: wsmith

{{ home_dir}}/bin:
  file.directory:
    - user: wsmith
    - group: wsmith
    - makedirs: True


