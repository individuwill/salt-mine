vim:
  pkg.installed:
    {% if grains['os_family'] == 'RedHat' %}
    - name: vim-enhanced
    {% elif grains['os'] == 'Ubuntu' %}
    - name: vim
    {% endif %}

  require:
    - file: /root/.vimrc

America/Los_Angeles:
  timezone.system

wsmith:
  user.present:
    - fullname: Will Smith
    - home: /home/wsmith
    - groups:
      - server-admins
    - require:
      - group: server-admins

server-admins:
  group.present

ssh:
  ssh_auth:
  - present
  - user: wsmith
  - source: salt://ssh/id_rsa.pub
  - require:
    - user: wsmith

/home/wsmith/.vimrc:
  file.managed:
    - source: salt://vim/.vimrc
    - require:
      - user: wsmith

/home/wsmith/.tmux.conf:
  file.managed:
    - source: salt://tmux/.tmux.conf
    - require:
      - user: wsmith

/root/.tmux.conf:
  file.managed:
    - source: salt://tmux/.tmux.conf

/root/.vimrc:
  file.managed:
    - source: salt://vim/.vimrc
