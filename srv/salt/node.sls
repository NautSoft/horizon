nodejs:
  pkg.installed

npm:
  pkg.installed

build-essential:
  pkg.installed

screen:
  pkg.installed

npmLatestAddApt:
  cmd.run:
    - name: add-apt-repository ppa:chris-lea/node.js -y

aptGetUpdate:
  cmd.run:
    - name: apt-get update
    - require:
      - cmd: npmLatestAddApt

aptGetInstallNewNode:
  cmd.run:
    - name: apt-get install nodejs -y
    - require:
      - cmd: aptGetUpdate

nodeInspector:
  cmd.run:
    - name: npm install node-inspector -g
    - require:
      - cmd: npmConfig

npmConfig:
  cmd.run:
    - name: npm config set registry http://registry.npmjs.org/
    - require:
      - pkg: nodejs
      - pkg: npm
      - pkg: build-essential
      - cmd: aptGetInstallNewNode

npminstall:
  cmd.run:
    - name: npm install
    - cwd: /aws_api_lambda_local/local_aws_api
    - require:
      - pkg: nodejs
      - pkg: npm
      - pkg: build-essential
      - cmd: npmConfig
      - cmd: nodeInspector

startapp:
  cmd.run:
    - name: screen -dmS aws_api nohup node-debug --debug-port 5858 app.js >> logfile.log
    - cwd: /aws_api_lambda_local/api
    - require:
      - pkg: screen
