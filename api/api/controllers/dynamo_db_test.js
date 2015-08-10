'use strict';
var util = require('util');
var ddt = require('dynamodb_test');

module.exports = {
  db_test: db_test
};

function db_test(req, res) {
  // variables defined in the Swagger document can be referenced using req.swagger.params.{parameter_name}
  var value = req.swagger.params.value.value || 'blah';
  var result = ddt(value);

  res.json(result);
}
