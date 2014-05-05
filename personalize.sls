{% if grains['kernel'] == 'Linux' %}
  {% set home_dir = '/home/wsmith' %}
{% elif grains['kernel'] == 'Darwin' %}
  {% set home_dir = '/Users/wsmith' %}
{% endif %}

wsmith:
  user.present:
    - fullname: Will Smith
    - home: {{ home_dir }}

ssh:
  ssh_auth:
  - present
  - user: wsmith
  - source: salt://config_files/id_rsa.pub
  - require:
    - user: wsmith

{{ home_dir}}/.vimrc:
  file.managed:
    - source: salt://config_files/.vimrc
    - require:
      - user: wsmith

{{ home_dir}}/.gitconfig:
  file.managed:
    - source: salt://config_files/.gitconfig
    - require:
      - user: wsmith

{{ home_dir }}/.tmux.conf:
  file.managed:
    - source: salt://config_files/.tmux.conf
    - require:
      - user: wsmith

git:
  pkg.installed

{% if grains['os'] == 'Ubuntu' %}
tmux:
  pkg.installed:
{% elif grains['os_family'] == 'RedHat' %}
{% endif %}
