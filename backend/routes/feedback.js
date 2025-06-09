import express from 'express';
import db from '../db.js'; // pastikan file `db.js` juga menggunakan export default

const router = express.Router();

router.post('/', (req, res) => {
  const { name, comment } = req.body;
  db.query('INSERT INTO feedback (name, comment) VALUES (?, ?)', [name, comment], (err) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Feedback submitted' });
  });
});

export default router;
