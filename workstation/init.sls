{% if grains['kernel'] == 'Linux' %}
  {% set home_dir = '/home/wsmith' %}
{% elif grains['kernel'] == 'Darwin' %}
  {% set home_dir = '/Users/wsmith' %}
{% endif %}

{% if grains['os'] == 'Ubuntu' %}
build-essential:
  pkg.installed

/root/.vimrc:
  file.managed:
    - source: salt://config_files/.vimrc

/etc/default/keyboard:
  file.replace:
    - pattern: XKBOPTIONS=""
    - repl: XKBOPTIONS="shift:both_capslock,ctrl:nocaps"

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


