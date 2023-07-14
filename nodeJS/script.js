const axios = require('axios');

const sendNotification = async () => {
  try {
    const response = await axios.post('http://127.0.0.1:4000/testing-ed3a6/asia-south1/onDmMessageCreated');
    console.log('Notification sent successfully');
    console.log(response.data);
  } catch (error) {
    console.error('Error sending notification:', error);
  }
};

sendNotification();