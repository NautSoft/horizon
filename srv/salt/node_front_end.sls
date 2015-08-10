

npminstall:
  cmd.run:
    - name: npm install
    - cwd: /aws_api_lambda_local/api
    - require:
      - pkg: nodejs
      - pkg: npm
      - pkg: build-essential
      - cmd: npmConfig
      - cmd: nodeInspector

startapp:
  cmd.run:
    - name: screen -dmS aws_api nohup node-debug --debug-port 5959 src/server >> logfile.log
    - cwd: /aws_api_lambda_local/front_end/front_end_app
    - require:
      - pkg: screen
