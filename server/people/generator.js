const path = require('path');
const fs = require('fs');
const randomName = require('random-name');
const loremIpsum = require('lorem-ipsum');

const getImageUrl = (function() {
  let id = 1084;
  return () => `https://picsum.photos/200/300?image=${id--}`;
})();

const getPersonId = (() => {
  let id = 1;

  return () => id++;
})();

function Person() {
  return {
    id: getPersonId(),
    first: randomName.first(),
    middle: randomName.middle(),
    last: randomName.last(),
    place: randomName.place(),
    description: loremIpsum({
      count: 3,
      format: 'plain',
      paragraphLowerBound: 3,
      paragraphUpperBound: 7,
      units: 'paragraphs'
    }),
    image: getImageUrl()
  };
}

function getPeople(count) {
  const people = [];
  for (let i = 0; i < count; i++) {
    const person = new Person();
    people.push(person);
  }

  return people;
}

const people = getPeople(200);
const data = JSON.stringify(people, null, 2);
const target = path.resolve(__dirname, 'people.json');

fs.writeFileSync(target, data, 'utf-8');
