// server.js - starts the HTTP server.
// All application logic lives in app.js; this file only binds to a port.

const app = require('./app');

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT} in ${process.env.NODE_ENV || 'development'} mode`);
});
