'use strict';
const http = require('http');
var assert = require('assert');
const express= require('express');
const app = express();
const mustache = require('mustache');
const filesystem = require('fs');
const url = require('url');
const hbase = require('hbase-rpc-client');
const hostname = '127.0.0.1';
const port = 30000;

var client = hbase({
    zookeeperHosts: ["localhost:2181"],
    zookeeperRoot: "/hbase"
});

client.on('error', function(err) {
  console.log(err)
})

console.log('Starting app...')

app.use(express.static('public'));


app.get('/conditions.html',function (req, res) {

    const scan = client.getScanner("twosides_conditions");
    scan.toArray(function(err, rows) {
      assert.ok(!err, "get returned an error: #{err}");
      if(!rows){
        res.send("<html><body>Couldn't find any matches.</body></html>");
        return;
      }

      var renderedRows = rows.map(function(row) {
        console.log(row.cols)
          return {
              condition_name : row.cols["c:condition_name"].value.toString(),
              count : row.cols["c:count"].value.toString(),
              mean_prr : Number.parseFloat(row.cols["c:mean_prr"].value).toFixed(2),
              mean_prr_err : Number.parseFloat(row.cols["c:mean_prr_err"].value).toFixed(2),
              mean_reporting_frequency : Number.parseFloat(row.cols["c:mean_reporting_frequency"].value).toFixed(4)
          }
      });

      var template = filesystem.readFileSync("conditions.mustache").toString(); 
      var html = mustache.render(template,  {
          rows : renderedRows 
      }); 
      res.send(html); 

    });
});

console.log('Listening on port ' + port)  
app.listen(port);

