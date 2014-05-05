vim:
  pkg.installed:
    {% if grains['os_family'] == 'RedHat' %}
    - name: vim-enhanced
    {% elif grains['os'] == 'Ubuntu' %}
    - name: vim
    {% endif %}

America/Los_Angeles:
  timezone.system

/root/.tmux.conf:
  file.managed:
    - source: salt://config_files/.tmux.conf

/root/.vimrc:
  file.managed:
    - source: salt://config_files/.vimrc
