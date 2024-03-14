const express = require('express');
const mysql = require('mysql');
const app = express();
const port = 3000;

// MySQL connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'your_username',
  password: 'your_password',
  database: 'cems' // Change to your database name
});

db.connect((err) => {
  if (err) {
    throw err;
  }
  console.log('Connected to MySQL database');
});

// Set up EJS as the view engine
app.set('view engine', 'ejs');

// Route for fetching student details
app.get('/student-details', (req, res) => {
  const query = `
    SELECT p.usn, p.name, p.branch, p.sem, p.email, p.phone, p.college, e.event_title
    FROM events e
    INNER JOIN registered r ON e.event_id = r.event_id
    INNER JOIN participent p ON r.usn = p.usn
    ORDER BY e.event_title
  `;
  
  db.query(query, (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).send('Internal server error');
      return;
    }

    res.render('student-details', { students: result });
  });
});

// Start server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
