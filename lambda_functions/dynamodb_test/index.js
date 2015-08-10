var doc = require('dynamodb-doc');
var AWS = require('aws-sdk');

AWS.config.update({region: "us-east-1"});
var dynamo = new doc.DynamoDB({endpoint: new AWS.Endpoint('http://localhost:8000')});

function logger(err, data) {
  if(err) {
    console.log(err);
  } else {
    console.log(data);
  }
}

exports.handler = function(event, context){
  var params = {};
  params.TableName = "TestDB";
  params.Item = {Value: event.value};
  dynamo.putItem(params, logger);

  params = {};
  params.TableName = "TestDB";
  params.Item = {Value: event.value};

  dynamo.getItem(params, function(err, data) {
    if (err) {
      console.log(err, err.stack);
    } else {
      console.log(data);
      context.succeed(data);
    }
  });
};
