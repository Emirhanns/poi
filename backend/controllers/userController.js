const User = require('../models/userModel');
const bcrypt = require('bcryptjs');

// Kullanıcı oluşturma
const registerUser = async (req, res) => {
  const { name, password, role, location } = req.body;

  try {
    // Kullanıcı zaten var mı kontrol et
    const userExists = await User.findOne({ name });
    if (userExists) {
      return res.status(400).json({ message: 'Kullanıcı zaten kayıtlı!' });
    }

    // Şifreyi hashle
    const hashedPassword = await bcrypt.hash(password, 10);

    // Yeni kullanıcı oluştur
    const user = await User.create({
      name,
      password: hashedPassword,
      role,
      location,
    });

    res.status(201).json({ message: 'Kullanıcı oluşturuldu', user });
  } catch (error) {
    res.status(500).json({ message: 'Hata oluştu', error: error.message });
  }
};

// Kullanıcı giriş
const loginUser = async (req, res) => {
  const { name, password } = req.body;

  try {
    // Kullanıcı kontrolü
    const user = await User.findOne({ name });
    if (!user) {
      return res.status(404).json({ message: 'Kullanıcı bulunamadı' });
    }

    // Şifre kontrolü
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: 'Şifre yanlış' });
    }

   

    res.status(200).json({ message: 'Giriş başarılı'});
  } catch (error) {
    res.status(500).json({ message: 'Hata oluştu', error: error.message });
  }
};

// Kullanıcı güncelleme
const updateUser = async (req, res) => {
  const { id } = req.params;
  const updates = req.body;

  try {
    const user = await User.findByIdAndUpdate(id, updates, { new: true });

    if (!user) {
      return res.status(404).json({ message: 'Kullanıcı bulunamadı' });
    }

    res.status(200).json({ message: 'Kullanıcı güncellendi', user });
  } catch (error) {
    res.status(500).json({ message: 'Hata oluştu', error: error.message });
  }
};

// Kullanıcı silme
const deleteUser = async (req, res) => {
  const { id } = req.params;

  try {
    const user = await User.findByIdAndDelete(id);

    if (!user) {
      return res.status(404).json({ message: 'Kullanıcı bulunamadı' });
    }

    res.status(200).json({ message: 'Kullanıcı silindi', user });
  } catch (error) {
    res.status(500).json({ message: 'Hata oluştu', error: error.message });
  }
};

module.exports = { registerUser, loginUser, updateUser, deleteUser };
