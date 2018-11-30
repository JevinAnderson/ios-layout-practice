const express = require('express');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const _ = require('lodash');

const config = require('./config');
const endpoints = require('./endpoints');
const people = require('./people');
const hub = require('./hub');

const app = express();
app.use(morgan('dev'));
app.use(
  bodyParser.json({
    strict: false,
    type: req => true
  })
);

app.get('/people', people.getPeople);
app.get('/people/:id', people.getPerson);

app.get('/hub', hub.getHubData);
app.get('/transactions', hub.getTransactions);
app.get('/promotions', hub.getPromotions);

app.use((req, res) => {
  res.send(endpoints);
});

app.use((err, req, res, next) => {
  res.status(500).json({
    error: _.get(err, 'message', 'There was an error with your request.')
  });
});

app.listen(config.port, error => {
  if (error) {
    console.log('Application startup error', error);
    process.exit(-1);
  }

  console.log(
    `iOS layout test server started. Go to http://127.0.0.1:${
      config.port
    } in your browser.`
  );
});
