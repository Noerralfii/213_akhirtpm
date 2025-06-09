import express from 'express';
import db from '../db.js';
import verifyToken from '../middleware/verifytoken.js';

const router = express.Router();

router.get('/', (req, res) => {
  db.query('SELECT * FROM products', (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
});

router.post('/', verifyToken, (req, res) => {
  const { name, category, price, stock } = req.body;
  db.query(
    'INSERT INTO products (name, category, price, stock) VALUES (?, ?, ?, ?)',
    [name, category, price, stock],
    (err) => {
      if (err) return res.status(500).json({ error: err });
      res.json({ message: 'Product added' });
    }
  );
});

router.put('/:id', verifyToken, (req, res) => {
  const { name, category, price, stock } = req.body;
  db.query(
    'UPDATE products SET name=?, category=?, price=?, stock=? WHERE id=?',
    [name, category, price, stock, req.params.id],
    (err) => {
      if (err) return res.status(500).json({ error: err });
      res.json({ message: 'Product updated' });
    }
  );
});

router.delete('/:id', verifyToken, (req, res) => {
  db.query('DELETE FROM products WHERE id=?', [req.params.id], (err) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: 'Product deleted' });
  });
});

export default router;
