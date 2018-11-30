const { randomElement } = require('./array');
const MONTHS = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

const randomDay = () => Math.floor(Math.random() * 28);
const randomMonth = () => randomElement(MONTHS);
const year = 2019;

function randomDate() {
  const day = randomDay();
  const month = randomMonth();
  const mdy = `${month} ${day}, ${year}`;

  return { day, month, year, mdy };
}

module.exports = {
  MONTHS,
  randomMonth,
  randomDay,
  randomDate
};
