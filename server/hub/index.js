const { randomElement } = require('../utils/array');
const { MONTHS } = require('../utils/dates');
const promotions = require('./promotions.json');
const transactions = require('./transactions.json');
const _ = require('lodash');

const getCreditLine = (function() {
  const lines = [1000, 3000, 6000, 10000];
  return () => randomElement(lines);
})();

const getPaymentDate = (function() {
  const getDay = () => Math.floor(Math.random() * 28);

  return () => `${randomElement(MONTHS)} ${getDay()}, 2019`;
})();

const getHubData = (req, res) => {
  const creditLine = getCreditLine();
  const balance = Number((Math.random() * creditLine).toFixed(2));
  const availableCredit = Number((creditLine - balance).toFixed(2));
  const paymentDate = getPaymentDate();
  const minimumPaymentDue = Number((Math.random() * balance).toFixed(2));
  const lastStatementBalance = Number((Math.random() * balance).toFixed(2));

  const delay = getDelay(10);

  setTimeout(() => {
    const results = {
      timestamp: Date.now(),
      creditLine,
      balance,
      availableCredit,
      paymentDate,
      minimumPaymentDue,
      lastStatementBalance
    };

    res.json(results);
  }, delay);
};

function getDelay(seconds = 10) {
  return Math.max(Math.floor(seconds * 1000 * Math.random()), 500);
}

function getPromotions(req, res) {
  const delay = getDelay(10);

  setTimeout(() => {
    res.json({
      timestamp: Date.now(),
      promotions
    });
  }, delay);
}

function getTransactions(req, res) {
  const page = Math.max(_.get(req, 'query.page', 0) - 1, 0);
  const index = page * 10;
  const slice = transactions.slice(index, index + 10);
  const delay = getDelay(10);

  setTimeout(() => {
    res.json({
      index,
      timestamp: Date.now(),
      total: transactions.length,
      lastPage: Math.floor(transactions.length / 10),
      transactions: slice
    });
  }, delay);
}

function getAllTransactions(req, res) {
  res.json({
    timestamp: Date.now(),
    total: transactions.length,
    transactions
  });
}

module.exports = {
  getHubData,
  getPromotions,
  getTransactions,
  getAllTransactions
};
