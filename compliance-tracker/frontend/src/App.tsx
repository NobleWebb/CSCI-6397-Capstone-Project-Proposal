import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<div>Dashboard - to be implemented</div>} />
        <Route path="/controls" element={<div>Controls - to be implemented</div>} />
      </Routes>
    </Router>
  );
}

export default App;
