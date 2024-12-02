const mongoose = require('mongoose');

const userSchema = mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
      unique: true, // Unique olarak işaretlendi

    },
    password: {
      type: String,
      required: true,
    },
    role: {
      type: String,
      default: 'user', // Varsayılan rol 'user'
    },
    location: {
      type: String,
      required: false,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model('User', userSchema);
