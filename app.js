var express = require('express');
var app = express();
var csv = require('express-csv');
var path    = require("path");
var bodyParser = require('body-parser');


app.use('/static', express.static('client'));
app.use(bodyParser());

app.get('/', function (req, res) {
  res.sendFile(path.join(__dirname+'/index.html'));
});

app.post('/export', function (req, res) {
  if (typeof req.body.finishers !== 'undefined') {
  	var finishers = req.body.finishers.split(',');
  	var results = [['Place', 'Time',]];
  	for (var x in finishers) {
  		results.push([parseInt(x)+1, finishers[x]]);
  	}
    res.attachment('results.csv');
    res.csv(results);
  } else {
  	res.send('There was an error creating your download results');
  }
});

var port = 3000;
if (process.env.PORT) {
  port = process.env.PORT;
}
app.listen(port, function () {
  console.log('Example app listening on port ' + port + '!');
});
