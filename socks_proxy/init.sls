sockd:
  service:
    - running
    - enable: True
    - require:
      - pkg: dante-server
      - file: /etc/sockd.conf
      - user: socks
      - user: socks-user

dante-server:
  pkg.installed:
    - require:
      - file: /var/log/sockd
      - pkg: rpmforge-release
      - iptables: dante-fw

rpmforge-release:
  pkg.installed:
    - sources:
      - rpmforge-release: http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm

dante-fw:
  iptables.insert:
    - position: 1
    - table: filter
    - chain: INPUT
    - match: state
    - j: ACCEPT
    - connstate: NEW,ESTABLISHED
    - dport: 1080
    - proto: tcp
    - save: True

socks-user:
  user.present:
    # $0cks5
    - password: $6$rounds=100000$/VoZjsm2aOrTVNxk$.HAapK6fQS5gYL0spFHR8PVPQKBcjVCHKbWIRSQOfp5GV.BuBmJsGpSs2b0oNUIXlUH/waosfU7ptX4e0ib5a0

socks:
  user.present

/var/log/sockd:
  file.directory:
  - makedirs: True

/etc/sockd.conf:
  file.managed:
    - source: salt://socks_proxy/sockd.conf
    - require:
      - pkg: dante-server
