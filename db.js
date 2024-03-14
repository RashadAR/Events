const mysql = require('mysql');

// Create a connection pool
const pool = mysql.createPool({
    connectionLimit: 10,
    host: 'localhost',
    user: 'your_username',
    password: 'your_password',
    database: 'your_database'
});

// Get the event ID from the query string
const eventId = req.query.id;

// Define the SQL query to delete records
const sql = `
    DELETE FROM events WHERE event_id = ?;
    DELETE FROM event_info WHERE event_id = ?;
    DELETE FROM staff_coordinator WHERE event_id = ?;
    DELETE FROM student_coordinator WHERE event_id = ?;
    DELETE FROM registered WHERE event_id = ?;
`;

// Execute the query
pool.getConnection((err, connection) => {
    if (err) {
        console.error('Error getting connection from pool:', err);
        return res.status(500).send('Internal server error');
    }

    connection.query(sql, [eventId, eventId, eventId, eventId, eventId], (err, results) => {
        connection.release(); // Release the connection

        if (err) {
            console.error('Error executing query:', err);
            return res.status(500).send('Internal server error');
        }

        console.log('Event deleted successfully');
        res.redirect('/adminPage.php');
    });
});
