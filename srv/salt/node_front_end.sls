gulpInstall:
  cmd.run:
    - name: sudo npm install gulp -g
    - require:
      - cmd: npmConfig

npminstallFrontEnd:
  cmd.run:
    - name: npm install
    - cwd: /aws_api_lambda_local/front_end/front_end_app
    - require:
      - pkg: nodejs
      - pkg: npm
      - pkg: build-essential
      - cmd: npmConfig
      - cmd: nodeInspector
      - cmd: gulp

startappFrontEnd:
  cmd.run:
    # Launch with the following line to debug
    # - name: screen -dmS aws_api nohup node-debug --debug-port 5959 src/server >> logfile.log
    - name: screen -dmS aws_front_end nohup gulp -p src/server >> logfile.log
    - cwd: /aws_api_lambda_local/front_end/front_end_app
    - require:
      - pkg: screen
