var express = require('express');
var app = express();
var queueMessageTransfer = require('../queue_message_transfer');

app.get('/', function(req, res) {
  res.send('Hello World!');
});

app.post('/queueMessageTransfer', function(req, res, region, from_queue, to_queue) {
  res.send(queueMessageTransfer.tranfer(region, from_queue, to_queue));
});


var server = app.listen(3000, function() {
  var host = server.address().address;
  var port = 3000;

  console.log('Api app listening at http://%s:%s', host, port);
});
