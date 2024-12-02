require('dotenv').config(); // .env dosyasını yükler
const express = require('express');
const connectDB = require('./db/db'); // db.js dosyanız
const userRoutes = require('./routes/userRoutes');


const app = express();

app.use(express.json()); // JSON için middleware

// MongoDB Bağlantısı
connectDB();

app.use(express.json()); // JSON verilerini işlemek için

// Örnek rota
app.use('/api/users', userRoutes);


// PORT'u .env dosyasından al
const PORT = process.env.PORT; // Varsayılan 5000

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server is running on port ${PORT}`);
});