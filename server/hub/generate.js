const fs = require('fs');
const path = require('path');
const randomName = require('random-name');

const { randomElement } = require('../utils/array');
const { randomDate, MONTHS } = require('../utils/dates');
const companies = require('./companies.json');
const ACTIVITY_TYPES = ['Payment', 'Purchase', 'Money sent fee', 'Refund'];

const getImageUrl = (function() {
  let id = 1084;
  return () => `https://picsum.photos/40/40?image=${id--}`;
})();

function sortByDate(array = []) {
  array.sort((x, y) => {
    const xMonth = MONTHS.indexOf(x.dateObj.month);
    const yMonth = MONTHS.indexOf(y.dateObj.month);

    if (xMonth !== yMonth) {
      return xMonth - yMonth;
    } else {
      return x.dateObj.day - y.dateObj.day;
    }
  });
}

const createPromo = (function() {
  function getDetails() {
    const dateObj = randomDate();
    if (Math.random() > 0.5) {
      return {
        title: 'No Interest',
        description: `if paid in full by ${dateObj.mdy}`,
        dateObj
      };
    } else {
      const numberOfPayments = Math.floor(Math.random() * 12);
      const remainingPayments = Math.floor(Math.random() * numberOfPayments);

      return {
        title: `${numberOfPayments} easy payments`,
        description: `${remainingPayments} remaining`,
        dateObj
      };
    }
  }

  return () => ({
    issuer: randomElement(companies),
    balance: (Math.random() * 1000).toFixed(2),
    img: getImageUrl(),
    ...getDetails()
  });
})();

function createPromos(count) {
  const promos = [];
  for (let i = 0; i < count; i++) {
    promos.push(createPromo());
  }
  sortByDate(promos);
  promos.reverse()
  return promos;
}

function createTransaction() {
  const dateObj = randomDate();
  return {
    dateObj,
    date: dateObj.mdy,
    title:
      Math.random() > 0.5
        ? randomElement(companies)
        : `${randomName.first()} ${randomName.last()}`,
    description: randomElement(ACTIVITY_TYPES),
    balance: (Math.random() * 1000).toFixed(2),
    status: Math.random() > 0.5 ? 'PENDING' : undefined,
    img: getImageUrl()
  };
}

function createTransactions(count) {
  const transactions = [];
  for (let i = 0; i < count; i++) {
    transactions.push(createTransaction());
  }
  sortByDate(transactions);
  transactions.reverse()
  return transactions;
}

const promotPath = path.resolve(__dirname, 'promotions.json');
const transPath = path.resolve(__dirname, 'transactions.json');

const promotions = createPromos(10);
const transactions = createTransactions(100);

fs.writeFileSync(promotPath, JSON.stringify(promotions, null, 2), 'utf-8');
fs.writeFileSync(transPath, JSON.stringify(transactions, null, 2), 'utf-8');
