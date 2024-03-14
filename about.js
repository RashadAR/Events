const express = require('express');
const app = express();
const port = 3000;

// Set EJS as the view engine
app.set('view engine', 'ejs');

// Serve static files from the 'public' directory
app.use(express.static('public'));

// Route for rendering the about page
app.get('/about', (req, res) => {
    res.render('about');
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
