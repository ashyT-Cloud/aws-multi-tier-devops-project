const express = require('express');
const db = require('./db');

const app = express();

app.use(express.json());

app.get('/', (req, res) => {
  res.send('Fitness Tracker Running');
});

app.get('/workouts', (req, res) => {

  db.query(
    'SELECT * FROM workouts',
    (err, results) => {

      if (err) {
        return res.status(500).send(err);
      }

      res.json(results);
    }
  );
});

app.listen(3000, () => {
  console.log('Server started on port 3000');
});
