const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    const conn = await mongoose.connect(process.env.MONGO_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log(`MongoDB Connected`);

    // Unique index'i kaldırma işlemi
    const db = mongoose.connection;
    db.once('open', () => {
      db.collection('users').dropIndex('email_1', (err, result) => {
        if (err) {
          console.error("Index kaldırma hatası:", err);
        } else {
          console.log("Unique index kaldırıldı.");
        }
      });
    });

  } catch (error) {
    console.error(`Error: ${error.message}`);
    process.exit(1); // Uygulamayı durdur
  }
};

module.exports = connectDB;
