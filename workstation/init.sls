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

{% endif %}


{{ home_dir}}/.vimrc:
  file.managed:
    - source: salt://config_files/.vimrc

{{ home_dir}}/.gitconfig:
  file.managed:
    - source: salt://config_files/.gitconfig
