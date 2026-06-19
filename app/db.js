const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'fitness-db.c0lie0y2on4z.us-east-1.rds.amazonaws.com',
  user: 'admin',
  password: 'ChangeMe123!',
  database: 'fitnessdb'
});

connection.connect((err) => {
  if (err) {
    console.log('Database connection failed');
    console.log(err);
  } else {
    console.log('Connected to RDS');
  }
});

module.exports = connection;
