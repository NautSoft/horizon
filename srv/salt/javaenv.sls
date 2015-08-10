jdk-config:
  file.managed:
    - name: /etc/profile.d/java.sh
    - source: salt://java.sh
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - context:
      java_home: /usr/java/latest
