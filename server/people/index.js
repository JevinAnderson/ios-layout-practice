const people = require('./people.json');

function getPeople(req, res) {
  res.json(people);
}

function getPerson(req, res) {
  const person = people.find(element => {
    const match = element.id == req.params.id;
    return match;
  });

  res.json(person);
}

module.exports = {
  getPeople,
  getPerson
};
