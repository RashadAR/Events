const express = require('express');
const mysql = require('mysql');
const app = express();
const port = 3000;

// MySQL connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'your_username',
  password: 'your_password',
  database: 'your_database'
});

db.connect((err) => {
  if (err) {
    throw err;
  }
  console.log('Connected to MySQL database');
});

// Set EJS as the view engine
app.set('view engine', 'ejs');

// Route for fetching event details
app.get('/event-details', (req, res) => {
  const query = `
    SELECT e.event_title, e.event_price, e.participents, st.st_name AS student_coordinator, s.name AS staff_coordinator, ef.Date, ef.time, ef.location
    FROM events e
    INNER JOIN event_info ef ON e.event_id = ef.event_id
    INNER JOIN student_coordinator st ON e.event_id = st.event_id
    INNER JOIN staff_coordinator s ON e.event_id = s.event_id
  `;

  db.query(query, (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).send('Internal server error');
      return;
    }

    res.render('event-details', { events: result });
  });
});
// Route for rendering event details page
app.get('/event-details', (req, res) => {
    const query = `
        SELECT e.event_title, e.event_price, e.participents, st.st_name AS student_coordinator, s.name AS staff_coordinator, ef.Date, ef.time, ef.location
        FROM events e
        INNER JOIN event_info ef ON e.event_id = ef.event_id
        INNER JOIN student_coordinator st ON e.event_id = st.event_id
        INNER JOIN staff_coordinator s ON e.event_id = s.event_id
    `;

    db.query(query, (err, result) => {
        if (err) {
            console.error(err);
            res.status(500).send('Internal server error');
            return;
        }

        res.render('event-details', { events: result });
    });
});
// Route for rendering contact us page
app.get('/contact-us', (req, res) => {
    const eventData = {
        eventEmail: 'event@gmail.com',
        eventMobile: '9123456789',
        exampleEmail: 'example@gmail.com',
        exampleMobile: '9876543210'
    };

    res.render('contact-us', eventData);
});
// Route for rendering create event form page
app.get('/create-event', (req, res) => {
    res.render('create-event-form');
});
// Route for handling form submission
app.post('/create-event', (req, res) => {
    const { event_id, event_title, event_price, img_link, type_id, sname, st_name, Date, time, location } = req.body;

    // Validate form data
    if (!event_id || !event_title || !event_price || !img_link || !type_id || !sname || !st_name || !Date || !time || !location) {
        return res.status(400).send('All fields are required');
    }

    // Insert data into the database
    const query = `
        INSERT INTO events (event_id, event_title, event_price, img_link, type_id)
        VALUES (?, ?, ?, ?, ?);
        INSERT INTO event_info (event_id, Date, time, location)
        VALUES (?, ?, ?, ?);
        INSERT INTO student_coordinator (sid, st_name, event_id)
        VALUES (?, ?, ?);
        INSERT INTO staff_coordinator (stid, name, event_id)
        VALUES (?, ?, ?);
    `;

    const values = [event_id, event_title, event_price, img_link, type_id, event_id, Date, time, location, event_id, st_name, event_id, event_id, sname, event_id];

    db.query(query, values, (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).send('Internal server error');
        }

        res.redirect('/adminPage');
    });
});


// Start server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
