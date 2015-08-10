unzip:
  pkg.installed

curl:
  pkg.installed

makeJDKDir:
  cmd.run:
    - name: mkdir -p /usr/java

getJDK:
  cmd.run:
    - name: curl -b oraclelicense=accept-securebackup-cookie -L http://download.oracle.com/otn-pub/java/jdk/8u51-b16/jdk-8u51-linux-x64.tar.gz > jdk-8u51-linux-x64.tar.gz
    - cwd: /tmp/
    - require:
      - pkg: curl

unZipJDK:
  cmd.run:
    - name: tar -xzvf jdk-8u51-linux-x64.tar.gz -C /usr/java
    - cwd: /tmp
    - require:
      - pkg: unzip
      - cmd: makeJDKDir

/usr/java/latest:
  file.symlink:
    - target: /usr/java/jdk1.8.0_51
    - force: True

getJCE:
  cmd.run:
    - name: curl -b oraclelicense=accept-securebackup-cookie -L http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip > jce_policy-8.zip
    - cwd: /tmp/
    - require:
      - pkg: curl

unZipJCE:
  cmd.run:
    - name: unzip -o jce_policy-8.zip
    - cwd: /tmp/
    - require:
      - pkg: unzip
      - cmd: getJCE
      - cmd: unZipJDK
      - cmd: getJDK

moveJCE:
  cmd.run:
    - name: mv -f /tmp/UnlimitedJCEPolicyJDK8/*.jar /usr/java/latest/jre/lib/security/
    - cwd: /
    - require:
      - cmd: unZipJCE

java:
  require:
    - cmd: moveJCE
