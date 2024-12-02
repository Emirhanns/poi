const express = require('express');
const router = express.Router();
const {
  registerUser,
  loginUser,
  updateUser,
  deleteUser,
} = require('../controllers/userController');

// Kullanıcı oluşturma
router.post('/register', registerUser);

// Kullanıcı giriş
router.post('/login', loginUser);

// Kullanıcı güncelleme
router.put('/:id', updateUser);

// Kullanıcı silme
router.delete('/:id', deleteUser);

module.exports = router;
