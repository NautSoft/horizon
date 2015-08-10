mkDynamoDBdir:
  cmd.run:
    - name: mkdir -p /var/dynamodb_local

localdynamodb:
  cmd.run:
    - name: screen -dmS dynamodb nohup /usr/java/latest/bin/java -Djava.library.path=. -jar DynamoDBLocal.jar >> dynamodb.log
    - cwd: /var/dynamodb_local
    - require:
      - cmd: getJar
      - cmd: unZip
      - pkg: screen
      - cmd: mkDynamoDBdir

getJar:
  cmd.run:
    - name: wget http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz
    - cwd: /tmp/

unZip:
  cmd.run:
    - name: tar -xzvf /tmp/dynamodb_local_latest.tar.gz -C /var/dynamodb_local
    - cwd: /tmp/
    - require:
      - cmd: mkDynamoDBdir
